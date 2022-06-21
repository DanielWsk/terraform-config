locals {
  app = var.append_workspace ? "${var.app}-${terraform.workspace}" : var.app

  default_tags = {
    Environment = terraform.workspace
    Name        = local.app
  }
  tags = merge(local.default_tags, var.tags)

  env_vars = var.environment != null ? var.environment : []

  env_vars_keys        = [for m in local.env_vars : lookup(m, "name")]
  env_vars_values      = [for m in local.env_vars : lookup(m, "value")]
  env_vars_as_map      = zipmap(local.env_vars_keys, local.env_vars_values)
  sorted_env_vars_keys = sort(local.env_vars_keys)

  sorted_environment_vars = [
    for key in local.sorted_env_vars_keys :
    {
      name  = key
      value = lookup(local.env_vars_as_map, key)
    }
  ]

  null_value             = var.environment == null ? var.environment : null
  final_environment_vars = length(local.sorted_environment_vars) > 0 ? local.sorted_environment_vars : local.null_value

  container_definition = {
    readonlyRootFilesystem = var.readonly_root_filesystem
    firelensConfiguration  = var.firelens_configuration
    memoryReservation      = var.container_memory_reservation
    logConfiguration       = var.log_configuration
    systemControls         = var.system_controls
    dockerLabels           = var.docker_labels
    portMappings           = var.port_mappings
    startTimeout           = var.start_timeout
    mountPoints            = var.mount_points
    environment            = local.final_environment_vars
    stopTimeout            = var.stop_timeout
    volumesFrom            = var.volumes_from
    dnsServers             = var.dns_servers
    entryPoint             = var.entrypoint
    essential              = var.essential
    command                = var.command
    secrets                = var.secrets
    ulimits                = var.ulimits
    memory                 = var.container_memory
    image                  = var.container_image
    links                  = var.links
    name                   = local.app
    cpu                    = var.container_cpu
  }

  json_map = jsonencode(local.container_definition)
}
