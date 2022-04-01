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
        Write-Host "Env: [$Env]"
        Write-Host "Product: [$Product]"
        Write-Host "EnvSubscriptions: [$EnvSubscriptions]"
        Write-Host "EnvSubscription: [$EnvSubscription]"

        $pipelineValues = Get-PipelineValues
        Write-Host "Env: [$($pipelineValues.Env)]"
        Write-Host "ProductName: [$($pipelineValues.ProductName)]"
        Write-Host "EnvSubscriptions: [$($pipelineValues.VarEnvSubscriptions)]"
        Write-Host "EnvSubscription: [$($pipelineValues.VarEnvSubscription)]"
        Write-Host "VarA1EnvSubscription: [$($pipelineValues.VarA1EnvSubscription)]"
    }
}

New-Function `
    -EnvSubscriptions $EnvSubscriptions `
    -EnvSubscription $EnvSubscription `
    -Product $Product