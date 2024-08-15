resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  version = var.cluster_version
  role_arn = var.cluster_role_arn

  vpc_config {
	endpoint_private_access = var.endpoint_private_access
	endpoint_public_access  = var.endpoint_public_access
	#security_group_ids      = var.cluster_security_group_ids
	subnet_ids 				= var.cluster_subnet_ids
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
	var.cluster_iam_policy_arn
  ]
}