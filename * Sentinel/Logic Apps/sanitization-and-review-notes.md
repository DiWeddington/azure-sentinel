# Sanitization and Parameterization Notes

## FIM Monthly Metrics workbook

Sanitized/parameterized:
- Workbook display name
- Workbook source ID
- Workbook ID/GUID
- Location
- Cross-component Log Analytics workspace resource IDs

Review before production:
- The workbook depends on `MDCFileIntegrityMonitoringEvents` being available in the target workspace(s).
- `workspaceResourceIdsJson` must be a JSON array string, not a normal ARM array.

## FIM Reporting Logic App

Sanitized/parameterized:
- Logic App name
- Location
- Workflow enabled/disabled state
- Azure Monitor Logs API connection
- Target subscription/resource group/workspace
- Query timerange
- FIM KQL query
- Zendesk subdomain
- Zendesk authorization header as a `securestring`
- Zendesk assignee/submitter/requester IDs
- Client name, recipient, file prefix, and tag

Security remediation:
- Rotate the Zendesk credential from the original export.
- Store the replacement in Key Vault, a CI/CD secret, or secure deployment parameter handling.

## Distributed Password Logic App

Sanitized/parameterized:
- Logic App name
- Location
- Workflow enabled/disabled state
- Sentinel API connection
- Azure Monitor Logs API connection
- Target subscription/resource group/workspace
- Query timerange
- Legacy auth KQL query
- Auto-close/manual-investigation comments
- Close classification reason text

Review before production:
- The auto-close condition closes incidents if the query returns zero rows.
- Validate the KQL against the target client's Sentinel workspace before enabling.
- Consider scoping the query to the incident's relevant users/IPs/timeframe if you want more precise automation.
