pipelines {
    agent any
	
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
            	git branch: 'main', credentialsId:'b741c689-0d77-4526-a19c-e23aaaa7c517',   url: 'https://github.com/Isaac-Ayanda/todo-app-php.git'
      		}
    	}

		stage ('Build Docker Image') {
			steps {
				script {
					sh 'docker login -u zik777 -p Call2sing?'
					sh 'docker build -t zik777/todo_app:${BRANCH_NAME}-${BUILD_NUMBER} .'
				}
			}
		}

		stage ('Push Image To Docker Hub') {
			steps {
				script {
					sh 'docker login -u zik777 -p Call2sing?'

					sh 'docker push zik777/todo_app:${BRANCH_NAME}-${BUILD_NUMBER}'
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
