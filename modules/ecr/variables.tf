variable "app" {
  description = "(Required) Name of the repository"
  type        = string
}

variable "image_tag_mutability" {
  description = "(Optional) The tag mutability setting for the repository. Must be one of: MUTABLE or IMMUTABLE. Defaults to MUTABLE"
  default     = "IMMUTABLE"
  type        = string
}

variable "tags" {
  description = "(Optional) A map of tags to assign to the resource"
  default     = {}
  type        = map(any)
}

variable "append_workspace" {
  description = "Appends the terraform workspace at the end of resource names, <identifier>-<worspace>"
  default     = true
  type        = bool
}
