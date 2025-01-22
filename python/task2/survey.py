import requests
import json
import os
import dotenv
import sys
import base64

import google.auth
from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow
from googleapiclient.discovery import build
from googleapiclient.errors import HttpError
from email.message import EmailMessage


api_base_url = 'http://api.surveymonkey.com/v3/'
dotenv.load_dotenv()
survey_token = os.getenv("SURVEY_TOKEN")

headers = {
        'Content-Type' : "application/json",
        'Accept' : "application/json",
        'Authorization' : f"Bearer {survey_token}"
}

SCOPES = ["https://www.googleapis.com/auth/gmail.send"]


def create_survey(title):

    url = f'{api_base_url}surveys'

    payload = {
        "title" : title
    }

    res = requests.post(url, json=payload, headers=headers)
    survey = res.json()

    if res.status_code == 201:
        print("Survey successfully created.")
        return survey['id'], survey['page_count']
    else:
        print("Error creating survey.")
        print(res.json())


def create_question(survey_id, questions, answers, page_id):

    url = f'{api_base_url}surveys/{survey_id}/pages/{page_id}/questions'

    for i in range(len(questions)):

        ans_payload = [{"text" : x} for x in answers[i]]

        payload = {
            "headings" : [{"heading" : questions[i]}],
            "family" : "single_choice",
            "subtype" : "vertical",
            "answers" : {"choices" : ans_payload}
        }

        res = requests.post(url, json=payload, headers=headers)

        if res.status_code == 201:
            tmp = res.json()
            print(f'Question created : {questions[i]} with ID {tmp["id"]} and answers : {answers[i]}')

        else:
            print(f'Error creating question : {questions[i]}')
            print(res.json())


def get_survey_page(survey_id):

    url = f'{api_base_url}surveys/{survey_id}/pages'

    res = requests.get(url=url, headers=headers)

    id = res.json()['data'][0]['id']
    return id

def create_collector(survey_id):
    
    url = f'{api_base_url}surveys/{survey_id}/collectors'

    payload = {
        "type" : 'weblink',
        "name" : "weblink collector"
    }

    res = requests.post(url, json=payload, headers=headers)


    if res.status_code == 201:
        print("Collector successfully created")

        collector_id = res.json()['id']
        url = res.json()['url']
        return collector_id, url
    
    else:
        print("Failed to create collector.")
        print(res.json())
        return None
    
    
def parse_questions(file):

    with open(file, 'r') as f:
        data = json.load(f)

    survey_name = list(data.keys())[0]

    questions = []
    answers = []

    for page_name, q in data[survey_name].items():
        page_info = {
            "Page_name" : page_name
        }

        for q_name, q_data in q.items():
            q_payload = {
                "Question_name" : q_name,
                "Description" : q_data["Description"],
                "Answers" : q_data["Answers"]
            }

            questions.append(q_payload["Description"])
            answers.append(q_payload["Answers"])

    return survey_name, questions, page_info, answers

if __name__ == '__main__':

    # format args with parser later TODO
    input_json = sys.argv[1]
    emails = sys.argv[2]

    survey_name, questions, page_info, answers = parse_questions(input_json)

    survey_id, page_count = create_survey(survey_name) 

    page_id = get_survey_page(survey_id=survey_id)

    create_question(survey_id=survey_id, questions=questions, answers=answers, page_id=page_id)

    collector_id, url = create_collector(survey_id=survey_id)

    print(f"Collector id : {collector_id} ; URL : {url}")

    #-------------------------------------------------------------------------------------------#
    #-------------------------- MAIL STUFF -----------------------------------------------------#
    #-------------------------------------------------------------------------------------------#


    creds = None

    if os.path.exists("token.json"):
        # token.json stores the user's access and refresh tokens.
        creds = Credentials.from_authorized_user_file("token.json", SCOPES)

    if not creds or not creds.valid:
        if creds and creds.expired and creds.refresh_token:
            creds.refresh(Request())
        
        else:
            flow = InstalledAppFlow.from_client_secrets_file("google-creds.json", SCOPES)
            creds = flow.run_local_server(port=0)
        
        with open("token.json", "w") as token:
            token.write(creds.to_json())

    try:
        # call the gmail API
        service = build("gmail", "v1", credentials=creds)
        message = EmailMessage()

        message.set_content(f'Survey link for SurveyMonkey Task : {url}')

        message["To"] = "mobrenovic@griddynamics.com"
        message["From"] = "mobrenovic@griddynamics.com"
        message["Subject"] = "Draft email"

        # encoded msg
        encoded_message = base64.urlsafe_b64encode(message.as_bytes()).decode()

        create_message = {"raw" : encoded_message}


        send_message = service.users().messages().send(userId="me", body=create_message).execute()
        print(f"Message ID : {send_message['id']}")
        
    except HttpError as err:
        print(f"An error occured : {err}")
        send_message = None

    