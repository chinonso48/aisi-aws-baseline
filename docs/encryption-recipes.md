
# Encryption Recipes (Examples)

## S3 (bucket default SSE-KMS)
```hcl
resource "aws_s3_bucket_server_side_encryption_configuration" "b" {
  bucket = "my-bucket"
  rule { apply_server_side_encryption_by_default { sse_algorithm = "aws:kms"; kms_master_key_id = module.baseline.kms_data_key_arn_out } }
}
```

## RDS
```hcl
resource "aws_db_instance" "db" {
  allocated_storage = 20
  engine            = "postgres"
  storage_encrypted = true
  kms_key_id        = module.baseline.kms_data_key_arn_out
}
```

## EFS
```hcl
resource "aws_efs_file_system" "efs" {
  encrypted  = true
  kms_key_id = module.baseline.kms_data_key_arn_out
}
```

## DynamoDB
```hcl
resource "aws_dynamodb_table" "t" {
  name         = "table"
  billing_mode = "PAY_PER_REQUEST"
  server_side_encryption {
    enabled     = true
    kms_key_arn = module.baseline.kms_data_key_arn_out
  }
}
```

## OpenSearch
```hcl
resource "aws_opensearch_domain" "os" {
  domain_name = "search"
  encrypt_at_rest { enabled = true; kms_key_id = module.baseline.kms_data_key_arn_out }
}
```

## SNS/SQS
```hcl
resource "aws_sns_topic" "t" { kms_master_key_id = module.baseline.kms_data_key_arn_out }
resource "aws_sqs_queue" "q" { kms_master_key_id = module.baseline.kms_data_key_arn_out }
```

## CloudWatch Logs
```hcl
resource "aws_cloudwatch_log_group" "lg" { name = "/app/logs"; kms_key_id = module.baseline.kms_logs_key_arn_out }
```

## Secrets Manager
```hcl
resource "aws_secretsmanager_secret" "s" { kms_key_id = module.baseline.kms_data_key_arn_out }
```
