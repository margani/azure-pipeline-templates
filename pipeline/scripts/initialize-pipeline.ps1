[CmdletBinding()]
param (
    [Parameter()][String]$VarSubscriptions,
    [Parameter()][String]$Environment
)

$scriptPath = Split-Path -parent $MyInvocation.MyCommand.Path
Import-Module "$scriptPath\helpers.psm1"

Initialize-Pipeline `
    -VarSubscriptions "$VarSubscriptions" `
    -Environment "$Environment"
