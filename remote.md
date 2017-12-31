# enable remoting (winrm)
Help Enable-PSRemoting

Enable-PSRemoting
Disable-PSRemoting

Get-PSSessionConfiguration

# interactive 1:1 remoting
Enter-PSSession FS
dir
Exit-PSSession

# 1:many remoting
Help Invoke-Command

Invoke-Command -ScriptBlock {Get-WindowsFeature web-server} -ComputerName APPFLEXSOL, FSFLEXSOL
Invoke-Command -FilePath \\fsflexsol\ps\scripts\create-logdir.ps1 -ComputerName APPFLEXSOL, FSFLEXSOL

Invoke-Command -ScriptBlock {$w = Get-Service win*} -ComputerName APPFLEXSOL, FSFLEXSOL
Invoke-Command -ScriptBlock {$w.count} -ComputerName APPFLEXSOL, FSFLEXSOL

# persisten session
$dc = New-PSSession DCFLEXSOL
Get-PSSession
Enter-PSSession -Session $dc
$logs = Get-EventLog -LogName System -Newest 10
