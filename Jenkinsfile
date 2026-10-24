
pipeline {
    agent any

    tools {
        maven 'Maven3'
    }

    triggers {
        pollSCM('H/2 * * * *')
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

        stage('Build Docker Image') {
            steps {
                bat 'docker build -t java-web-app:%BUILD_NUMBER% .'
            }
        }

        stage('Deploy') {
            steps {
                bat '''
                    docker rm -f java-web-container 2>NUL || ver >NUL
                    docker run -d --name java-web-container -p 8081:8080 java-web-app:%BUILD_NUMBER%
                '''
            }
        }

        stage('Verify Deployment') {
    steps {
        bat '''
            powershell -NoProfile -Command "try { $r = Invoke-WebRequest 'http://localhost:8081/1.jsp' -UseBasicParsing -TimeoutSec 10; if ($r.StatusCode -ne 200) { exit 1 }; Write-Host 'Deployment verified: HTTP 200 OK' } catch { Write-Host $_; exit 1 }"
        '''
       }
     }
    }

    post {
        success {
            echo 'CI/CD successful: application built, deployed, and verified.'
        }
        failure {
            echo 'Pipeline failed. Check the stage logs before retrying.'
        }
    }
}
