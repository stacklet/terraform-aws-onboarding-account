data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}

data "aws_iam_policy" "readonly_access" {
  name = "ReadOnlyAccess"
}
