output "role_arn" {
  value = aws_iam_role.eks_cluster.arn
}
output "iam_policy_arn" {
  description = "IAM policy ARN"
  value       = aws_iam_role_policy_attachment.eks_cluster_AmazonEKSClusterPolicy.policy_arn
}