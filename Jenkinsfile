pipeline {
    agent any

    environment {
        // DockerHub info
        DOCKER_USER = "balamaniraja"
        FRONT_IMAGE = "react-frontend"
        BACK_IMAGE  = "django-backend"

        // Path to docker-compose.yml
        DOCKER_COMPOSE_PATH = '/home/ubuntu/React-Django/docker-compose.yml'
    }

    stages {
        stage('Checkout') {
            steps {
                // Checkout the repo
                git branch: 'master', url: 'https://github.com/Balamanirajatech/React-Django.git'
            }
        }

        stage('Build Frontend') {
            steps {
                dir('frontend') {
                    sh "docker build -t $DOCKER_USER/$FRONT_IMAGE:latest ."
                }
            }
        }

        stage('Build Backend') {
            steps {
                dir('backend') {
                    sh "docker build -t $DOCKER_USER/$BACK_IMAGE:latest ."
                }
            }
        }

        stage('Push Images to DockerHub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',  // Add DockerHub credentials in Jenkins
                    usernameVariable: 'DOCKER_USER_VAR',
                    passwordVariable: 'DOCKER_PASS_VAR'
                )]) {
                    sh '''
                        echo $DOCKER_PASS_VAR | docker login -u $DOCKER_USER_VAR --password-stdin
                        docker push $DOCKER_USER/$FRONT_IMAGE:latest
                        docker push $DOCKER_USER/$BACK_IMAGE:latest
                    '''
                }
            }
        }

        stage('Deploy with Docker Compose') {
            steps {
                sh "docker-compose -f ${DOCKER_COMPOSE_PATH} pull"
                sh "docker-compose -f ${DOCKER_COMPOSE_PATH} up -d --build"
            }
        }
    }

    post {
        success {
            echo "CI/CD pipeline completed successfully! 🎉"
        }
        failure {
            echo "Pipeline failed! ❌ Check the logs for errors."
        }
    }
}
