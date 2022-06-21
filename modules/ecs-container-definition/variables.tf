variable "app" {
  description = "The name of the container. NOTE: This identifier must not be the same as the identifier for the task definition."
  type        = string
}

variable "append_workspace" {
  description = "Appends the terraform workspace at the end of resource names, <identifier>-<worspace>"
  default     = true
  type        = bool
}

variable "container_image" {
  description = "The image used for the auxiliary container."
  type        = string
}

variable "container_memory" {
  description = "The amount of memory (in MiB) to allow the container to use. This is a hard limit, if the container attempts to exceed the container_memory, the container is killed. This field is optional for Fargate launch type and the total amount of container_memory of all containers in a task will need to be lower than the task memory value"
  default     = 256
  type        = number
}

variable "container_memory_reservation" {
  description = "The amount of memory (in MiB) to reserve for the container. If container needs to exceed this threshold, it can do so up to the set container_memory hard limit"
  default     = 128
  type        = number
}

variable "port_mappings" {
  description = "The port mappings to configure for the container. This is a list of maps. Each map should contain \"containerPort\", \"hostPort\", and \"protocol\", where \"protocol\" is one of \"tcp\" or \"udp\". If using containers in a task with the awsvpc or host network mode, the hostPort can either be left blank or set to the same value as the containerPort"
  default     = []
  type = list(object(
    {
      containerPort = number
      hostPort      = number
      protocol      = string
    }
  ))
}

variable "container_cpu" {
  description = "The number of cpu units to reserve for the container. This is optional for tasks using Fargate launch type and the total amount of container_cpu of all containers in a task will need to be lower than the task-level cpu value"
  default     = 300
  type        = number
}

variable "essential" {
  description = "Determines whether all other containers in a task are stopped, if this container fails or stops for any reason. Due to how Terraform type casts booleans in json it is required to double quote this value"
  default     = true
  type        = bool
}

variable "entrypoint" {
  description = "The entry point that is passed to the container"
  default     = []
  type        = list(string)
}

variable "command" {
  description = "The command that is passed to the container"
  default     = []
  type        = list(string)
}

variable "secrets" {
  description = "The secrets to pass to the container. This is a list of maps"
  default     = []
  type = list(object(
    {
      name      = string
      valueFrom = string
    }
  ))
}

variable "readonly_root_filesystem" {
  description = "Determines whether a container is given read-only access to its root filesystem. Due to how Terraform type casts booleans in json it is required to double quote this value"
  default     = false
  type        = bool
}

variable "mount_points" {
  description = "Container mount points. This is a list of maps, where each map should contain a `containerPath` and `sourceVolume`"
  default     = []
  type = list(object(
    {
      containerPath = string
      sourceVolume  = string
    }
  ))
}

variable "dns_servers" {
  description = "Container DNS servers. This is a list of strings specifying the IP addresses of the DNS servers"
  default     = []
  type        = list(string)
}

variable "ulimits" {
  description = "Container ulimit settings. This is a list of maps, where each map should contain \"name\", \"hardLimit\" and \"softLimit\""
  default     = []
  type = list(object(
    {
      name      = string
      hardLimit = number
      softLimit = number
    }
  ))
}

variable "volumes_from" {
  description = "A list of VolumesFrom maps which contain \"sourceContainer\" (name of the container that has the volumes to mount) and \"readOnly\" (whether the container can write to the volume)"
  default     = []
  type = list(object(
    {
      sourceContainer = string
      readOnly        = bool
    }
  ))
}

variable "links" {
  description = "List of container names this container can communicate with without port mappings"
  default     = []
  type        = list(string)
}

variable "docker_labels" {
  description = "The configuration options to send to the `docker_labels`"
  default     = {}
  type        = map(string)
}

variable "start_timeout" {
  description = "Time duration (in seconds) to wait before giving up on resolving dependencies for a container"
  default     = 30
  type        = number
}

variable "stop_timeout" {
  description = "Time duration (in seconds) to wait before the container is forcefully killed if it doesn't exit normally on its own"
  default     = 30
  type        = number
}

variable "system_controls" {
  description = "A list of namespaced kernel parameters to set in the container, mapping to the --sysctl option to docker run. This is a list of maps: { namespace = \"\", value = \"\"}"
  default     = []
  type        = list(map(string))
}

variable "log_configuration" {
  description = "The log configuration for the container"
  default = {
    logDriver = "json-file",
    options   = {}
  }
  type = object({
    logDriver = string,
    options   = map(string)
  })
}

variable "firelens_configuration" {
  description = "The firelens log configuration for the container"
  default     = null
  type = object({
    type    = string,
    options = map(string)
  })
}

variable "environment" {
  description = "The environment variables to pass to the container. This is a list of maps"
  default     = []
  type = list(object(
    {
      name  = string
      value = string
    }
  ))
}

variable "tags" {
  description = "Tags to be applied to the resource"
  default     = {}
  type        = map(any)
}
