
resource "aws_cloudwatch_log_group" "trail" {
  name              = "/aws/aisi/cloudtrail"
  kms_key_id        = coalesce(try(aws_kms_key.logs.0.arn, null), var.kms_logs_key_arn, var.cloudwatch_logs_kms_key_arn)
  retention_in_days = 365
}

data "aws_iam_policy_document" "trust_cloudtrail" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "trail_to_cw" {
  name               = "AISI-CloudTrail-to-CW"
  assume_role_policy = data.aws_iam_policy_document.trust_cloudtrail.json
}

resource "aws_cloudtrail" "account_trail" {
  name                          = "aisi-account-trail"
  s3_bucket_name                = var.logging_bucket_name
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true

  cloud_watch_logs_group_arn = aws_cloudwatch_log_group.trail.arn
  cloud_watch_logs_role_arn  = aws_iam_role.trail_to_cw.arn
  kms_key_id                 = coalesce(try(aws_kms_key.logs.0.arn, null), var.kms_logs_key_arn)
}

# GuardDuty
resource "aws_guardduty_detector" "this" {
  enable = true
}

# VPC Flow Logs (if VPC IDs provided)
resource "aws_cloudwatch_log_group" "vpc_flow" {
  count             = length(var.vpc_ids) > 0 ? 1 : 0
  name              = "/aws/aisi/vpc-flow"
  kms_key_id        = coalesce(try(aws_kms_key.logs.0.arn, null), var.kms_logs_key_arn, var.cloudwatch_logs_kms_key_arn)
  retention_in_days = 120
}

data "aws_iam_policy_document" "trust_vpcflow" {
  statement { actions = ["sts:AssumeRole"]; principals { type = "Service" identifiers = ["vpc-flow-logs.amazonaws.com"] } }
}

resource "aws_iam_role" "vpc_flow" {
  count              = length(var.vpc_ids) > 0 ? 1 : 0
  name               = "AISI-VPC-FlowRole"
  assume_role_policy = data.aws_iam_policy_document.trust_vpcflow.json
}

resource "aws_flow_log" "vpc" {
  for_each        = toset(var.vpc_ids)
  iam_role_arn    = aws_iam_role.vpc_flow[0].arn
  log_destination = aws_cloudwatch_log_group.vpc_flow[0].arn
  traffic_type    = "ALL"
  vpc_id          = each.value
}
