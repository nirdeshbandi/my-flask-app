pipeline {
    agent any

    environment {
        PATH+EXTRA = "/usr/local/bin"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t nirdeshbandi/my-flask-app:latest .'
            }
        }

        stage('Test Docker Container') {
            steps {
                sh 'docker run -d --name test-container -p 5000:5000 nirdeshbandi/my-flask-app:latest'
                sh 'sleep 5'
                sh 'curl http://localhost:5000'
                sh 'docker stop test-container && docker rm test-container'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                    docker push nirdeshbandi/my-flask-app:latest
                    '''
                }
            }
        }
    }
}

