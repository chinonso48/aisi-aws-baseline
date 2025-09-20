
locals {
  use_local_ebs_key  = var.create_kms_for_ebs  && var.kms_ebs_key_arn  == ""
  use_local_logs_key = var.create_kms_for_logs && var.kms_logs_key_arn == ""
  use_local_data_key = var.create_kms_for_data && var.kms_data_key_arn == ""
}

resource "aws_kms_key" "ebs" {
  count                   = local.use_local_ebs_key ? 1 : 0
  description             = "EBS default encryption key"
  deletion_window_in_days = 30
  enable_key_rotation     = true
}

resource "aws_kms_key" "logs" {
  count                   = local.use_local_logs_key ? 1 : 0
  description             = "Logs/Flow Logs encryption key"
  deletion_window_in_days = 30
  enable_key_rotation     = true
}

resource "aws_kms_key" "data" {
  count                   = local.use_local_data_key ? 1 : 0
  description             = "General data key for S3/RDS/etc."
  deletion_window_in_days = 30
  enable_key_rotation     = true
}
