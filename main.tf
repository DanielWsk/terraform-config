module "vpc" {
  source = "./modules/vpc"
}

module "ecs" {
  source = "./modules/ecs-cluster"

  append_workspace = true
  app              = "${local.config.APP}_${local.config.CLUSTER}-cluster"
  tags             = local.config.tags
}

module "ecs-service" {
  source = "./modules/ecs-service"

  for_each = local.config.SERVICES

  cluster         = module.ecs.output.cluster.id
  app             = local.config.APP
  task_definition = module.ecs_task_definition[each.key].output.task_definition.arn
  desired_count   = each.value.DESIRED_COUNT
  tags            = local.config.tags
}

module "ecs_task_definition" {
  source   = "./modules/ecs-task-definition"
  for_each = local.config.SERVICES

  container_memory_reservation = each.value.SOFT_LIMIT
  execution_role_arn           = each.value.IAM
  append_workspace             = false
  container_memory             = each.value.RAM
  container_image              = "${module.ecr[each.key].output.repository_url}:latest"
  container_cpu                = each.value.CPU
  docker_labels = {
    service = "${terraform.workspace}_${local.config.APP}_${each.key}"
  }
  port_mappings = each.value.port_mappings
  task_role_arn = each.value.IAM
  environment   = each.value.ENV_VARS
  app           = "${terraform.workspace}_${local.config.APP}_${each.key}"
  command       = each.value.COMMAND
  tags          = local.config.tags
}

module "ecr" {
  source = "./modules/ecr"

  for_each = local.config.SERVICES

  image_tag_mutability = "MUTABLE"
  append_workspace     = false
  app                  = "${terraform.workspace}_${local.config.APP}_${each.key}"
  tags                 = local.config.tags
}
