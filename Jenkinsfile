pipeline {
	agent any
	environment {
		DOCKER_IMAGE_NAME = 'scientific-calculator'
		GITHUB_REPO_URL = 'https://github.com/aie007/calculator-microservice.git'
		DOCKER_HUB_USERNAME = 'aie007'
	}
	
	stages {
		stage('Clone Git') {
			steps {
				script {
					git branch: 'master'
					
				}
			}
		}
	}

}
