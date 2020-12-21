param(
    [switch]$deploy
)

$subscriptionName = "Clyfar Superscription"
$name = "create_acr"
$resourceGroupName = "conner-sandbox"
$templateFile = "$PSScriptRoot\..\infrastructure\ACR\deployContainerRegistry.json"
$templateParameterFile = "$PSScriptRoot\deploy_acr.json"

Write-Host "Azure Subscription: $subscriptionName"
Write-Host "Name $name"
Write-Host "resourceGroupName $resourceGroupName"
Write-Host "TemplateFile: $templateFile"
Write-Host "TemplateParameterFile: $templateParameterFile"

$VerbosePreference = "Continue"
$ErrorActionPreference = "Stop"

if ((Get-AzContext).Subscription.Name -ne $subscriptionName){
    throw "Not logged in to correct subscription $subscriptionName"
}

if ($deploy){
    New-AzResourceGroupDeployment -Name $name `
                                    -ResourceGroupName $resourceGroupName `
                                    -Mode Incremental `
                                    -Verbose `
                                    -TemplateFile $templateFile `
                                    -TemplateParameterFile $templateParameterFile
} else {
    Test-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName `
                                    -TemplateParameterFile $templateParameterFile `
                                    -TemplateFile $templateFile `
                                    -Verbose
}
