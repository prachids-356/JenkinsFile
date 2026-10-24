
pipeline {
    agent any

    tools {
        maven 'Maven3'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                bat 'mvn -B clean package'
            }
        }

        stage('Test') {
            steps {
                junit testResults: 'target/surefire-reports/*.xml',
                      allowEmptyResults: true
            }
        }

        stage('Archive WAR') {
            steps {
                archiveArtifacts artifacts: 'target/*.war',
                                 fingerprint: true
            }
        }
    }

    post {
        success {
            echo 'Maven build completed successfully.'
        }
        failure {
            echo 'Maven build failed.'
        }
    }
}
