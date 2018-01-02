<#
.SYNOPSIS
Tests a machines connectivity and remoting
.DESCRIPTION
Tests a machines connectivity using ping and remoting capabilities using PSSession
.PARAMETER ComputerName
Name of the computer you want to run the command against
.EXAMPLE
Test-Remote - ComputerName DCFLEXSOL
.EXAMPLE
Test-Remote
#>

# parameters
param ($ComputerName = "localhost")

# test connectivity via ping, returns true/false
function CanPing {
    $response = Test-Connection $ComputerName -Quiet -ErrorAction SilentlyContinue
    
    if (!$response) {
        Write-Host "Ping failed: $ComputerName."; return $false
    }
    else {
        Write-Host "Ping succeeded: $ComputerName"; return $true
    }
 
}

# test remoting via sessions
function CanRemote {
    $session = New-PSSession $ComputerName -ErrorAction SilentlyContinue
}
