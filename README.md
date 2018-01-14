# Powershell Repository

## Keyboard Shortcuts
https://docs.microsoft.com/en-us/powershell/scripting/core-powershell/ise/keyboard-shortcuts-for-the-windows-powershell-ise?view=powershell-5.1


## Get Powershell Version
```console
Invoke-Command -ComputerName (Get-ADCompouter -filter * | Select-Object -expand Name) -ScriptBlock {$PSVersionTable.PSVersion}
```

## Get-Command
```console
Get-Command -CommandType Alias

Get-Command *service* -CommandType cmdlet -Module ActiveDirectory

Get-Command -verb get -noun service

Get-Command -ParameterName computername
```

## Foreach-Object
```console
dir c:\*.exe -Recurse | where {$_.cREATIONtIME.yEAR -EQ (Get_Date).Year} | 
  % -Begin {Get-Date} `
    -Process {Out-File exec-log.txt -Append -InputObject $_.FullName} `
    -End {Get-Date}
```

# posh
https://gist.github.com/jchandra74/5b0c94385175c7a8d1cb39bc5157365e
