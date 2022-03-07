﻿$variablesPrefix = "var"

Function Get-EnvSubscriptionVarName($Env) {
    if ($Env) {
        return "$($variablesPrefix)env($Env)subscription"
    }
    return "$($variablesPrefix)envsubscription"
}

Function Get-EnvVar($VariableName) {
    return Get-ChildItem "Env:$($VariableName)*" | Where-Object { $_.Name -eq $VariableName } | Select-Object -ExpandProperty Value
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
    $env = Get-EnvVar("env")
    $envSubscriptionVarName = Get-EnvSubscriptionVarName($env)
    $envA1SubscriptionVarName = Get-EnvSubscriptionVarName("a1")

    $pipelineValues = @{
        EnvSubscriptions3  = Get-EnvVar("varSubscriptions")
        EnvSubscription3   = Get-EnvVar($envSubscriptionVarName)
        A1EnvSubscription3 = Get-EnvVar($envA1SubscriptionVarName)
        ProductName3       = Get-EnvVar("productName")
    }

    return $pipelineValues
}

Function Initialize-Pipeline(
    $VarSubscriptions,
    $Environment
) {
    $envSubscriptions = Get-EnvSubscriptions $VarSubscriptions
    $envSubscriptions.Keys | ForEach-Object {
        $env = $_
        $subscriptionName = $envSubscriptions[$_]

        Add-PipelineVariable -Name Get-EnvSubscriptionVarName($env) -Value $subscriptionName
        if ($env -eq $Environment) {
            Add-PipelineVariable -Name Get-EnvSubscriptionVarName -Value $subscriptionName
        }
    }
}
