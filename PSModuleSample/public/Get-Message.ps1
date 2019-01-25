function Get-Message
{
PARAM($Name='World')
Write-Output -InputObject "Hello $Name!"
}