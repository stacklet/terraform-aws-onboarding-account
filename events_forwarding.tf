locals {
  destination_account_id   = data.aws_arn.stacklet_assetdb_role_arn.account
  different_target_account = data.aws_caller_identity.current.account_id != local.destination_account_id
  event_regions            = local.different_target_account ? toset(var.regions) : toset([])
}

resource "aws_cloudwatch_event_rule" "forward" {
  for_each = local.event_regions

  name        = "${var.resource_prefix}-event-forward"
  description = "Event forwarding for ${var.resource_prefix} Stacklet deployment"
  event_pattern = jsonencode({
    "$or" = [
      # Matches for cloudtrail mode
      {
        detail-type = ["AWS API Call via CloudTrail"]
        detail = {
          eventSource = [
            {
              "anything-but" = ["sts.amazonaws.com"]
            }
          ],
          errorCode = [
            {
              exists = false
            }
          ],
          readOnly        = [false]
          managementEvent = [true]
        }
      },
      # Matches for all other modes
      {
        detail-type = [
          "AWS Console Sign In via CloudTrail",
          # ec2-instance-state mode
          "EC2 Instance State-change Notification",
          # guard duty mode
          "GuardDuty Finding",
          # phd mode
          "AWS Health Event",
          # asg-instance-state mode
          "EC2 Instance Launch Successful",
          "EC2 Instance Launch Unsuccessful",
          "EC2 Instance Terminate Successful",
          "EC2 Instance Terminate Unsuccessful",
          # hub-finding
          "Security Hub Findings - Imported",
          # hub-action
          "Security Hub Findings - Custom Action",
          "Security Hub Insight Results"
        ]
      }
    ]
  })

  region = each.key
}

resource "aws_cloudwatch_event_target" "forward" {
  for_each = local.event_regions

  target_id = "${var.resource_prefix}-event-forward"
  rule      = aws_cloudwatch_event_rule.forward[each.key].name
  arn = provider::aws::arn_build(
    data.aws_partition.current.partition,
    "events",
    each.key,
    local.destination_account_id,
    "event-bus/${var.stacklet_target_event_bus_name}"
  )
  role_arn = aws_iam_role.forward[0].arn

  region = each.key
}

# Event forwarding role

resource "aws_iam_role" "forward" {
  count = local.different_target_account ? 1 : 0

  name               = "${var.resource_prefix}-forward"
  description        = "Event forwarding for ${var.resource_prefix} Stacklet deployment"
  path               = var.iam_path
  assume_role_policy = data.aws_iam_policy_document.forward_assume.json
}

data "aws_iam_policy_document" "forward_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "forward" {
  for_each = local.event_regions

  role       = aws_iam_role.forward[0].name
  policy_arn = aws_iam_policy.forward[each.key].arn
}

resource "aws_iam_policy" "forward" {
  for_each = local.event_regions

  name        = "${var.resource_prefix}-forward-events-${each.key}"
  description = "Forward events for ${var.resource_prefix} Stacklet deployment in region ${each.key}"
  path        = var.iam_path
  policy      = data.aws_iam_policy_document.forward[each.key].json
}

data "aws_iam_policy_document" "forward" {
  for_each = local.event_regions

  statement {
    actions = ["events:PutEvents"]
    resources = [
      provider::aws::arn_build(
        data.aws_partition.current.partition,
        "events",
        each.key,
        local.destination_account_id,
        "event-bus/${var.stacklet_target_event_bus_name}"
      )
    ]
  }
}
