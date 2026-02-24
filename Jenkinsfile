pipeline {
    agent any

    stages {
        stage('Clone Repo') {
            steps {
                git branch: 'main', url: 'https://github.com/smfardeen7/SWE645-HW2.git'
            }
        }

        stage('Build Simulation') {
            steps {
                echo 'Project cloned successfully'
                echo 'CI/CD pipeline executed'
            }
        }
    }
}
