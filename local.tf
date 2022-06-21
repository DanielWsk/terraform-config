locals {
  # Get workspace configuration variables
  config = yamldecode(file("${path.module}/environments/${terraform.workspace}/config.yaml"))
}
