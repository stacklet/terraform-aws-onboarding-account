data "aws_iam_policy_document" "describe_augments" {
  statement {
    actions = [
      "aiops:ListTagsForResource",
      "airflow:GetEnvironment",
      "glue:GetConnections",
      "qbusiness:ListDataAccessors",
      "quicksight:ListDashboards",
      "quicksight:ListDataSources",
      "quicksight:ListGroups",
      "quicksight:ListTagsForResource",
      "quicksight:ListUsers",
      "sdb:DomainMetadata",
      "timestream-influxdb:GetDbCluster",
      "timestream-influxdb:GetDbInstance",
      "timestream-influxdb:ListDbClusters",
      "timestream-influxdb:ListDbInstances",
    ]
    resources = ["*"]
  }
}
