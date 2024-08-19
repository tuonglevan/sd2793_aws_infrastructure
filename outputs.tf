# ECR
output "ecr_repository_urls" {
  value = module.ecr.ecr_repository_urls
}
# Compute
output "jenkins_instance_details" {
  value = {
    instance_id: try(module.compute.jenkins_instance_ip, "No Jenkins Instance Created.")
    public_id: try(module.compute.jenkins_public_ip, "No Jenkins Instance Created.")
    jenkins_sg_id: module.security.jenkins_sg
    iam_profile: module.jenkins_iam_role.instance_profile
  }
}

# EKS
output "eks" {
  value = {
    provider_url: try(module.eks_cluster_and_worker_nodes.provider_url, "No Cluster Created.")
    eks_cluster_sg_id: module.security.eks_cluster_sg
    max_pods_for_node_groups: try(module.eks_cluster_and_worker_nodes.max_pods_for_node_groups, "No Node Group Created")
  }
}