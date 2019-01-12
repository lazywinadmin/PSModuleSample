$projectRoot = Resolve-Path -Path "$PSScriptRoot\.."
$moduleRoot = Split-Path -Path (Resolve-Path -Path "$projectRoot\*\*.psm1")
$ModuleManifestPath = Resolve-Path -Path "$projectRoot\*\*.psd1"
$moduleName = Split-Path -Path $moduleRoot -Leaf

Describe "Module $ModuleName Manifest Tests" {
    It 'Passes Test-ModuleManifest' {
        Test-ModuleManifest -Path $ModuleManifestPath | Should Not BeNullOrEmpty
        $? | Should Be $true
    }
}

