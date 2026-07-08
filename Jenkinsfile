pipeline {

    agent any

    environment {

        DEV_REPO = "shanthigowd/dev"
        PROD_REPO = "shanthigowd/prod"
        BRANCH_NAME = "dev"

        IMAGE_TAG = "${BUILD_NUMBER}"

        DOCKER_CREDS = credentials('dockerhub-creds')
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Image') {
            steps {

                script {

                    if(env.BRANCH_NAME == "dev") {

                        sh "./build.sh ${DEV_REPO} ${IMAGE_TAG}"

                    }

                    else if(env.BRANCH_NAME == "master") {

                        sh "./build.sh ${PROD_REPO} ${IMAGE_TAG}"

                    }

                }

            }
        }

        stage('Login to DockerHub') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                    '''
                }
            }
        }

        stage('Push Image') {

            steps {

                script {

                    if(env.BRANCH_NAME == "dev") {

                        sh """
                        docker push ${DEV_REPO}:${IMAGE_TAG}
                        docker tag ${DEV_REPO}:${IMAGE_TAG} ${DEV_REPO}:latest
                        docker push ${DEV_REPO}:latest
                        """

                    }

                    else if(env.BRANCH_NAME == "master") {

                        sh """
                        docker push ${PROD_REPO}:${IMAGE_TAG}
                        docker tag ${PROD_REPO}:${IMAGE_TAG} ${PROD_REPO}:latest
                        docker push ${PROD_REPO}:latest
                        """

                    }

                }

            }

        }

        stage('Deploy') {

            steps {

                script {

                    if(env.BRANCH_NAME == "dev") {

                        sh "./deploy.sh"

                    }

                    else if(env.BRANCH_NAME == "master") {

                        sh "./deploy.sh"

                    }

                }

            }

        }

    }

}
