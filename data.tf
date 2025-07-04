data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

data "aws_arn" "stacklet_assetdb_role_arn" {
  arn = var.stacklet_assetdb_role_arn
}

data "aws_iam_policy" "readonly_access" {
  name = "ReadOnlyAccess"
}
