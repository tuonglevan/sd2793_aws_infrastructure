output "ecr_repository_urls" {
  description = "The URLs of the created repositories"
  value       = aws_ecr_repository.ecr_repo[*].repository_url
}