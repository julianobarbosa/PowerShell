# Configure new Computer

Get-WindowsFeature | Where-Object Installed -eq True

# configure remote management for IIS
Set-ItemProperty -Path 'HKLM:\Software\Microsoft\WebManagement\Server' -Name 'EnableRemoteManagement' -Value 1

# rename a computer
Rename-Computer -NewName WEB-NUB -DomainCredential 'domain\username' -Force -Restart

# exit remote powershell session
Exit-PSSession

# send a command over to a remote machine (powershell remoting - http)
Invoke-Command -ComputerName WEB-NUG -ScriptBlock { Get-Service W3SVC, WMSVC }

# use the built in computername parameter (windows - dcom)
Get-Service -ComputerName WEB-NUG
