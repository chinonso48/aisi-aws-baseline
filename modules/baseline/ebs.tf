
resource "aws_ebs_encryption_by_default" "this" {
  enabled = true
}

resource "aws_ebs_default_kms_key" "this" {
  key_arn = coalesce(try(aws_kms_key.ebs.0.arn, null), var.kms_ebs_key_arn, try(aws_kms_key.data.0.arn, null))
}
