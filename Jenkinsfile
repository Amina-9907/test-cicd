pipeline {
    agent {
        docker {
            image 'node:16'  // Spécifiez l'image Docker contenant Node.js
            args '-v /var/run/docker.sock:/var/run/docker.sock'  // Monter le socket Docker si nécessaire
        }
    }
    environment {
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
        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }
        stage('Build Image') {
            steps {
                script {
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
