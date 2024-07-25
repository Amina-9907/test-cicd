pipeline {
    agent any
    environment {
        DOCKER_PATH = '/usr/bin/docker'  // Mettez ici le chemin vers Docker sur votre agent
        PATH = "${env.PATH}:${env.DOCKER_PATH}"
        DOCKER_REGISTRY = 'docker.io'
        IMAGE_NAME = 'fapathe/pipeline'
        TAG = 'latest'
    }
    stages {
        stage('Checkout') {
            steps {
                git 'https://github.com/fapathe/simple-node-js-react-npm-app.git'
            }
        }
        stage('Build Image') {
            steps {
                script {
                    sh 'docker --version'  // Vérifiez si Docker est accessible
                    docker.build("${env.IMAGE_NAME}:${env.TAG}")
                }
            }
        }
        stage('Push Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-credentials-id') {
                        docker.image("${env.IMAGE_NAME}:${env.TAG}").push()
                    }
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                    sh 'oc apply -f deploy/deployment.yaml'
                }
            }
        }
        stage('Verify Deployment') {
            steps {
                script {
                    sh 'oc get pods'
                    sh 'oc get svc'
                }
            }
        }
    }
    post {
        success {
            echo 'Déploiement réussi !'
        }
        failure {
            echo 'Le déploiement a échoué.'
        }
    }
}
