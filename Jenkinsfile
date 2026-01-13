pipeline {
  agent any

  environment {
    DOCKER_USER = "balamaniraja"
    FRONT_IMAGE = "react-frontend"
    BACK_IMAGE  = "django-backend"
    TAG = "${BUILD_NUMBER}"
  }

  stages {

    stage('Checkout') {
      steps {
        git credentialsId: 'github-creds', url: 'https://github.com/Balamanirajatech/React-Django.git'
      }
    }

    stage('Build Images') {
      steps {
        sh '''
          docker build -t $DOCKER_USER/$FRONT_IMAGE:$TAG frontend
          docker build -t $DOCKER_USER/$BACK_IMAGE:$TAG backend
        '''
      }
    }

    stage('Docker Login & Push') {
      steps {
        withCredentials([usernamePassword(
          credentialsId: 'dockerhub_id',
          usernameVariable: 'USER',
          passwordVariable: 'PASS'
        )]) {
          sh '''
            echo $PASS | docker login -u $USER --password-stdin
            docker push $DOCKER_USER/$FRONT_IMAGE:$TAG
            docker push $DOCKER_USER/$BACK_IMAGE:$TAG
          '''
        }
      }
    }

    stage('Deploy to EKS') {
      steps {
        sh '''
          # Configure kubectl for EKS
          aws eks update-kubeconfig --region ap-south-1 --name devops-cluster

          # Apply all YAML manifests (creates or updates deployments & services)
          kubectl apply -f K8s/

          # Update images with new tags
          kubectl set image deployment/frontend frontend=$DOCKER_USER/$FRONT_IMAGE:$TAG
          kubectl set image deployment/backend backend=$DOCKER_USER/$BACK_IMAGE:$TAG

          # Wait for rollout to complete
          kubectl rollout status deployment/frontend
          kubectl rollout status deployment/backend
        '''
      }
    }
  }
}
