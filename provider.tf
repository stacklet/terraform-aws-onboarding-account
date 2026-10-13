terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.2"
    }
  }

  # Require a Terraform version that has had recent updates.
  required_version = ">= 1.14.0"
}
