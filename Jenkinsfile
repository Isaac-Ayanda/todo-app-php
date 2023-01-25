pipeline {
    agent any

    environment {
        TAG = "${env.BRANCH_NAME}-${env.BUILD_NUMBER}"
        max = 20
        random_num = "${Math.abs(new Random().nextInt(max+1))}"
        docker_password = credentials('Call2sing?')
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
            	git branch: 'master', git credentialsId 'b741c689-0d77-4526-a19c-e23aaaa7c517', url: 'https://github.com/Isaac-Ayanda/todo-app-php.git'
      		}
    	}

        stage('Build Application') {
      		steps {
            	script{
                    sh 'echo "Build Stage"'
                    sh " docker login -u zik777 -p ${docker_password}"
                    sh " docker build -t zik777/todo_proj20:${env.TAG} ."
                }
      		}
        }

        stage('Creating docker container') {
            steps {
                script {
                    sh " docker run -d --name todo-app-${env.random_num} -p 8000:8000 zik777/todo_proj20:${env.TAG}"
                }
            }
        } 

        stage("Publish to Registry") {
            steps {
                script {
                    sh " docker push zik777/todo_proj20:${env.TAG}"
                }
            }
        }       	
        		
		stage ('Clean Up') {
            steps {
                script {
                    sh " docker stop todo-app-${env.random_num}"
                    sh " docker rm todo-app-${env.random_num}"
                    sh " docker rmi zik777/todo_proj20:${env.TAG}"
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
