locals {
  app = var.append_workspace ? "${var.app}-${terraform.workspace}" : var.app

  default_tags = {
    Environment = terraform.workspace
    Name        = local.app
  }
  tags = merge(local.default_tags, var.tags)

  container_list = "[${join(",", concat([module.container_definition.output], var.container_definitions))}]"
}

module "container_definition" {
  source = "../ecs-container-definition"

  container_memory_reservation = var.container_memory_reservation
  readonly_root_filesystem     = var.readonly_root_filesystem
  firelens_configuration       = var.firelens_configuration
  log_configuration            = var.log_configuration
  container_memory             = var.container_memory
  append_workspace             = var.append_workspace_container
  system_controls              = var.system_controls
  container_image              = var.container_image
  container_cpu                = var.container_cpu
  docker_labels                = var.docker_labels
  port_mappings                = var.port_mappings
  start_timeout                = var.start_timeout
  mount_points                 = var.mount_points
  stop_timeout                 = var.stop_timeout
  volumes_from                 = var.volumes_from
  dns_servers                  = var.dns_servers
  environment                  = var.environment
  entrypoint                   = var.entrypoint
  essential                    = var.essential
  command                      = var.command
  secrets                      = var.secrets
  ulimits                      = var.ulimits
  links                        = var.links
  app                          = var.app
}

resource "aws_ecs_task_definition" "task" {
  requires_compatibilities = var.requires_compatibilities
  container_definitions    = local.container_list
  execution_role_arn       = var.execution_role_arn
  task_role_arn            = var.task_role_arn
  network_mode             = var.network_mode
  family                   = local.app
  memory                   = var.task_memory
  cpu                      = var.task_cpu

  tags = local.tags
}
