
# Costs & Assumptions
**Assumptions:** AWS Organizations with Security & Logging accounts; org-wide CloudTrail or central logging S3 exists; multi-account landing zone.

**Costs:**
- CloudTrail: management + data events.
- KMS: per-key and request charges.
- AWS Config: per-recorded resource + evaluation. Scope selectively to manage cost.
