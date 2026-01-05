pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    url: 'https://github.com/Balamanirajatech/React-Django-Projet.git'
            }
        }

        stage('Build') {
            steps {
                echo "Code checkout successful"
            }
        }
    }
}
