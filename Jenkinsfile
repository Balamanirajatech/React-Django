pipeline {
  agent any

  environment {
    DOCKER_USER = "balamaniraja"
    FRONT_IMAGE = "react"
    BACK_IMAGE = "django"
  }

  stages {

    stage('Checkout Code') {
      steps {
        git credentialsId: 'github-creds',
            url: 'https://github.com/Balamanirajatech/React-Django.git'
      }
    }

    stage('Build Frontend') {
      steps {
        sh 'cd frontend && docker build -t $DOCKER_USER/$FRONT_IMAGE:latest .'
      }
    }

    stage('Build Backend') {
      steps {
        sh 'cd backend && docker build -t $DOCKER_USER/$BACK_IMAGE:latest .'
      }
    }

    stage('Push Images') {
      steps {
        withCredentials([usernamePassword(
          credentialsId: 'dockerhub-creds',
          usernameVariable: 'USER',
          passwordVariable: 'PASS'
        )]) {
          sh '''
            echo $PASS | docker login -u $USER --password-stdin
            docker push $DOCKER_USER/$FRONT_IMAGE:latest
            docker push $DOCKER_USER/$BACK_IMAGE:latest
          '''
        }
      }
    }

    stage('Deploy') {
      steps {
        sh '''
          docker-compose pull
          docker-compose up -d
        '''
      }
    }
  }
}
