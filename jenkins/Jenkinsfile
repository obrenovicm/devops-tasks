pipeline {
    agent { label 'build-node' }
    environment {
        DOCKER_REGISTRY = "docker.io"
        IMAGE_NAME = "obrenovicm/main"
        IMAGE_TAG = "agentv2"
    }

    stages {
        stage('Checkout Source Code') {
            steps {
                git branch:'main', url: 'https://github.com/obrenovicm/devops-tasks.git'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                dir('jenkins') {
                    script {
                        // Running the Docker build from the 'jenkins/' folder
                        sh 'docker build -t $IMAGE_NAME:$IMAGE_TAG .'
                    }
                }
            }
        }
        
        stage('Push Docker Image') {
            steps {
                script {
                    // Using Jenkins credentials to log in to Docker Hub
                    withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', 
                                                       usernameVariable: 'DOCKER_USERNAME', 
                                                       passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh 'docker login -u $DOCKER_USERNAME -p $DOCKER_PASSWORD $DOCKER_REGISTRY'
                        
                        // Push the Docker image to the registry
                        sh 'docker push obrenovicm/main:$IMAGE_TAG'
                    }
                }
            }
        }
    }

    post {
        always {
            echo 'Build completed.'
        }
        success {
            echo 'Build succeeded.'
        }
        failure {
            echo 'Build failed.'
        }
    }
}
