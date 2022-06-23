locals {
  app = var.append_workspace ? "${var.app}-${terraform.workspace}" : var.app

  default_tags = {
    Environment = terraform.workspace
    Name        = local.app
  }
  tags = merge(local.default_tags, var.tags)
}

resource "aws_ecs_service" "service" {
  enable_ecs_managed_tags = var.enable_ecs_managed_tags
  network_configuration  {
    subnets = var.subnets
  }
  task_definition         = var.task_definition
  desired_count           = var.desired_count
  launch_type             = var.launch_type
  cluster                 = var.cluster
  name                    = local.app

  lifecycle {
    ignore_changes = [
      desired_count
    ]
  }

  tags = var.tags
}
