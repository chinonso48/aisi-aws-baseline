
provider "aws" { region = var.region }

module "baseline" {
  source                 = "../../modules/baseline"
  account_id             = var.account_id
  region                 = var.region
  security_account_id    = var.security_account_id
  logging_account_id     = var.logging_account_id

  logging_bucket_name         = var.logging_bucket_name
  cloudwatch_logs_kms_key_arn = var.cloudwatch_logs_kms_key_arn

  # Provide VPCs to enable flow logs
  vpc_ids = var.vpc_ids

  # Example buckets created in this account to enforce SSE-KMS defaults on
  s3_bucket_names = var.s3_bucket_names

  # Optionally supply existing key ARNs instead of creating new
  # kms_ebs_key_arn  = "..."
  # kms_logs_key_arn = "..."
  # kms_data_key_arn = "..."
}

variable "account_id"          { type = string }
variable "region"              { type = string }
variable "security_account_id" { type = string }
variable "logging_account_id"  { type = string }
variable "logging_bucket_name" { type = string }
variable "cloudwatch_logs_kms_key_arn" { type = string }
variable "vpc_ids" {
  type        = list(string)
  default     = []
  description = "VPC IDs to enable Flow Logs for (leave empty to skip)"
}
variable "s3_bucket_names"     { type = list(string)  default = [] }
