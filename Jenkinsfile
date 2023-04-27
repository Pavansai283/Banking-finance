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
    stage('CheckOut') {
      steps {
        echo 'Checkout the source code from GitHub'
        git 'https://github.com/Pavansai283/banking-finance.git' 
            }
    }
    
    stage('Package the Application') {
      steps {
        echo " Packaing the Application"
        sh 'mvn clean package'
            }
    }
    
    
	  stage('Docker Image Creation') {
      steps {
        sh 'docker build -t pavanputtur/bankapp:1.0 .'
            }
    }
   stage('DockerLogin') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'docker_hub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
        sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
            }
        }
   }

   stage('Push Image to DockerHub') {
      steps {
        sh 'docker push pavanputtur/bankapp:1.0'
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
