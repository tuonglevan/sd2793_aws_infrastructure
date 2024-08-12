resource "aws_instance" "jenkins_docker_server" {
  ami                    = var.image_id
  instance_type          = var.instance_type
  subnet_id = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids
  iam_instance_profile = var.iam_instance_profile
  key_name = var.jenkins_key_name

  root_block_device {
    volume_type = "gp3"
    volume_size = 20
  }

  user_data = file("${path.module}/scripts/initialize_jenkins")

  tags = {
    Name = "Jenkins Docker Server"
  }
}

resource "aws_eip" "jenkins_eip" {
  instance = aws_instance.jenkins_docker_server.id
}