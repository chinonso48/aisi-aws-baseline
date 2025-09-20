resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  for_each = toset(var.s3_bucket_names)

  bucket = each.value

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = var.kms_data_key_arn != "" ? var.kms_data_key_arn : null
    }
  }
}
