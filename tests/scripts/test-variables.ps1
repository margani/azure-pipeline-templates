[CmdletBinding()]
param (
    [Parameter()][String]$Name,
    [Parameter()][String]$Expected,
    [Parameter()][String]$Actual
)

Function Test-Variables {
    [CmdletBinding()]
    param (
        [Parameter()][String]$Name,
        [Parameter()][String]$Expected,
        [Parameter()][String]$Actual
    )
    Process {
        if ($Expected -ne $Actual) {
            throw "Value for $Name was expected to be $Expected but it's $Actual"
        } else {
            Write-Host "Value for $Name is as expected ($Expected): $Actual"
        }
    }
}

Test-Variables `
    -Name $Name `
    -Expected $Expected `
    -Actual $Actual