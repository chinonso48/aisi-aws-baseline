terraform {
  required_version = ">= 1.3"
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

module "baseline" {
  source = "../../modules/baseline"

  account_id          = var.account_id
  region              = var.region
  security_account_id = var.security_account_id
  logging_account_id  = var.logging_account_id
  logging_bucket_name = var.logging_bucket_name

  # Optional inputs
  vpc_ids          = var.vpc_ids
  s3_bucket_names  = var.s3_bucket_names
}

# Variables
variable "account_id" {
  type = string
}

variable "region" {
  type    = string
  default = "eu-west-2"
}

variable "security_account_id" {
  type = string
}

variable "logging_account_id" {
  type = string
}

variable "logging_bucket_name" {
  type = string
}

# Optional: flow logs across multiple VPCs
variable "vpc_ids" {
  type        = list(string)
  default     = []
  description = "VPC IDs to enable Flow Logs for (leave empty to skip)"
}

# Optional: buckets created in-account that should have SSE-KMS defaults set
variable "s3_bucket_names" {
  type        = list(string)
  default     = []
  description = "Buckets created in-account that should have SSE-KMS defaults set"
}
