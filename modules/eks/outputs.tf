output "cluster_id" {
  description = "The name/id of the EKS cluster"
  value       = aws_eks_cluster.eks_cluster.name
}

output "b64_cluster_ca" {
  value = aws_eks_cluster.eks_cluster.certificate_authority.0.data
}

output "api_server_url" {
  value = aws_eks_cluster.eks_cluster.endpoint
}

output "k8s_cluster_dns_ip" {
  value = aws_eks_cluster.eks_cluster.vpc_config[0].cluster_security_group_id
}

output "max_pods_for_node_groups" {
  value = { for ng, data in data.external.max_pods_calculator : ng => data.result }
}