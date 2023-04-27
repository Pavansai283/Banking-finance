resource "aws_instance" "test-server" {
  ami           = "ami-02eb7a4783e7e9317" 
  instance_type = "t2.medium" 
  availability_zone = "ap-south-1a"
  vpc_security_group_ids= ["sg-075da468752d2a222"]
  key_name = "myEC2key"
  
  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("myEC2key.pem")
    host     = self.public_ip
  }  
  provisioner "remote-exec" {
    inline = [ "echo 'wait to start instance' "]
  }
  tags = {
    Name = "test-server"
  }
  provisioner "local-exec" {
        command = " echo ${aws_instance.test-server.public_ip} > inventory "
  }
   provisioner "local-exec" {
  command = "ansible-playbook /var/lib/jenkins/workspace/bankapp/my-serverfiles/playbook.yml "
  } 
}
