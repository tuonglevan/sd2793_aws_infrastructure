resource "aws_key_pair" "eks_node_keypair" {
  key_name   = "eks-node"
  public_key = file(var.eks_node_keypair_path)
}