# Implement your module commands in this script.
function Get-Message
{
PARAM($Name='World')
Write-Output -InputObject "Hello $Name!"
}

# Export only the functions using PowerShell standard verb-noun naming.
# Be sure to list each exported functions in the FunctionsToExport field of the module manifest file.
# This improves performance of command discovery in PowerShell.
Export-ModuleMember -Function *-*
