resource "aws_iam_role" "discover" {
  name               = "${var.resource_prefix}-discover"
  description        = "Read-Only Resource Collection for ${var.resource_prefix} Stacklet deployment"
  path               = var.iam_path
  assume_role_policy = data.aws_iam_policy_document.discover_assume.json
}

data "aws_iam_policy_document" "discover_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = [var.stacklet_assetdb_role_arn]
    }
    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [var.stacklet_external_id]
    }
  }
}

resource "aws_iam_role_policy_attachments_exclusive" "discover" {
  role_name   = aws_iam_role.discover.name
  policy_arns = [data.aws_iam_policy.readonly_access.arn]
}

resource "aws_iam_role_policy" "discover_describe_augments" {
  name   = "DescribeAugments"
  role   = aws_iam_role.discover.id
  policy = data.aws_iam_policy_document.describe_augments.json
}
