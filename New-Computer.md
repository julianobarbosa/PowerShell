# IP configuration
Get-NetAdapter

# New IP Setting
New-NetIPAddress -InterfaceIndex 2 -IPAddress 192.168.1.101 -PrefixLength 24 -DefaultGateway 192.168.1.1

# Set DNS 
Set-DnsClientServerAddress -InterfaceIndex 2 -ServerAddress ('8.8.8.8', '8.8.4.4')

# Get firewall
Get-NetFirewallProfile

# Set firewall all profile on
Set-NetFirewallProfile -Profile domain,public,privete -Enabled True

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


# OBS
sconfig
