
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
                    powershell -NoProfile -Command "$ok = $false; for ($i = 0; $i -lt 12; $i++) { try { $r = Invoke-WebRequest 'http://localhost:8081/1.jsp' -TimeoutSec 3; if ($r.StatusCode -eq 200) { $ok = $true; break } } catch {}; Start-Sleep -Seconds 5 }; if (-not $ok) { docker logs java-web-container; exit 1 }"
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
