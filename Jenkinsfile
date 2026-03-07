pipeline {
	agent any
	
	triggers {
		githubPush()
	}

	environment {
		DOCKER_IMAGE_NAME = 'calc'
		GITHUB_REPO_URL = 'https://github.com/aie007/calculator-microservice.git'
		CONTAINER_NAME = 'calc'
		DOCKER_HUB_USERNAME = 'aie007'
		EMAIL_TO = 'aieshahnasir20729@acropolis.in'
	}
	
	stages {
		stage('git checkout') {
			steps {
				git branch: 'main', url: "${GITHUB_REPO_URL}"
			}
		}

		stage('cleanup') {
			steps {
				sh """
				echo 'Cleaning old containers if any'
				docker stop $CONTAINER_NAME || true
				docker rm -f $CONTAINER_NAME || true
				"""
			}
		}

		stage('build image') {
			steps {
				script {
					docker.build("${DOCKER_HUB_USERNAME}/${DOCKER_IMAGE_NAME}", '.')
				}
			}
		}
		
		stage('run unit tests') {
			steps {
				sh """
				echo 'running unit tests in tmp container'
				docker run --name ${CONTAINER_NAME} ${DOCKER_HUB_USERNAME}/${DOCKER_IMAGE_NAME} dune exec ./src/tests/calculator_test.exe
				"""
			}
		}

		stage ('remove test container') {
			steps {
				sh """
				echo 'cleaning test container'
				docker stop ${CONTAINER_NAME} || true
				docker rm -f ${CONTAINER_NAME} || true
				"""
			}
		}
		
		stage ('push docker image') {
			steps {
				script {
					docker.withRegistry('', 'DockerHubCred') {
						sh "docker push ${DOCKER_HUB_USERNAME}/${DOCKER_IMAGE_NAME}:latest"
					}
				}
			}
		}

		stage ('deploy') {
			steps {
				ansiblePlaybook(
					playbook: 'deploy.yaml', inventory: 'inventory.ini' 
				)
			}
		}
	}

	post {
		success {
			mail to: "${EMAIL_TO},aieshah9241@gmail.com",
			subject: "SUCCESS: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
			body: "Build successful for ${env.JOB_NAME} - ${env.BUILD_NUMBER}. Check details here - ${env.BUILD_URL}"
		}
		
		failure {
			mail to: "${EMAIL_TO},aieshah9241@gmail.com",
			subject: "FAILURE: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
			body: "Build failed for ${env.JOB_NAME} - ${env.BUILD_NUMBER}. Check details here - ${env.BUILD_URL}"
		}
	}
}
