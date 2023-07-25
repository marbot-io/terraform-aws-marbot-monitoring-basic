terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.15.0"
    }
  }
}

module "marbot-monitoring-basic" {
  source = "../../"

  endpoint_id = var.endpoint_id
}