pipeline {
  agent any

  tools {
      maven 'M2_HOME'
     }
  environment{
			AWS_ACCESS_KEY_ID= '$(access_key)'
			AWS_SECRET_KEY_ID= '$(secret_key)'
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
  //stage ('Configure Test-server with Terraform & Deploying'){
    //        steps {
      //          dir('my-serverfiles'){
        //        sh 'sudo chmod 600 mykey.pem'
          //      sh 'terraform init'
            //    sh 'terraform validate'
              //  sh 'terraform apply --auto-approve'
                //}
            //}
        //}
//  stage('Deploy using Ansible') {
  //       steps {
//	   ansiblePlaybook credentialsId: 'prod-server', disableHostKeyChecking: true, installation: 'Ansible', inventory: '/etc/ansible/hosts', playbook: 'ansible-playbook.yml'
//	   }
//	   }
  stage('Deploy using K8s') {
    steps{
               "sudo apt upadte -y",
               "sudo apt install docker.io -y",
               "sudo snap install microk8s --clasic",
               "sudo sleep 30",
               "sudo microk8s status",
               "sudo microk8s kubectl create deployment medicure-deploy --image=pavanputtur/bankapp:1.0",
               "sudo microk8s kubectl expose deployment medicure-deploy --port=8084 --type=NodePort",
               "sudo microk8s kubectl get svc",
               "sudo echo public IP Address of the Instance",
               "sudo curl http://checkip.amazonaws.com",
	   }
	   }
