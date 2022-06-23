variable "app" {
  description = "The name for the cluster"
  type        = string
}

variable "append_workspace" {
  description = "Appends the terraform workspace at the end of resource names, <app>-<worspace>"
  default     = true
  type        = bool
}

variable "tags" {
  description = "Tags to be applied to the resource"
  default     = {}
  type        = map(any)
}
