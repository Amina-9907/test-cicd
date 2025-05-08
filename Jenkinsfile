pipeline {
    agent any
   
    environment {
        APP_NAME= "react-example"
        // SONARQUBE_URL = 'http://192.168.15.115:9000'  
        // SONARQUBE_PROJECT_KEY = 'front'
        // SONARQUBE_AUTH_TOKEN = credentials('sonar-credential')
    }

    stages {

        stage('Install dependencies') {
            steps {
                echo " installer les dependances"
                sh 'npm install'
            }
        }
        
        stage('Build') {
            steps {
                echo " Build de l'application"
                sh 'npm run build'
            }
        }

        stage('test') {
            steps {
                echo " Execution des tests "
                sh 'npm test'
            }
        }

       
        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('sonarqube') {
                    script {
                        def scannerHome = tool 'SonarScanner'
                        sh "${scannerHome}/bin/sonar-scanner"
                    }
                }
            }
        }
        stage('build image Docker') {
            steps {
                script {
                    sh 'docker build -t mina0423/react_project:v1 .'
                }
            }
        }
        stage('push image Docker') {
            steps {
               withCredentials([usernamePassword(credentialsId: 'docker_registry', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    script {
                         sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                         sh "docker push mina0423/react_project:v1"
                    }
               }
            }
        }

        stage('Pull image docker') {
            steps {
                script {
                    sh 'docker pull  mina0423/react_project:v1 || echo "Image non trouvée "'
                }
            }
        } 

        
        stage('run container Docker') {
            steps {
                script {
                    sh 'docker stop react_project || true'
                    sh 'docker rm react_project || true'
                    sh 'docker run -d --name react_project -p 3000:80 mina0423/react_project:v1'
                }
            }
        }
               
    }

}
