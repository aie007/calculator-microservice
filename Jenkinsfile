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
		EMAIL_TO = 'aieshah.nasir@iiitb.ac.in'
		DOCKER_IMAGE_TAG = 'latest'
		UNIT_TEST_PATH = './src/tests/calculator_test.exe'
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
				docker run --name ${CONTAINER_NAME} ${DOCKER_HUB_USERNAME}/${DOCKER_IMAGE_NAME} dune exec ${UNIT_TEST_PATH}
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
						sh "docker push ${DOCKER_HUB_USERNAME}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
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
			mail to: "${EMAIL_TO}",
			subject: "SUCCESS: Job '${env.JOB_NAME} [Build No. ${env.BUILD_NUMBER}]'",
			body: """
				<p>Build successful for <b>${env.JOB_NAME}</b> on build number <b>${env.BUILD_NUMBER}</b>.</p>
				<p>Details: </p>
				<ul>
					<li>Job: 		${env.JOB_NAME}</li>
					<li>Build Number: 	${env.BUILD_NUMBER}</li>
					<li>URL: 		${env.BUILD_URL}</li>
				</ul>
			      """
		}
		
		failure {
			mail to: "${EMAIL_TO}",
			subject: "FAILURE: Job '${env.JOB_NAME} [Build No. ${env.BUILD_NUMBER}]'",
			body: """
				<p>Build failed for <b>${env.JOB_NAME}</b> on build number <b>${env.BUILD_NUMBER}</b>.</p>
				<p>Details: </p>
				<ul>
					<li>Job: 		${env.JOB_NAME}</li>
					<li>Build Number: 	${env.BUILD_NUMBER}</li>
					<li>URL: 		${env.BUILD_URL}</li>
				</ul>
			      """
		}
	}
}
