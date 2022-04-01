$variablesPrefix = "var"

Function Get-EnvSubscriptionVarName($Env) {
    if ($Env) {
        return "$($variablesPrefix)env$($Env)subscription"
    }
    return "$($variablesPrefix)envsubscription"
}

Function Get-EnvVar($VariableName) {
    return Get-ChildItem "Env:$($VariableName)*" | Where-Object { $_.Name -eq $VariableName } | Select-Object -ExpandProperty Value
}

Function Get-EnvVars() {
    return Get-ChildItem "Env:$($variablesPrefix)*"
}

Function Get-EnvSubscriptions($EnvSubscriptionsString) {
    $envSubscriptions = @{}
    $EnvSubscriptionsString.Split(';', [System.StringSplitOptions]::RemoveEmptyEntries)
    | ForEach-Object {
        $envSubscription = $_
        $keyValue = $envSubscription.Split(':', [System.StringSplitOptions]::RemoveEmptyEntries)
        if ($keyValue.Length -eq 2) {
            $envs = $keyValue[0]
            $subscription = $keyValue[1].Trim()

            $envs.Split(',', [System.StringSplitOptions]::RemoveEmptyEntries)
            | ForEach-Object {
                $env = $_.Trim()
                $envSubscriptions.Add($env, $subscription)
            }
        }
    }

    return $envSubscriptions
}

Function Add-PipelineVariable($Name, $Value) {
    Write-Output "##vso[task.setvariable variable=$Name]$Value"
}

Function Get-PipelineValues() {
    $pipelineValues = @{
        Env         = Get-EnvVar("env")
        ProductName = Get-EnvVar("productName")
    }

    Get-EnvVars | ForEach-Object {
        $pipelineValues.Add($_.Name, $_.Value)
    }

    return $pipelineValues
}

Function Initialize-Pipeline(
    $Subscriptions,
    $Environment,
    $ProductCheckoutFolderName,
    $TemplatesCheckoutFolderName
) {
    $envSubscriptions = Get-EnvSubscriptions $Subscriptions
    $envSubscriptions.Keys | ForEach-Object {
        $env = $_
        $subscriptionName = $envSubscriptions[$_]

        Add-PipelineVariable -Name $(Get-EnvSubscriptionVarName($env)) -Value $subscriptionName
        if ($env -eq $Environment) {
            Add-PipelineVariable -Name $(Get-EnvSubscriptionVarName) -Value $subscriptionName
        }
    }

    Add-PipelineVariable -Name "ProductCheckoutFolderName" -Value $ProductCheckoutFolderName
    Add-PipelineVariable -Name "TemplatesCheckoutFolderName" -Value $TemplatesCheckoutFolderName

    $PipelineWorkspace = Get-EnvVar("Pipeline_Workspace")
    Add-PipelineVariable -Name "ProductCheckoutFolderPath" -Value $(Join-Path -Path $PipelineWorkspace -ChildPath $ProductCheckoutFolderName)
    Add-PipelineVariable -Name "TemplatesCheckoutFolderPath" -Value $(Join-Path -Path $PipelineWorkspace -ChildPath $TemplatesCheckoutFolderName)
}
