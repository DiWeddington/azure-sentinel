#!/usr/bin/env bash
set -euo pipefail

# Usage:
# ./deploy-workbook.azcli.sh <resource-group> <parameters-file>

RESOURCE_GROUP="${1:?resource group required}"
PARAMETERS_FILE="${2:?parameters file required}"

az deployment group create   --resource-group "$RESOURCE_GROUP"   --template-file ../workbooks/FIM-Monthly-Metrics.reusable.arm.json   --parameters "@$PARAMETERS_FILE"
