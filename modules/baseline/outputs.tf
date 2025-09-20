output "kms_ebs_key_arn_out" {
  description = "KMS ARN for EBS encryption (created or provided)"
  value       = try(aws_kms_key.ebs[0].arn, var.kms_ebs_key_arn, null)
}

output "kms_logs_key_arn_out" {
  description = "KMS ARN for CloudWatch Logs encryption (created or provided)"
  value       = try(aws_kms_key.logs[0].arn, var.kms_logs_key_arn, null)
}

output "kms_data_key_arn_out" {
  description = "KMS ARN for data encryption (created or provided)"
  value       = try(aws_kms_key.data[0].arn, var.kms_data_key_arn, null)
}

