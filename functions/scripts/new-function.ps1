[CmdletBinding()]
param (
    [Parameter()][String]$EnvSubscriptions,
    [Parameter()][String]$EnvSubscription,
    [Parameter()][String]$Product
)

$scriptPath = Split-Path -parent $MyInvocation.MyCommand.Path
Import-Module "$scriptPath/../../pipeline/scripts/helpers.psm1"

Function New-Function {
    [CmdletBinding()]
    param (
        [Parameter()][String]$EnvSubscriptions,
        [Parameter()][String]$EnvSubscription,
        [Parameter()][String]$Product
    )
    Process {
        Write-Host "EnvSubscriptions: $EnvSubscriptions"
        Write-Host "EnvSubscription: $EnvSubscription"
        Write-Host "Product: $Product"

        $pipelineValues = Get-PipelineValues
        Write-Host "EnvSubscriptions: $($pipelineValues.EnvSubscriptions)"
        Write-Host "EnvSubscription: $($pipelineValues.EnvSubscription)"
        Write-Host "A1EnvSubscription: $($pipelineValues.A1EnvSubscription)"
        Write-Host "ProductName: $($pipelineValues.ProductName)"

        Write-Host "EnvSubscriptions2: $($pipelineValues.EnvSubscriptions2)"
        Write-Host "A1EnvSubscription2: $($pipelineValues.A1EnvSubscription2)"
        Write-Host "ProductName2: $($pipelineValues.ProductName2)"

        Write-Host "EnvSubscriptions3: $($pipelineValues.EnvSubscriptions3)"
        Write-Host "EnvSubscription3: $($pipelineValues.EnvSubscription3)"
        Write-Host "A1EnvSubscription3: $($pipelineValues.A1EnvSubscription3)"
        Write-Host "ProductName3: $($pipelineValues.ProductName3)"
    }
}

New-Function `
    -EnvSubscriptions $EnvSubscriptions `
    -EnvSubscription $EnvSubscription `
    -Product $Product