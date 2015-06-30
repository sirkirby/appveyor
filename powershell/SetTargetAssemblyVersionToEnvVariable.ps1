[CmdletBinding()]
Param(
    [Parameter(Mandatory=$True)]
    [string] $assemblyPath,
    [string] $versionEnvVariable = "X_assembly_version",
    [string] $conditionEnvVariable = "X_deploy"
)

$exists = Test-Path $assemblyPath
If($exists)
{
    $aav  = ls $assemblyPath | % versioninfo
    # set the semver string to your custom environment variable
    Set-AppveyorBuildVariable -Name $versionEnvVariable -Value $aav.ProductVersion
    Write-Host "Set env varialble" $versionEnvVariable "to" $aav.ProductVersion
    # set a custom environment varialble for use in later stage conditions, like Deployment
    Set-AppveyorBuildVariable -Name $conditionEnvVariable -Value $exists
    Write-Host "Set env varialble" $conditionEnvVariable "to" $exists
}