
output "kms_ebs_key_arn_out"  { value = try(aws_kms_key.ebs.arn, var.kms_ebs_key_arn) }
output "kms_logs_key_arn_out" { value = try(aws_kms_key.logs.arn, var.kms_logs_key_arn) }
output "kms_data_key_arn_out" { value = try(aws_kms_key.data.arn, var.kms_data_key_arn) }
