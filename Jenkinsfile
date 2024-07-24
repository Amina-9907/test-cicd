pipeline {
    agent {
        label 'openshift' // Assurez-vous que ce label correspond à votre configuration Jenkins sur OpenShift
    }
    environment {
        NODE_HOME = tool name: 'nodejs', type: 'NodeJSInstallation'
        PATH = "${env.NODE_HOME}/bin:${env.PATH}"
        NPM_CONFIG_CACHE = "${env.WORKSPACE}/.npm"
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
        stage('Deploy') {
            steps {
                script {
                    openshift.withCluster() {
                        openshift.withProject('aap') {
                            // Appliquer le déploiement depuis le fichier YAML
                            openshift.apply(file: 'deployment.yaml')
                            
                            // Exposer le service
                            openshift.expose('svc/testapp')
                        }
                    }
                }
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
