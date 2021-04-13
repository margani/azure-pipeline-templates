param(
    [String]$Stage,
    [String]$Job
)


Function Get-Variables {
    [CmdletBinding()]
    param(
        [String]$Stage,
        [String]$Job
    )
    Process {
        # Write-Output "##vso[task.setvariable variable=env-t51]t51"
        # Write-Output "##vso[task.setvariable variable=env-t52;isOutput=true]t52"
        # Write-Output "##vso[task.setvariable variable=env-t53;isOutput=true]t53"
        # Write-Output "##vso[task.setvariable variable=env-t1;isOutput=true]t1"
        # Write-Output "##vso[task.setvariable variable=env-a1;isOutput=true]a1"
        # Write-Output "##vso[task.setvariable variable=env-p1;isOutput=true]p1"
    }
}

Get-Variables `
    -Stage $Stage `
    -Job $Job