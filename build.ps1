$srcPath = "$PSScriptRoot\src"
$buildPath = "$PSScriptRoot\output"
$TestPath = "$PSScriptRoot\tests"
$moduleName = "PSModuleSample"
$modulePath = "$buildPath\$moduleName"
$author = 'Francois-Xavier Cat'
$CompanyName = 'Unknown'
$moduleVersion = '0.0.1'
$testResult = "Test-Results.xml"
$projectUri = "https://github.com/lazywinadmin/psmodulesample"

# Install dependendices
$Script:Modules = @(
    #'BuildHelpers',
    'InvokeBuild',
    'Pester'
    #'platyPS',
    #'PSScriptAnalyzer',
    #'DependsOn'
)
Get-PackageProvider -Name 'NuGet' -ForceBootstrap | Out-Null
if(-not(gmo $Script:Modules)){Install-Module -Name $Script:Modules -Force -scope CurrentUser -SkipPublisherCheck}

Invoke-Build -Result 'Result' -File .\build\.build.ps1

if ($Result.Error)
{
    $Error[-1].ScriptStackTrace | Out-String
    exit 1
}

exit 0