$file = get-item "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\ServerManager\ServerList.xml"

# Backup current file
copy-item –path $file –destination $file-backup –force

$xml = [xml] (Get-Content $file)

$Servers = @("server1", "server2") 
foreach ($server in $Servers) {
    $newserver = @($xml.ServerList.ServerInfo)[0].clone()
    $newserver.name = $server
    $newserver.lastUpdateTime = "0001-01-01T00:00:00"
    $newserver.status = "2"
    $xml.ServerList.AppendChild($newserver)
}
$xml.Save($file.FullName)
start-process –filepath $env:SystemRoot\System32\ServerManager.exe –WindowStyle Maximized
