resource "aws_key_pair" "jenkins_keypair" {
  key_name   = "ubuntu-jenkins"
  public_key = file(var.jenkins_keypair_path)
}