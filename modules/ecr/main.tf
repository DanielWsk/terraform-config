locals {
  app = var.append_workspace ? "${var.app}-${terraform.workspace}" : var.app

  default_tags = {
    Environment = terraform.workspace
    Name        = local.app
  }
  tags = merge(local.default_tags, var.tags)
}

resource "aws_ecr_repository" "ecr" {
  image_tag_mutability = var.image_tag_mutability
  name                 = local.app
  tags                 = var.tags
}
