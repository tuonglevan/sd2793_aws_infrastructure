# ECR
output "ecr_repository_urls" {
  value = module.ecr.ecr_repository_urls
}
# Compute
output "jenkins_instance_details" {
  value = {
    instance_id: module.compute.jenkins_instance_ip
    public_id: module.compute.jenkins_public_ip
    jenkins_sg: module.security.jenkins_sg
    iam_profile: module.jenkins_iam_role.instance_profile
  }
}
# EkS
# output "cluster_endpoint" {
#   description = "Endpoint for EKS control plane"
#   value       = module.eks.cluster_endpoint
# }
#
# output "cluster_security_group_id" {
#   description = "Security group ids attached to the cluster control plane"
#   value       = module.eks.cluster_security_group_id
# }
#
# output "cluster_name" {
#   description = "Kubernetes Cluster Name"
#   value       = module.eks.cluster_name
# }