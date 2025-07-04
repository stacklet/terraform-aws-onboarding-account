data "aws_iam_policy_document" "describe_augments" {
  statement {
    actions = [
      "identitystore:Describe*",
      "identitystore:List*",
      "quicksight:ListGroups",
      "quicksight:ListUsers",
      "support:Describe*",
    ]
    resources = ["*"]
  }
}
