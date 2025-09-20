
# Baseline module composition
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# KMS keys and defaults
module "kms" { 
source = "./"; } 
# keys live in kms.tf
} 
# EBS defaults
# logging (CloudTrail + Flow Logs + GuardDuty)
# s3 encryption defaults
# tagging (AWS Config)

# The resources are declared directly in this module split across files:
# - kms.tf, ebs.tf, logging.tf, s3_encryption.tf, tagging.tf
