
#Install-Module -Name InvokeBuild,Pester -Force -scope CurrentUser -SkipPublisherCheck
#Import-Module -Name InvokeBuild,Pester

task -name installmodule {
    if(-not(Get-Module -Name Pester,PSScriptAnalyzer)) {
        Install-Module -Name Pester -Force -scope CurrentUser -SkipPublisherCheck
        Install-Module -Name PSScriptAnalyzer -Force -scope CurrentUser
    }
    else {"Modules are already present"}
}

<#
task -name Analyze {
    $scriptAnalyzerParams = @{
        Path = "$BuildRoot\DSCClassResources\TeamCityAgent\"
        Severity = @('Error', 'Warning')
        Recurse = $true
        Verbose = $false
        ExcludeRule = 'PSUseDeclaredVarsMoreThanAssignments'
    }

    $saResults = Invoke-ScriptAnalyzer @scriptAnalyzerParams

    if ($saResults) {
        $saResults | Format-Table
        throw "One or more PSScriptAnalyzer errors/warnings where found."
    }
}
#>
task -Name build {
    # Retrieve public functions
    $publicFiles = @(Get-ChildItem -Path $srcPath\public\*.ps1 -ErrorAction SilentlyContinue)
    # Retrieve private functions
    $privateFiles = @(Get-ChildItem -Path $srcPath\private\*.ps1 -ErrorAction SilentlyContinue)

    # Create build output directory if does not exist yet
    if(-not (Test-Path -path $modulePath))
    {
        New-Item -Path $modulePath -ItemType Directory
    }

    # Build PSM1 file with all the functions
    foreach($file in @($publicFiles + $privateFiles))
    {
        Get-Content -Path $($file.fullname) |
            Out-File -FilePath "$modulePath\$moduleName.psm1" -Append -Encoding utf8
    }

    # Copy the Manifest to the build (psd1)
    Copy-Item -Path "$srcPath\source.psd1" -Destination $modulePath
    Rename-Item -Path "$modulePath\source.psd1" -NewName "$moduleName.psd1" -PassThru


    $moduleManifestData = @{
        Author = $author
        Copyright = "(c) $((Get-Date).year) $author. All rights reserved."
        Path = "$modulepath\$moduleName.psd1"
        FunctionsToExport = $publicFiles.basename
        Rootmodule = "$moduleName.psm1"
        ModuleVersion = $moduleVersion
        ProjectUri = $projectUri
        CompanyName = $CompanyName
    }
    Update-ModuleManifest @moduleManifestData
    Import-Module -Name $modulePath -RequiredVersion $moduleVersion

}

task -Name clean {
    # Output folder
    Remove-Item -confirm:$false -Recurse -path $outputPath -ErrorAction SilentlyContinue
}

task -Name test {
    # Run test build
    Invoke-Pester -Path $TestPath -OutputFormat NUnitXml -OutputFile $outputPath\$testResult -PassThru
}

task -Name publish {
    Invoke-PSDeploy -Path $buildPath\.psdeploy.ps1 -
}

# Run clean and build
task -Name . clean,build,test