output "jenkins" {
  value = aws_key_pair.jenkins_keypair.key_name
}
output "eks_node_keypair_path" {
  value = aws_key_pair.eks_node_keypair.key_name
}