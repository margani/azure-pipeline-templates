[CmdletBinding()]
param (
    [Parameter()]
    [String]
    $EnvSubscriptions
)

Function Initialize-Pipeline {
    [CmdletBinding()]
    param (
        [Parameter()]
        [String]
        $EnvSubscriptions
    )
    Process {
        Write-Host "EnvSubscriptions: $EnvSubscriptions"
        Write-Output "##vso[task.setvariable variable=ci-subscription]myorg-devtest-subscription"
    }
}

Initialize-Pipeline `
    -EnvSubscriptions $EnvSubscriptions