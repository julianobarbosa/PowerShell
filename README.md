# Powershell Repository

## Keyboard Shortcuts
https://docs.microsoft.com/en-us/powershell/scripting/core-powershell/ise/keyboard-shortcuts-for-the-windows-powershell-ise?view=powershell-5.1
## Get Powershell Version
```console
Invoke-Command -ComputerName (Get-ADCompouter -filter * | Select-Object -expand Name) -ScriptBlock {$PSVersionTable.PSVersion}
```
