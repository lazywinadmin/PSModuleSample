Try {
    # Install Pester
    Write-Host "Installing Pester..." -ForegroundColor Cyan
    Install-Module -Name Pester

    # Run test build
    Write-Host "Running Tests..." -ForegroundColor Cyan
    $res = Invoke-Pester -Path ".\Tests" -OutputFormat NUnitXml -OutputFile TestsResults.xml -PassThru
    Write-Host "Publish tests..." -ForegroundColor Cyan
    (New-Object 'System.Net.WebClient').UploadFile("https://ci.appveyor.com/api/testresults/nunit/$($env:APPVEYOR_JOB_ID)", (Resolve-Path .\TestsResults.xml))
    if ($res.FailedCount -gt 0) { throw "$($res.FailedCount) tests failed."}



    # Publish to Gallery
    if ($APPVEYOR_REPO_COMMIT_MESSAGE -match '!release'){
        $Splatting = @{
            Path        = '.\PSModuleSample'
            NuGetApiKey = $env:NuGetApiKey
            ErrorAction = 'Stop'
        }
        Write-Host "Publishing to the PowerShell Gallery." -ForegroundColor Cyan
        Publish-Module @Splatting
    }
}
Catch
{
    throw $_
}