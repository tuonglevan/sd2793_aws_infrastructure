locals {
  jenkins_name = "Jenkins"
}

resource "aws_security_group" "jenkins_sg" {
  name        = local.jenkins_name
  description = "Allow traffic to Jenkins"

  vpc_id = var.vpc_id

  ingress {
	from_port   = 8080
	to_port     = 8080
	protocol    = "tcp"
	cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
	from_port   = 22
	to_port     = 22
	protocol    = "tcp"
	cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
	from_port   = 0
	to_port     = 0
	protocol    = "-1"
	cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
	Name = local.jenkins_name
  }
}