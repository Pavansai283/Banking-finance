resource "aws_instance" "test-server" {
  ami           = "ami-02eb7a4783e7e9317" 
  instance_type = "t2.medium" 
  availability_zone = "ap-south-1a"
  vpc_security_group_ids= ["sg-0e3240a277ba0665b"]
  key_name = "mykey"

  connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file("mykey.pem")
    }
  provisioner "remote-exec" {
        inline = [ "echo 'wait to start instance' "]
    }

  tags = {
    Name = "test-server"
    }

  provisioner "remote-exec" {
     inline = [
      "sudo apt update -y",
      "sudo apt install docker.io -y",
      "sudo wget https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64",
      "sudo chmod +x /home/ubuntu/minikube-linux-amd64",
      "sudo cp minikube-linux-amd64 /usr/local/bin/minikube",
      "curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl",
      "sudo chmod +x /home/ubuntu/kubectl",
      "sudo cp kubectl /usr/local/bin/kubectl",
      "sudo usermod -aG docker ubuntu"
       ]
  }
  }
