output "jenkins_sg" {
  value = aws_security_group.jenkins_sg.id
}
output "eks_cluster_sg" {
  value = aws_security_group.eks_cluster.id
}
output "eks_node_sg" {
  value = aws_security_group.eks_nodes.id
}