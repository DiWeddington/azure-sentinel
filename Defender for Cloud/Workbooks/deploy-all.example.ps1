param(
    [Parameter(Mandatory=$true)][string]$ResourceGroupName,
    [Parameter(Mandatory=$true)][string]$WorkbookParametersFile,
    [Parameter(Mandatory=$true)][string]$FimLogicAppParametersFile,
    [Parameter(Mandatory=$true)][string]$DistributedPasswordParametersFile
)

New-AzResourceGroupDeployment `
    -ResourceGroupName $ResourceGroupName `
    -TemplateFile "../workbooks/FIM-Monthly-Metrics.reusable.arm.json" `
    -TemplateParameterFile $WorkbookParametersFile

New-AzResourceGroupDeployment `
    -ResourceGroupName $ResourceGroupName `
    -TemplateFile "../logic-apps/FIM-Reporting.reusable.arm.json" `
    -TemplateParameterFile $FimLogicAppParametersFile

New-AzResourceGroupDeployment `
    -ResourceGroupName $ResourceGroupName `
    -TemplateFile "../logic-apps/Distributed-Password-AutoClose.reusable.arm.json" `
    -TemplateParameterFile $DistributedPasswordParametersFile
