pipeline {
  agent any

  tools {
      maven 'M2_HOME'
     }
  environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }
  stages {
    stage('Checkout') {
       steps {
         echo 'checkout code from github repo'
	 git 'https://github.com/Pavansai283/banking-finance.git'
	 }
	}
  stage('building application') {
       steps {
         echo "Cleaning... Compiling... Testing... Packaging..."
         sh 'mvn clean package'
      }
      }
  stage('Docker image creating') {
       steps {
       sh 'docker build -t pavanputtur/bankapp:1.0 .'
       }
       }
  stage('pushing to dockerhub') {
       steps {
       withCredentials([usernamePassword(credentialsId: 'docker_hub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
       sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
       sh 'docker push pavanputtur/bankapp:1.0'
       }
       }
       }
  stage ('Configure Test-server with Terraform'){
           steps {
               dir('my-serverfiles'){
                sh 'sudo chmod 600 myEC2key.pem'
                sh 'terraform init'
                sh 'terraform validate'
               sh 'terraform apply --auto-approve'
                }
            }
        }
	}
	}
