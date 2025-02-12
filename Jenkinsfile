pipeline {
    agent { label 'build-node' }
    environment {
        DOCKER_REGISTRY = "docker.io"
        IMAGE_NAME = "obrenovicm/mr"
        IMAGE_TAG = "latest"
    }

    stages {
        stage('Checkout Source Code') {
            steps {
                git branch:'main', url: 'https://github.com/obrenovicm/devops-tasks.git'
            }
        }
        
        stage('Checkstyle') {
            steps {
                dir('jenkins') {
                    script {
                        sh 'gradle checkstyleMain'
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
