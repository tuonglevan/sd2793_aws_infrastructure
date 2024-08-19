output "role_arn" {
  value = {
    cluster: aws_iam_role.eks_cluster.arn,
    node_group: aws_iam_role.eks_nodes.arn
  }
}
output "iam_policy_arn" {
  description = "IAM policy ARN"
  value       = aws_iam_role_policy_attachment.eks_cluster_AmazonEKSClusterPolicy.policy_arn
}
output "addons" {
  value = {
    ebs_csi_driver: module.eks-ebs-csi-irsa.iam_role_arn
  }
}