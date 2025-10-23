# Terraform module for AWS accounts onboarding into Stacklet

This modules creates IAM roles and resources needed by Stacklet to operate on
an AWS account.

To use this module:

```terraform
module "account" {
    source = "stacklet/onboarding-account/aws"
    version = "0.1.0"
    
    resource_prefix = "<PREFIX>"
    regions         = ["<REGION-1>", "<REGION-2>"]

    stacklet_external_id        = "<EXTERNAL_ID>"
    stacklet_assetdb_role_arn   = "<ASSETDB_ROLE_ARN>"
    stacklet_execution_role_arn = "<EXECUTION_ROLE_ARN>"
}
```

where values for the `stacklet_` prefixed variables are provided by Stacklet.


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.forward](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.forward](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_iam_policy.forward](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.discover](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.execution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.execution_extra](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.forward](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.discover_describe_augments](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.execution_describe_augments](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.execution_extra](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.execution_extra_describe_augments](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.forward](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachments_exclusive.discover](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachments_exclusive) | resource |
| [aws_iam_role_policy_attachments_exclusive.execution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachments_exclusive) | resource |
| [aws_iam_role_policy_attachments_exclusive.execution_extra](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachments_exclusive) | resource |
| [aws_arn.stacklet_assetdb_role_arn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/arn) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy.readonly_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy_document.describe_augments](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.discover_assume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.execution_assume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.execution_extra](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.forward](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.forward_assume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_execution_extra_roles"></a> [execution\_extra\_roles](#input\_execution\_extra\_roles) | Additional roles to grant to Stacklet for policies execution.<br/><br/>If provided, this must be a map from the role name (which gets the prefix<br/>prepended) and a list of permissions to grant to the role in addition to the<br/>default read-only permissions. | `map(list(string))` | `{}` | no |
| <a name="input_iam_path"></a> [iam\_path](#input\_iam\_path) | A path for created IAM roles. If set, it must include leading and trailing slashes. | `string` | `"/"` | no |
| <a name="input_regions"></a> [regions](#input\_regions) | Regions in which resources should be created. | `list(string)` | n/a | yes |
| <a name="input_resource_prefix"></a> [resource\_prefix](#input\_resource\_prefix) | An arbitrary prefix prepended to names of created resources. | `string` | n/a | yes |
| <a name="input_stacklet_assetdb_role_arn"></a> [stacklet\_assetdb\_role\_arn](#input\_stacklet\_assetdb\_role\_arn) | ARN for the role used by AssetDB - Provided by Stacklet. | `string` | n/a | yes |
| <a name="input_stacklet_execution_role_arn"></a> [stacklet\_execution\_role\_arn](#input\_stacklet\_execution\_role\_arn) | ARN for the role used by policies Execution - Provided by Stacklet. | `string` | n/a | yes |
| <a name="input_stacklet_external_id"></a> [stacklet\_external\_id](#input\_stacklet\_external\_id) | ID of the Stacklet deployment to restrict what can assume the roles - Provided by Stacklet. | `string` | n/a | yes |
| <a name="input_stacklet_target_event_bus_name"></a> [stacklet\_target\_event\_bus\_name](#input\_stacklet\_target\_event\_bus\_name) | Target event bus for event forwarding - Provided by Stacklet. | `string` | `"default"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_discover_role"></a> [discover\_role](#output\_discover\_role) | ARN for the resource-discovery role assumed by Stacklet AssetDB. |
| <a name="output_execution_extra_roles"></a> [execution\_extra\_roles](#output\_execution\_extra\_roles) | ARNs for extra policy-execution roles assumed by Stacklet Execution. |
| <a name="output_execution_role"></a> [execution\_role](#output\_execution\_role) | ARN for the default policy-execution role assumed by Stacklet Execution. |
| <a name="output_forward_role"></a> [forward\_role](#output\_forward\_role) | ARN for the role used to forward cloud events to Stacklet.<br/><br/>Only created when target account is different from the current one. |
<!-- END_TF_DOCS -->
