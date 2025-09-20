
resource "aws_s3_bucket_server_side_encryption_configuration" "defaults" {
  for_each = toset(var.s3_bucket_names)
  bucket   = each.value
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = coalesce(try(aws_kms_key.data.0.arn, null), var.kms_data_key_arn, try(aws_kms_key.logs.0.arn, null))
    }
  }
}
