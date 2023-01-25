pipeline {
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
            	git branch: 'main', credentialsId: 'b741c689-0d77-4526-a19c-e23aaaa7c517', url: 'https://github.com/Isaac-Ayanda/todo-app-php.git'
      		}
    	}

        stage('Build') {
      		steps {
            	script{
                    sh 'echo "Build Stage"'
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
