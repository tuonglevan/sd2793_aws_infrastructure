resource "aws_ecr_repository" "ecr_repo" {
  count                = length(var.ecr_repos)
  name                 = var.ecr_repos[count.index]
  image_tag_mutability = var.image_tag_mutability
  force_delete = true

  image_scanning_configuration {
	scan_on_push = var.enable_scan_on_push
  }
}