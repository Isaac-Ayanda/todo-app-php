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
            	 checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[credentialsId: 'b741c689-0d77-4526-a19c-e23aaaa7c517', url: 'https://github.com/Isaac-Ayanda/todo-app-php.git']])
      		}
    	}

        stage('Build Application') {
      		steps {
            	script{
                    sh 'echo "Build Stage"'
                    sh " docker login -u zik777 -p Call2sing?"
                    sh " docker build -t zik777/todo_proj20:0.0.2 ."
                }
      		}
        }

        stage('Creating docker container') {
            steps {
                script {
                    sh " docker run -d --name todo-app:0.0.2 -p 8000:8000 zik777/todo_proj20:0.0.2"
                }
            }
        } 

        stage("Publish to Registry") {
            steps {
                script {
                    sh " docker push zik777/todo_proj20:0.0.2"
                }
            }
        }       	
        		
		stage ('Clean Up') {
            steps {
                script {
                    sh " docker stop todo-app:0.0.2"
                    sh " docker rm todo-app:0.0.2"
                    sh " docker rmi zik777/todo_proj20:0.0.2"
                }
            }
        }

        stage ('logout Docker') {
            steps {
                script {
                    sh " docker logout"
                }
            }
        }
  	}
}
