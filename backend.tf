terraform {
  required_version = "1.0.4"
}

provider "aws" {
  region = local.config.region
}
