variable "ecr_repos" {
  description = "List of repositories"
  type        = list(string)
}

variable "image_tag_mutability" {
  description = "The tag mutability setting for the repository"
  type        = string
}

variable "enable_scan_on_push" {
  type        = bool
  description = "Enable vulnerability scanning on push to ECR"
}