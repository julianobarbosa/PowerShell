$EventIdGPUpdate = @(1050, 1051, 1052, 1053, 1054, 1055, 1097, 1500, 1501, 1502, 1503)

$yesterday = (Get-Date).AddHours(-24)
#$ErrWarn4App = Get-WinEvent -FilterHashTable @{LogName='Application','System'; Level=2,3; StartTime=$yesterday} -ErrorAction SilentlyContinue | Select-Object TimeCreated,LogName,ProviderName,Id,LevelDisplayName,Message

# GPUdate
$ErrWarn4App = Get-WinEvent -FilterHashTable @{LogName='System'; ID=$EventIdGPUpdate; StartTime=$yesterday} -ErrorAction SilentlyContinue | Select-Object TimeCreated,LogName,ProviderName,Id,LevelDisplayName,Message
$ErrWarn4App | Sort-Object TimeCreated | Format-Table -AutoSize


Get-EventLog -LogName System -After $yesterday -Before (Get-Date) | Where-Object {$_.EntryType -like 'Error' -or $_.EntryType -like 'Warning'} | Sort-Object Source


Install-Module -Name xRemoteDesktopAdmin -Scope CurrentUser
