pipeline{
    agent any

    environment {
        TAG = "${env.BRANCH_NAME}-${env.BUILD_NUMBER}"
        max = 20
        random_num = "${Math.abs(new Random().nextInt(max+1))}"
        docker_password = credentials('Call2sing?')
    }
	
	stages{
        stage("Workspace Cleanup") {
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

		stage ('Build App') {
			steps {
				script {
					sh "docker login -u zik777 -p ${docker_password}"
					sh 'docker build -t zik777/todo_app:${env.TAG} .'
				}
			}
		}

		stage ('Creating docker container') {
			steps {
                script {
                    sh " docker run -d --name todo-app-${env.random_num} -p 8000:8000 zik777/todo_app:${env.TAG}"
                }
            }
        }
		stage("Publish to Registry") {
            steps {
                script {
                    sh " docker push zik777/todo_app:${env.TAG}"
                }
            }
        }
		stage ('Clean Up') {
            steps {
                script {
                    sh " docker stop todo_app-${env.random_num}"
                    sh " docker rm todo_app-${env.random_num}"
                    sh " docker rmi zik777/todo_app:${env.TAG}"
                }
            }
        }
		stage('logout Docker') {
			steps {
				sh 'docker logout'

				sh 'docker system prune -f'
			}
		}
  	}
}