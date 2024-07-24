pipeline {
    agent any
    environment {
        NODE_HOME = tool 'nodejs' // Assurez-vous que NodeJS est installé sur Jenkins
        PATH = "${env.NODE_HOME}/bin:${env.PATH}"

    }

    stages {
        stage('Build') { 
            steps {
                sh 'npm install' 
            }
        }
        stage('Test') {
            steps {
                sh './jenkins/scripts/test.sh'
            }
        }
        stage('Deliver') { 
            steps {
                sh './jenkins/scripts/deliver.sh' 
                input message: 'Finished using the web site? (Click "Proceed" to continue)' 
                sh './jenkins/scripts/kill.sh' 
            }
        }
    }
}
