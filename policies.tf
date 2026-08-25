data "aws_iam_policy_document" "describe_augments" {
  statement {
    actions = [
      "glue:GetConnections",
      "identitystore:Describe*",
      "identitystore:List*",
      "quicksight:ListDashboards",
      "quicksight:ListGroups",
      "quicksight:ListUsers",
      "securitylake:ListDataLakes",
      "securitylake:ListSubscribers",
      "securitylake:ListTagsForResource",
      "support:Describe*",
      "timestream-influxdb:ListDbClusters",
      "timestream-influxdb:ListDbInstances",
    ]
    resources = ["*"]
  }
}
