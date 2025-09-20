
# Automated Remediation Outline

- **Detection:** AWS Config `REQUIRED_TAGS` rule flags NON_COMPLIANT resources.
- **Action:** An SSM Automation or Lambda is triggered (via EventBridge) to apply `auto_tag_defaults` to the resource.
- **Notify:** Publish to SNS topic `aisi-config-notifications` with details of resource and remediation outcome.
- **Exceptions:** If resource has `Exception=true` and `ExceptionExpiry` in future, remediation skips and logs rationale. Overdue exceptions are surfaced in weekly reports.
