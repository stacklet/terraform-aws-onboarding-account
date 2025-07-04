variable "stacklet_assetdb_role_arn" {
  description = "ARN for the role used by AssetDB - Provided by Stacklet."
  type        = string
}

variable "stacklet_execution_role_arn" {
  description = "ARN for the role used by policies Execution - Provided by Stacklet."
  type        = string
}

variable "stacklet_target_event_bus_name" {
  description = "Target event bus for event forwarding - Provided by Stacklet."
  type        = string
  default     = "default"
}

variable "stacklet_external_id" {
  description = "ID of the Stacklet deployment to restrict what can assume the roles - Provided by Stacklet."
  type        = string
}

variable "regions" {
  description = "Regions in which resources should be created."
  type        = list(string)

  validation {
    condition     = length(var.regions) > 0
    error_message = "At least one region must be specified."
  }
}

variable "resource_prefix" {
  description = "An arbitrary prefix prepended to names of created resources."
  type        = string
}

variable "iam_path" {
  description = "A path for created IAM roles. If set, it must include leading and trailing slashes."
  type        = string
  default     = "/"

  validation {
    condition     = startswith(var.iam_path, "/") && endswith(var.iam_path, "/")
    error_message = "IAM path must include leading and trailing slashes."
  }
}

variable "execution_extra_roles" {
  description = <<-EOT
Additional roles to grant to Stacklet for policies execution.

If provided, this must be a map from the role name (which gets the prefix
prepended) and a list of permissions to grant to the role in addition to the
default read-only permissions.
EOT
  type        = map(list(string))
  default     = {}
}
