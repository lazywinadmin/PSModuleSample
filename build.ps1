$moduleName = "PSModuleSample"
$srcPath = "$PSScriptRoot\src"
$outputPath = "$PSScriptRoot\output"
$buildPath = "$PSScriptRoot\build"
$testPath = "$PSScriptRoot\tests"
$modulePath = "$outputPath\$moduleName"
$author = 'Francois-Xavier Cat'
$description = 'PowerShell test module'
$companyName = 'lazywinadmin.com'
#$moduleVersion = '0.0.1'
$testResult = "Test-Results.xml"
$projectUri = "https://github.com/lazywinadmin/$moduleName"


# Install dependendices
$Script:Modules = @(
    #'BuildHelpers',
    'InvokeBuild',
    'Pester',
    'PSDeploy',
    'BuildHelpers'
    #'platyPS',
    #'PSScriptAnalyzer',
    #'DependsOn'
)


Get-PackageProvider -Name 'NuGet' -ForceBootstrap | Out-Null

$Script:Modules | %{
    $CurrentModule = $_
    if(-not(Get-Module -Name $CurrentModule -list))
    {
        Install-Module -Name $CurrentModule -Force -Scope CurrentUser -SkipPublisherCheck
    }
}

# Define last module version
Import-Module -name BuildHelpers
$moduleVersion = Get-NextNugetPackageVersion -Name $moduleName

# Start build
Invoke-Build -Result 'Result' -File (join-path -path $buildPath -ChildPath ".build.ps1")

if ($Result.Error)
{
    $Error[-1].ScriptStackTrace | Out-String
    exit 1
}

exit 0