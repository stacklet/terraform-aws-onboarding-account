terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.2"
    }
  }

  # Provider-defined functions (provider::aws::arn_build in
  # events_forwarding.tf) landed in Terraform 1.8. The provider:: namespace is
  # a parser change, so below it even init fails, with a bare "Missing newline
  # after argument" that names neither the function nor a version. The floor is
  # 1.8.2 rather than 1.8 because 1.8.0 and 1.8.1 vendor go-getter 1.7.3
  # (CVE-2024-3817); 1.8.2 is the first release carrying the fix.
  required_version = ">= 1.8.2"
}
