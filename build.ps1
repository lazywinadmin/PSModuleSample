$moduleName = "PSModuleSample"
$srcPath = "$PSScriptRoot\src"
$outputPath = "$PSScriptRoot\output"
$buildPath = "$PSScriptRoot\build"
$testPath = "$PSScriptRoot\tests"
$modulePath = "$outputPath\$moduleName"
$author = 'Francois-Xavier Cat'
$companyName = 'LazyWinAdmin.com'
$moduleVersion = '0.0.1'
$testResult = "Test-Results.xml"
$projectUri = "https://github.com/lazywinadmin/$moduleName"

# Install dependendices
$Script:Modules = @(
    #'BuildHelpers',
    'InvokeBuild',
    'Pester',
    'PSDeploy'
    #'platyPS',
    #'PSScriptAnalyzer',
    #'DependsOn'
)

Get-PackageProvider -Name 'NuGet' -ForceBootstrap | Out-Null
if(-not(Get-Module -Name $Script:Modules))
{
    Install-Module -Name $Script:Modules -Force -Scope CurrentUser -SkipPublisherCheck
}

Invoke-Build -Result 'Result' -File .\build\.build.ps1

if ($Result.Error)
{
    $Error[-1].ScriptStackTrace | Out-String
    exit 1
}

exit 0