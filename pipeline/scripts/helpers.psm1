Function Get-EnvSubscriptionVarName($Env) {
    if ($Env) {
        return "env-$Env-subscription"
    }
    return "env-subscription"
}
