pipeline {
    agent any
    environment {
        NODE_HOME = tool 'nodejs' // Assurez-vous que NodeJS est installé sur Jenkins
        PATH = "${env.NODE_HOME}/bin:${env.PATH}"
        NPM_CONFIG_CACHE = "${env.WORKSPACE}/.npm" // Utilisez un répertoire de cache local
       
    }
    stages {
    
        stage('Install Dependencies') {
            steps {
                // Installer les dépendances de l'application React
                sh 'npm install'
            }
        }
        stage('Build') {
            steps {
                // Construire l'application React
                sh 'npm run build'
            }
        }
        stage('Deploy') {
            steps {
                script {
                    // Déployer l'application sur OpenShift
                    sh 'oc apply -f jenkins/scripts/deployment.yaml'
                }
            }
        }
        stage('Verify Deployment') {
            steps {
                script {
                    // Vérifier le déploiement
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
