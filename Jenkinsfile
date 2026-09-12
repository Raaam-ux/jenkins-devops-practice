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
            mvn clean package
        '''
    }
}   
     stage('Docker Push - Local Registry') {
    steps {
        echo 'Pushing Docker image to local registry...'

        sh '''
            docker tag \
              jenkins-devops-practice:latest \
              host.docker.internal:5000/jenkins-devops-practice:latest

            docker push \
              host.docker.internal:5000/jenkins-devops-practice:latest
        '''
    }
}
     stage('Generate SBOM') {
    steps {
        echo 'Generating SBOM...'

        sh '''
            docker run --rm \
              -v /var/run/docker.sock:/var/run/docker.sock \
              aquasec/trivy:latest \
              image \
              --format cyclonedx \
              jenkins-devops-practice:latest \
              > sbom.json

            echo "SBOM generated successfully"
            ls -lh sbom.json
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