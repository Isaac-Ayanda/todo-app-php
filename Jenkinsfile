pipeline {
    agent any

	environment {
		DOCKERHUB_CREDENTIALS=credentials('dockerhub')
	}
	
	stages {
		stage("Initial cleanup") {
			steps {
				dir("${WORKSPACE}") {
					deleteDir()
				}
			}
		}

    	stage('Clone Github Repo') {
      		steps {
            	git branch: 'main', url: 'https://github.com/Isaac-Ayanda/todo-app-php.git'
      		}
    	}

		stage ('Build Docker Image') {
			steps {
				script {
					sh 'docker build -t zik777/todo-app:${BRANCH_NAME}-${BUILD_NUMBER} .'
				}
			}
		}

		stage ('Push Image To Docker Hub') {
			steps {
				script {
					sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'

					sh 'docker push yheancarh/php_todo:${BRANCH_NAME}-${BUILD_NUMBER}'
				}
			}
		}

		stage('Cleanup') {
			steps {
				cleanWs(cleanWhenAborted: true, cleanWhenFailure: true, cleanWhenNotBuilt: true, cleanWhenUnstable: true, deleteDirs: true)
				
				sh 'docker logout'

				sh 'docker system prune -f'
			}
		}
  	}
}