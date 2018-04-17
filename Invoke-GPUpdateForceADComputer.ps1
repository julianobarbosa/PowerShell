#Run from DC in domain as admin.
function Invoke-GPUpdateForceAdComputer {
    <#
    .SYNOPSIS
    Retrieves key system version and model information
    from one to ten computers.
    .DESCRIPTION
    Invoke-GPUpdateForceADComputer uses Windows Management Instrumentation
    (WMI) to retrieve information from one or more computers.
    Specify computers by name or by IP address.
    .PARAMETER ComputerName
    One or more computer names or IP addresses, up to a maximum
    of 10.
    .PARAMETER LogErrors
    Specify this switch to create a text log file of computers
    that could not be queried.
    .PARAMETER ErrorLog
    When used with -LogErrors, specifies the file path and name
    to which failed computer names will be written. Defaults to
    C:\Retry.txt.
    .EXAMPLE
     Get-Content names.txt | Invoke-GPUpdateForceADComputer
    .EXAMPLE
     Invoke-GPUpdateForceADComputer -ComputerName SERVER1,SERVER2
    #>
        [CmdletBinding()]
        param(
            [Parameter(Mandatory=$True,
                       ValueFromPipeline=$True,
                       HelpMessage="Computer name or IP address")]
            [ValidateCount(1,10)]
            [Alias('hostname')]
            [string[]]$ComputerName,

            [string]$ErrorLog = 'c:\retry.txt',

            [switch]$LogErrors
        )
        BEGIN {
            Write-Verbose "Error log will be $ErrorLog"
        }
        PROCESS {
            $DomainName = (Get-WMIObject Win32_NTDomain | Select-Object -ExpandProperty DNsForestName | Select-Object -first 1).trim()
            $DNsplit0 = $domainname.split(".")[0]
            $DNsplit1 = $domainname.split(".")[1]
            $searchdomain = "dc=" + $DNsplit0 + ",dc=" + $DNsplit1

            Import-module ActiveDirectory

            $objCounter = 0
            $adcomputers = Get-ADComputer -Filter * -SearchBase "$searchdomain" | foreach-object {$_.name}
            $adcomputers = $adcomputers | Sort-Object
            ($adcomputers).Count 

            foreach ($obj in $adcomputers) {
                if(Test-Connection -ComputerName $obj -Count 1 -ea 0) {
                    try {
                        $objCounter += 1
                        Write-Progress -Activity 'Forcing gpupdate on $($obj)' -Status 'Computer: $($obj)' -PercentComplete (($objCounter/$adcomputers.Count) * 100)
                        Invoke-Command -ComputerName $obj -ScriptBlock { hostname } -ErrorAction Stop  | Out-Null
                        Write-Host "$obj - online and available for remote management." -ForegroundColor Green
                        try {
                            Invoke-Command -ComputerName $obj -ScriptBlock { gpupdate /scope computer /force } -ErrorAction Stop  | Out-Null
                            Write-Host "$obj - gpupdate /scope computer /force executed" -ForegroundColor Green
                        }
                        catch {
                            Write-Warning "$obj - unable to execute gpupdate"
                        }
                    }
                    catch {
                        write-warning "$obj - online but not accessible for remote commands - possible gpo hasn't applied."
                        continue
                    }
                }
                else {
                    write-warning "$obj - unable to connect - please verify it is on."
                    continue
                }
            }
        }
        END {
        }
    }

Invoke-GPUpdateForceAdComputer -ComputerName locallhost -Verbose
