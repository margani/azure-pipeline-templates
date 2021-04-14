[CmdletBinding()]
param (
    [Parameter()][String]$EnvSubscriptions,
    [Parameter()][String]$EnvSubscription,
    [Parameter()][String]$Product
)

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
    }
}

New-Function `
    -EnvSubscriptions $EnvSubscriptions `
    -EnvSubscription $EnvSubscription `
    -Product $Product