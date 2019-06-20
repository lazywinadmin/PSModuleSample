<#
.SYNOPSIS
Used to start the build of a PowerShell Module
.DESCRIPTION
This script will install dependencies using PSDepend module and start the build tasks using InvokeBuild module
.NOTES
Change History
-1.0 | 2019/06/17 | Francois-Xavier Cat
    Initial version
TODO
-Check if we can fetch the information in the "Edit" part with BuildHelpers
-Make this file approach easily clonable
-Improve agnostic approach so it can work on any CI
-Minimalize files present in the root, possibly move build.ps1 ?
-Make the Build script flexible so we can call different tasks at different stages (build, deploy, tests..)
-Speed up dependencies installation
-Add more verbose/output messages
-Use invokebuild header ?
-Add filter on the build condition (if commit message "!deploy")
#>
[CmdletBinding()]
Param(
    #[string[]]$tasks,
    [string]$GalleryRepository,
    [pscredential]$GalleryCredential,
    [string]$GalleryProxy,
    [string[]]$tasks, # @('build','test','deploy')
    [switch]$InstallDependencies
    )
try{
    ################
    # EDIT THIS PART
    $moduleName = "PSModuleSample" # get from source control or module ?
    $author = 'Francois-Xavier Cat' # fetch from source or module
    $description = 'PowerShell test module' # fetch from module ?
    $companyName = 'lazywinadmin.com' # fetch from module ?
    $projectUri = "https://github.com/lazywinadmin/$moduleName" # get from module of from source control, env var
    ################

    #$rootpath = Split-Path -path $PSScriptRoot -parent
    $rootpath = $PSScriptRoot
    $buildOutputPath = "$rootpath\output"
    $buildPath = "$rootpath\build"
    $srcPath = "$rootpath\src"
    $testPath = "$rootpath\tests"
    $modulePath = "$buildoutputPath\$moduleName"
    $dependenciesPath = "$rootpath\dependencies" # folder to store modules
    $testResult = "Test-Results.xml"

    $requirementsFilePath = "$buildPath\requirements.psd1" # contains dependencies
    $buildTasksFilePath = "$buildPath\tasks.build.ps1" # contains tasks to execute

    if($InstallDependencies)
    {
        # Setup PowerShell Gallery as PSrepository  & Install PSDepend module
        if (-not(Get-PackageProvider -Name NuGet -ForceBootstrap)) {
            $providerBootstrapParams = @{
                Name = 'nuget'
                force = $true
                ForceBootstrap = $true
            }

            if($PSBoundParameters['verbose']) {$providerBootstrapParams.add('verbose',$verbose)}
            if($GalleryProxy) { $providerBootstrapParams.Add('Proxy',$GalleryProxy) }
            $null = Install-PackageProvider @providerBootstrapParams
            Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
        }

        if (-not(Get-Module -Listavailable -Name PSDepend)) {
            Write-verbose "BootStrapping PSDepend"
            "Parameter $buildOutputPath"| Write-verbose
            $InstallPSDependParams = @{
                Name = 'PSDepend'
                AllowClobber = $true
                Confirm = $false
                Force = $true
                Scope = 'CurrentUser'
            }
            if($PSBoundParameters['verbose']) { $InstallPSDependParams.add('verbose',$verbose)}
            if ($GalleryRepository) { $InstallPSDependParams.Add('Repository',$GalleryRepository) }
            if ($GalleryProxy)      { $InstallPSDependParams.Add('Proxy',$GalleryProxy) }
            if ($GalleryCredential) { $InstallPSDependParams.Add('ProxyCredential',$GalleryCredential) }
            Install-Module @InstallPSDependParams
        }

        # Install module dependencies with PSDepend
        $PSDependParams = @{
            Force = $true
            Path = $requirementsFilePath
        }
        if($PSBoundParameters['verbose']) { $PSDependParams.add('verbose',$verbose)}
        Invoke-PSDepend @PSDependParams -Target $dependenciesPath
        Write-Verbose -Message "Project Bootstrapped"
    }

    # Start build using InvokeBuild module
    Write-Verbose -Message "Start Build"
    Invoke-Build -Result 'Result' -File $buildTasksFilePath -Task $tasks

    # Return error to CI
    if ($Result.Error)
    {
        $Error[-1].ScriptStackTrace | Out-String
        exit 1
    }
    exit 0
}catch{
    throw $_
}
