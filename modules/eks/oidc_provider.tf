// Fetch the OIDC thumbprint
data "external" "oidc_thumbprint" {
  program = ["bash", "${path.module}/scripts/get_oidc_thumbprint.sh", aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer]
}
resource "aws_iam_openid_connect_provider" "oidc_provider" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.external.oidc_thumbprint.result.thumbprint]
  url             = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}