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
    iam_profile: module.iam_role.jenkins_instance_profile
  }
}