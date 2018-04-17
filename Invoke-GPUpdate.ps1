<#
.SYNOPSIS
This is a simple PowerShell script to execute gpuptade /target:computer on another computer

.PARAMETER Computer
Computer on which the command should run

.EXAMPLE
.\Invoke-GPUpdate.ps1 -Computer Computer01

.EXAMPLE
"Computer01","Computer02" | .\Invoke-GPUpdate.ps1

.EXAMPLE
Computerlist.txt | .\Invoke-GPUpdate.ps1

.INPUTS
This script accepts pipeline input

.OUTPUTS
This script does not generate an object as output

.NOTES
https://github.com/julianobarbosa
#>

[CmdletBinding()]
PARAM
(
    [Parameter(ValueFromPipeline=$True)]
    [ValidateNotNullOrEmpty()]
    [string]$Computer = $env:COMPUTERNAME
)

Begin{}

Process{
    If (Test-Connection -ComputerName $Computer -Count 1 -Quiet)
    {
        Write-Output "Processing $Computer"
        Invoke-WmiMethod -class Win32_process -name Create -ArgumentList "cmd.exe /c gpupdate /target:computer" -ComputerName $Computer | out-null
    }
}

End{}
