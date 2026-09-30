terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.2"
    }
  }

  # The floor is a Terraform line that still receives patches, not the oldest
  # release that can run this module. The oldest is 1.8, where the
  # provider-defined functions in events_forwarding.tf landed, and below that
  # even init fails with a bare "Missing newline after argument" that names
  # neither the function nor a version. Nothing is gained by supporting that
  # far back, and 1.13 and earlier no longer get security fixes.
  required_version = ">= 1.14.0"
}
