#!/usr/bin/env bash
set -euo pipefail

# Usage:
# ./deploy-logicapp.azcli.sh <resource-group> <template-file> <parameters-file>

RESOURCE_GROUP="${1:?resource group required}"
TEMPLATE_FILE="${2:?template file required}"
PARAMETERS_FILE="${3:?parameters file required}"

az deployment group create   --resource-group "$RESOURCE_GROUP"   --template-file "$TEMPLATE_FILE"   --parameters "@$PARAMETERS_FILE"
