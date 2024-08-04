output "jenkins_instance_ip" {
  value = aws_instance.jenkins_docker_server.id
  description = "The Instance ID of the Jenkins Server instance."
}

output "jenkins_public_ip" {
  value = aws_eip.jenkins_eip.public_ip
  description = "The public IP attached to the Jenkins Server."
}