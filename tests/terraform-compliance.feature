
Feature: Validate SCP JSON presence
  Scenario: Ensure SCPs exist
    Given I have file named org/scp/deny-disable-cloudtrail.json
    Then it must exist
