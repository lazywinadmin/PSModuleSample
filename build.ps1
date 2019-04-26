# Install Pester
Install-Module -Name Pester

# Run test build
Invoke-Pester -Path ".\Tests" -OutputFormat NUnitXml -OutputFile Test-Results.xml -PassThru