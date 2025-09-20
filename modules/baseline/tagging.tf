
data "aws_iam_policy_document" "trust_config" {
  statement { actions = ["sts:AssumeRole"]; principals { type = "Service" identifiers = ["config.amazonaws.com"] } }
}

resource "aws_iam_role" "config" {
  name               = "AISI-Config-RecorderRole"
  assume_role_policy = data.aws_iam_policy_document.trust_config.json
}

resource "aws_config_configuration_recorder" "this" {
  name     = "aisi-recorder"
  role_arn = aws_iam_role.config.arn
}

resource "aws_config_delivery_channel" "this" {
  name           = "aisi-channel"
  s3_bucket_name = var.logging_bucket_name
  depends_on     = [aws_config_configuration_recorder.this]
}

resource "aws_config_configuration_recorder_status" "this" {
  is_enabled = true
  name       = aws_config_configuration_recorder.this.name
}

resource "aws_config_config_rule" "required_tags" {
  name = "aisi-required-tags"
  source { owner = "AWS" source_identifier = "REQUIRED_TAGS" }
  input_parameters = jsonencode({
    tag1Key = "Environment"
    tag2Key = "Owner"
    tag3Key = "CostCenter"
  })
}

# (Optional) Auto-remediation outline: see docs/remediation-outline.md
