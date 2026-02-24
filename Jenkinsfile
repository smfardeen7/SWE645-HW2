// SWE645 HW2 - CI/CD Pipeline: build image, push to DockerHub, deploy to Kubernetes
// Docker Hub username: mfardeenshaik (image built and pushed in pipeline).
pipeline {
    agent any
    environment {
        DOCKERHUB_PASS = credentials('docker-pass')
        // Pipeline-only timestamp (no Build Timestamp plugin required)
        BUILD_TAG = "${new Date().format('yyyyMMdd-HHmmss')}"
    }
    stages {
        stage('Build Image') {
            steps {
                script {
                    checkout scm
                    sh 'rm -rf *.war'
                    sh 'jar -cvf StudentSurvey.war -C WebContent/ .'
                    sh "docker login -u mfardeenshaik -p ${DOCKERHUB_PASS}"
                    def customImage = docker.build("mfardeenshaik/studentsurvey645:${env.BUILD_TAG}")
                }
            }
        }
        stage('Push to DockerHub') {
            steps {
                script {
                    sh "docker push mfardeenshaik/studentsurvey645:${env.BUILD_TAG}"
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                sh "kubectl set image deployment/student-survey student-survey=mfardeenshaik/studentsurvey645:${env.BUILD_TAG} -n default"
            }
        }
    }
}
