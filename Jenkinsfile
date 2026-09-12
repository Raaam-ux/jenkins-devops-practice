pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                echo 'Checking out source code...'
                checkout scm
            }
        }

        stage('Gitleaks Secret Scan') {
            steps {
                echo 'Running Gitleaks secret scan...'

                sh '''
                    docker run --rm \
                      -v "$WORKSPACE:/repo" \
                      zricethezav/gitleaks:latest \
                      detect --source=/repo --no-git
                '''
            }
        }

        stage('Maven Build') {
            steps {
                echo 'Building Java application with Maven...'

                sh '''
                    docker run --rm \
                      -v "$WORKSPACE:/workspace" \
                      -w /workspace \
                      maven:3.9-eclipse-temurin-17 \
                      mvn clean test
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }

        failure {
            echo 'Pipeline failed!'
        }

        always {
            echo 'Pipeline execution finished.'
        }
    }
}