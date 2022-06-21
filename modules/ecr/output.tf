output "output" {
  value = {
    repository_arn = aws_ecr_repository.ecr.arn
    repository_id  = aws_ecr_repository.ecr.registry_id
    repository_url = aws_ecr_repository.ecr.repository_url
  }
}
