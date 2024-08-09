resource "aws_eks_cluster" "eks_cluster" {
  name     = var.eks_cluster_name
  role_arn = var.eks_cluster_role_arn

  vpc_config {
	security_group_ids      = var.eks_cluster_security_group_ids
	endpoint_private_access = var.endpoint_private_access
	endpoint_public_access  = var.endpoint_public_access
	subnet_ids = var.eks_cluster_subnet_ids
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
	var.eks_cluster_iam_policy_arn
  ]
}