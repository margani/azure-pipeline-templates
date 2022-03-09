[CmdletBinding()]
param (
    [Parameter()][String]$VarSubscriptions,
    [Parameter()][String]$Environment,
    [Parameter()][String]$ProductCheckoutFolderName,
    [Parameter()][String]$TemplatesCheckoutFolderName
)

$scriptPath = Split-Path -parent $MyInvocation.MyCommand.Path
Import-Module "$scriptPath\helpers.psm1"

Initialize-Pipeline `
    -VarSubscriptions "$VarSubscriptions" `
    -Environment "$Environment" `
    -ProductCheckoutFolderName "$ProductCheckoutFolderName" `
    -TemplatesCheckoutFolderName "$TemplatesCheckoutFolderName"
