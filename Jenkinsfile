pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'master',
                    credentialsId: 'github-token',
                    url: 'https://github.com/Balamanirajatech/React-Django.git'
            }
        }

        stage('Build') {
            steps {
                echo "Checkout successful"
            }
        }
    }
}
