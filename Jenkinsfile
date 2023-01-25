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
            	 checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'b741c689-0d77-4526-a19c-e23aaaa7c517', url: 'https://github.com/Isaac-Ayanda/todo-app-php.git']])
      		}
    	}

        stage('Build Docker Image') {
      		steps {
            	script{
			sh 'sudo docker build -t zik777/todo_app-proj20:${BRANCH_NAME}-${BUILD_NUMBER} .'
                }
      		}
        }

        stage('Creating docker container') {
            steps {
                script {
                    sh 'sudo docker run -d --name=todo_app:${BRANCH_NAME}-${BUILD_NUMBER} -p 8000:80 zik777/todo_app-proj20:${BRANCH_NAME}-${BUILD_NUMBER}'
                }
            }
        } 

        stage('Publish to Docker Hub') {
            steps {
                script {
                    sh 'sudo echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
                    sh 'sudo docker push zik777/todo_app-proj20:${BRANCH_NAME}-${BUILD_NUMBER}'
                }
            }
        }       	
        		
		stage ('Clean Up') {
            steps {
                script {
                    sh 'sudo docker stop todo_app:${BRANCH_NAME}-${BUILD_NUMBER}'
                    sh 'sudo docker rm todo_app:${BRANCH_NAME}-${BUILD_NUMBER}'
                    sh 'sudo docker rmi zik777/todo_app-proj20:${BRANCH_NAME}-${BUILD_NUMBER}'
                }
            }
        }

        stage ('logout Docker') {
            steps {
                script {
                    sh 'sudo docker logout'
                }
            }
        }
  	}
}
