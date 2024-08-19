resource "aws_eks_addon" "ebs-csi" {
  cluster_name             = var.cluster_name
  addon_name               = "aws-ebs-csi-driver"
  addon_version            = "v1.33.0-eksbuild.1"
  service_account_role_arn = var.addon_ebs_csi_driver_role_arn
  tags = {
	"eks_addon" = "ebs-csi"
  }

  depends_on = [
    aws_eks_cluster.eks_cluster
  ]
}