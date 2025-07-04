resource_prefix = "atlantis"
regions         = ["us-east-1", "us-east-2"]

# Use the QA deployment as target, to point to a different account than Dev.
stacklet_external_id        = "b5748e1f-0fa5-47c2-b9e2-84108424dd6a"
stacklet_assetdb_role_arn   = "arn:aws:iam::179874453562:role/qa-collector"
stacklet_execution_role_arn = "arn:aws:iam::179874453562:role/qa-stacklet-execution"
