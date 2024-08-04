resource "aws_instance" "jenkins_docker_server" {
  ami                    = var.image_id
  instance_type          = var.instance_type
  subnet_id = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  iam_instance_profile = var.iam_instance_profile

  ebs_block_device {
    device_name = "/dev/xvda"
    volume_type = "gp3"
    volume_size = 20           # size in GB
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install -y docker
              sudo systemctl start docker
              sudo systemctl enable docker

              sudo dnf install java-21-amazon-corretto.x86_64 -y
              sudo wget -O /etc/yum.repos.d/jenkins.repo  https://pkg.jenkins.io/redhat-stable/jenkins.repo
              sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
              sudo yum install -y jenkins

              sudo usermod -a -G docker jenkins
              sudo systemctl start jenkins
              sudo systemctl enable jenkins
              EOF

  tags = {
    Name = "Jenkins Docker Server"
  }
}

resource "aws_eip" "jenkins_eip" {
  instance = aws_instance.jenkins_docker_server.id
}