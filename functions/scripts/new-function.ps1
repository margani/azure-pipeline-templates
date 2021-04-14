[CmdletBinding()]
param (
    [Parameter()][String]$EnvSubscriptions,
    [Parameter()][String]$EnvSubscription
)

Function New-Function {
    [CmdletBinding()]
    param (
        [Parameter()][String]$EnvSubscriptions,
        [Parameter()][String]$EnvSubscription
    )
    Process {
        Write-Host "EnvSubscriptions: $EnvSubscriptions"
        Write-Host "EnvSubscription: $EnvSubscription"
    }
}

New-Function `
    -EnvSubscriptions $EnvSubscriptions `
    -EnvSubscription $EnvSubscription