variable "account_id" {
  type = string
}

variable "region" {
  type = string
}

variable "security_account_id" {
  type = string
}

variable "logging_account_id" {
  type = string
}

variable "logging_bucket_name" {
  type        = string
  description = "Central S3 bucket (in Logging account) for CloudTrail/Config/FlowLogs"
}

variable "cloudwatch_logs_kms_key_arn" {
  type        = string
  description = "KMS key ARN used to encrypt CloudWatch Logs (may be local or shared)"
}

variable "create_kms_for_ebs" {
  type    = bool
  default = true
}

variable "create_kms_for_logs" {
  type    = bool
  default = true
}

variable "create_kms_for_data" {
  type    = bool
  default = true
}

variable "kms_ebs_key_arn" {
  type    = string
  default = ""
}

variable "kms_logs_key_arn" {
  type    = string
  default = ""
}

variable "kms_data_key_arn" {
  type    = string
  default = ""
}

variable "required_tags" {
  description = "Required tag keys mapped to descriptions"
  type        = map(string)
  default = {
    Environment = "Workload environment (prod/nonprod)"
    Owner       = "Service owner"
    CostCenter  = "Billing code"
    DataClass   = "Public/Internal/Confidential/Restricted"
  }
}

variable "auto_tag_defaults" {
  description = "Defaults used by remediation when a resource is missing a required tag"
  type        = map(string)
  default = {
    Environment = "nonprod"
  }
}

variable "approved_regions" {
  type
