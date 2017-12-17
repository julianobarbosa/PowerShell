# Powershell Repository

## Get Powershell Version
Invoke-Command -ComputerName (Get-ADCompouter -filter * | Select-Object -expand Name) -ScriptBlock {$PSVersionTable.PSVersion}
