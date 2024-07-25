pipeline {
    agent any
    tools {
        // Utilisez le nom que vous avez donné lors de la configuration de Docker comme outil
        docker 'docker'
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
        stage('Build Image') {
            steps {
                script {
                    sh 'docker --version'  // Vérifiez si Docker est accessible
                    sh 'docker build -t ${DOCKER_REGISTRY}/${IMAGE_NAME}:${TAG} .'
                }
            }
        }
        stage('Push Image') {
            steps {
                script {
                    withDockerRegistry([ credentialsId: 'docker-credentials-id', url: '' ]) {
                        sh 'docker push ${DOCKER_REGISTRY}/${IMAGE_NAME}:${TAG}'
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
