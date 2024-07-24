pipeline {
    agent any
    environment {
        DOCKER_REGISTRY = 'your-docker-registry'
        IMAGE_NAME = 'your-react-app'
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
                    docker.build("${env.DOCKER_REGISTRY}/${env.IMAGE_NAME}:${env.TAG}")
                }
            }
        }
        stage('Push Image') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-credentials-id') {
                        docker.image("${env.DOCKER_REGISTRY}/${env.IMAGE_NAME}:${env.TAG}").push()
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
