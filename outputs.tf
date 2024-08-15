# ECR
output "ecr_repository_urls" {
  value = module.ecr.ecr_repository_urls
}
# Compute
output "jenkins_instance_details" {
  value = {
    instance_id: try(module.compute.jenkins_instance_ip, "No Jenkins Instance Created.")
    public_id: try(module.compute.jenkins_public_ip, "No Jenkins Instance Created.")
    jenkins_sg: module.security.jenkins_sg
    iam_profile: module.jenkins_iam_role.instance_profile
  }
}
# EKS
output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = try(module.eks_cluster_and_worker_nodes.cluster_id, "No Cluster Created.")
}
output "b64_cluster_ca" {
  value = module.eks_cluster_and_worker_nodes.b64_cluster_ca
}

output "api_server_url" {
  value = module.eks_cluster_and_worker_nodes.api_server_url
}

output "k8s_cluster_dns_ip" {
  value = cidrhost(module.networking.cidr_block, 10)
}
# output "cluster_security_group_id" {
#   description = "Security group ids attached to the cluster control plane"
#   value       = module.eks_cluster_and_worker_nodes.cluster_security_group_id
# }
#
# output "cluster_name" {
#   description = "Kubernetes Cluster Name"
#   value       = module.eks.cluster_name
# }
output "max_pods_for_node_groups" {
  value = module.eks_cluster_and_worker_nodes.max_pods_for_node_groups
}