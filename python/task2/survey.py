import requests
import json
import os
import dotenv
import sys

api_base_url = 'https://api.surveymonkey.com/v3'
dotenv.load_dotenv()
survey_token = os.getenv("SURVEY_TOKEN")

headers = {
        'Content-Type' : "application/json",
        'Accept' : "application/json",
        'Authorization' : f"Bearer {survey_token}"
}


def create_survey():
    url = f'{api_base_url}surveys'

    payload = {
        "title" : "New Survey"
    }

    res = requests.post(url, json=payload, headers=headers)
    survey = res.json()

    if res.status_code == 201:
        print("Survey sucessfuly created.")
        return survey['id']
    else:
        print("Error creating survey.")
        print(res.json())


def create_question(survey_id, question_text, answers):

    url = f'{api_base_url}surveys/{survey_id}/pages/1/questions'

    ans_payload = [{"text" : x} for x in answers]
    payload = {
        "headings" : [{"heading" : question_text}],
        "family" : "single_choice",
        "subtype" : "vertical",
        "answers" : {"choices" : ans_payload}
    }

    res = requests.post(url, json=payload, headers=headers)
    if res.status_code == 201:
        print(f'Question created : {question_text}')
    else:
        print(f'Error creating question : {question_text}')
        print(res.json())

    
def parse_questions(file):

    with open(file, 'r') as f:
        data = json.load(f)

    survey_name = list(data.keys())[0]

    questions = []

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

            questions.append(q_payload)

    return survey_name, questions, page_info

if __name__ == '__main__':

    # format args with parser later TODO
    questions = sys.argv[1]
    emails = sys.argv[2]

    # survey_id = create_survey()
