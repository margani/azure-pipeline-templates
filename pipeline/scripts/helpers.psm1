Function Get-EnvSubscriptionVarName($Env) {
    if ($Env) {
        return "env($Env)subscription"
    }
    return "envsubscription"
}

Function Get-EnvVar($VariableName) {
    return Get-ChildItem "Env:$($VariableName)*" | Where-Object { $_.Name -eq $VariableName } | Select-Object -ExpandProperty Value
}

Function Get-PipelineValues() {
    $env = [System.Environment]::GetEnvironmentVariable("env", 'Process')
    $envSubscriptionVarName = Get-EnvSubscriptionVarName($env)
    $envA1SubscriptionVarName = Get-EnvSubscriptionVarName("a1")

    $pipelineValues =  @{
        EnvSubscriptions = [System.Environment]::GetEnvironmentVariable("varSubscriptions", 'Process')
        EnvSubscription = [System.Environment]::GetEnvironmentVariable($envSubscriptionVarName, 'Process')
        A1EnvSubscription = [System.Environment]::GetEnvironmentVariable($envA1SubscriptionVarName, 'Process')
        ProductName = [System.Environment]::GetEnvironmentVariable("productName", 'Process')

        EnvSubscriptions2 = $Env:varSubscriptions
        A1EnvSubscription2 = $env:enva1subscription
        ProductName2 = $Env:productName

        EnvSubscriptions3 = Get-EnvVar("varSubscriptions")
        EnvSubscription3 = Get-EnvVar($envSubscriptionVarName)
        A1EnvSubscription3 = Get-EnvVar($envA1SubscriptionVarName)
        ProductName3 = Get-EnvVar("productName")
    }

    return $pipelineValues
}
