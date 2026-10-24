
pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                dir('java') {
                    bat 'mvn -B clean compile'
                }
            }
        }

        stage('Test') {
            steps {
                junit testResults: 'java/target/surefire-reports/*.xml', allowEmptyResults: true
            }
        }

        stage('Archive WAR') {
            steps {
                archiveArtifacts artifacts: 'java/target/*.war', fingerprint: true
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
