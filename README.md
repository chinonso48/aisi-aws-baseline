# AISI AWS Baseline

This repository provides a **Terraform baseline** for bootstrapping a new AWS account with day-one security controls, aligned to the AI Security Institute (AISI) challenge brief.

---

## Features
- **Centralized Logging**: CloudTrail, VPC Flow Logs, CloudWatch Logs, GuardDuty.
- **Encryption by Default**: Customer-managed KMS keys for EBS, Logs, Data (S3/RDS/etc.).
- **Tagging Enforcement**: AWS Config `REQUIRED_TAGS` rule; Org Tag Policy support; auto-remediation outline.
- **SCP Guardrails**: Prevent disabling CloudTrail, enforce encryption, deny public S3, restrict regions, protect KMS keys.

---

## Repo Structure
```
/modules/baseline      # Core Terraform module (logging, kms, tagging)
/org/scp               # Service Control Policies (JSON)
/org/tag-policies      # Organization Tag Policy (JSON)
/examples/new-account  # Example usage of the baseline module
/docs                  # Supporting documentation
README.md              # This file
```

---

## Prerequisites
- Terraform v1.x
- AWS CLI configured with credentials that have Organization and account bootstrap permissions.
- Access to central **Logging** and **Security** accounts (for cross-account ARNs, SCP attachment).

---

## Quick Start

### 1. Clone the repo
```bash
git clone https://github.com/YOUR_USER/aisi-aws-baseline.git
cd aisi-aws-baseline/examples/new-account
```

### 2. Initialize Terraform
```bash
terraform init
```

### 3. Review the plan
```bash
terraform plan
```

### 4. Apply the baseline
```bash
terraform apply
```

This will provision:
- CloudTrail + CloudWatch Logs
- GuardDuty detector
- KMS keys (EBS, Logs)
- AWS Config rule for required tags

### 5. Attach SCPs (Org Admin)
Apply SCPs in `/org/scp` at the desired OU or account via AWS Organizations console/CLI:
```bash
aws organizations attach-policy --policy-id <scp-id> --target-id <account-id>
```

### 6. Apply Tag Policy (Org Admin)
```bash
aws organizations attach-policy --policy-id <tag-policy-id> --target-id <ou-id>
```

---

## Example Variables
Edit `examples/new-account/main.tf` to customize:
```hcl
module "baseline" {
  source              = "../../modules/baseline"
  logging_bucket_name = "aisi-central-logs"
}
```

---

## Documentation
- [Purpose & Value](docs/purpose-and-value.md)
- [Adoption Plan](docs/adoption-plan.md)
- [Costs & Assumptions](docs/costs-and-assumptions.md)

---

## Notes
- SCPs enforce guardrails org-wide; Terraform module enforces account-level defaults.
- Exception tagging with expiry is supported (`ExceptionExpiry=YYYY-MM-DD`).
- For unit testing guardrails, see `terraform-compliance` or OPA/Conftest.

---

## License
MIT (for challenge submission use)
