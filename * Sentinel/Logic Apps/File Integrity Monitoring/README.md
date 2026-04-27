# Reusable Client Deployment Package

This package contains sanitized, reusable ARM templates created from the uploaded workbook and Logic App exports.

## Contents

- `workbooks/FIM-Monthly-Metrics.reusable.arm.json`
  - Reusable ARM template for the FIM Monthly Metrics workbook.
  - Uses `Microsoft.Insights/workbooks`.
  - Replaces hard-coded Log Analytics workspace resource IDs with the `workspaceResourceIdsJson` parameter.

- `logic-apps/FIM-Reporting.reusable.arm.json`
  - Reusable ARM template for the weekly FIM reporting Logic App.
  - Replaces hard-coded subscription/resource group/workspace values with parameters.
  - Replaces the embedded Zendesk authorization header with a `securestring` parameter.

- `logic-apps/Distributed-Password-AutoClose.reusable.arm.json`
  - Reusable ARM template for the Sentinel distributed password cracking auto-close Logic App.
  - Replaces hard-coded subscription/resource group/workspace/API connection values with parameters.
  - Corrects the timerange typo from `Lasy 7 days` to `Last 7 days` in the reusable parameter example.

## Recommended deployment order

1. Create or confirm the target resource group.
2. Create/authorize required API connections:
   - Azure Monitor Logs connection
   - Microsoft Sentinel connection, for the distributed password workflow
3. Deploy the reusable ARM templates with a client-specific parameter file.
4. Grant the Logic App managed identity the required permissions:
   - Log Analytics Reader or equivalent on the target workspace
   - Microsoft Sentinel Contributor/Responder permissions as appropriate for incident comment/update actions
5. Run a controlled test before enabling broad production use.

## Important security note

The original FIM Logic App export contained an embedded Zendesk `Authorization` header. The reusable template does not preserve that value. Rotate the original Zendesk token and supply the replacement securely at deployment time through a secure parameter, Key Vault-backed parameter flow, or CI/CD secret store.

## Azure CLI example

```bash
az deployment group create   --resource-group <resource-group>   --template-file logic-apps/FIM-Reporting.reusable.arm.json   --parameters @logic-apps/FIM-Reporting.parameters.example.json
```

## PowerShell example

```powershell
New-AzResourceGroupDeployment `
  -ResourceGroupName "<resource-group>" `
  -TemplateFile "logic-apps/FIM-Reporting.reusable.arm.json" `
  -TemplateParameterFile "logic-apps/FIM-Reporting.parameters.example.json"
```

## Client-specific values to update

For each client, create a copy of the `.parameters.example.json` files and update:

- Subscription ID
- Resource group name
- Azure region
- Log Analytics workspace name/resource ID
- API connection names/resource IDs
- Zendesk subdomain and ticket user IDs
- Client display name, file prefix, and tags
- KQL query body if the client uses multiple workspaces or a different schema
- Stable workbook GUID if repeat deployments should update the same workbook
