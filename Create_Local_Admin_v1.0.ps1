<#
    ################

    What does this do?: 
                   This script creates a local administrator account on all servers and clients running Windows operating systems.
                   - The text file "..\Create_Admin_List_$date.txt" is created which contains all Windows computer accounts from the domain.
                   - The text file  "..\Create_Admin_NoResponse_$date.txt" is created when computer accounts do not respond to a ping query.

                   
    Prerequisites: 
                   - Script must be run on an account with Domain Administrative rights on a Domain Controller, a member server, or workstation with the RSAT tools installed.
                   - Script must be run in an elevated PowerShell instance.
                   - Windows Remote Management service (WinRM) has to be set to “Automatic” on all computers to allow the script to run.
                   - PowerShell Version 4.0 (at least) must be used.
                   - "Set-ExecutionPolicy remotesigned" must be enabled.

    How to use the script:
                   Simply run the script from an elevated PowerShell instance.
                   Ex: .\Create_Local_Admin_v1.0.ps1
   
    Created by: John Armstrong
    Version: 1.0
    Date: 04/30/2018

    ################

    Changelog:

        Version: 1.0 
        Date: 04/30/2018
            - Initial Release.

    ################
#>
#
# Local group the user will be added to.
$group = "Administrators"
# Version
$version = "1.0"
# Date
$date=Get-Date -Format "MM-dd-yyyy_hh-mm-ss"
# Location of where the password file is created.
$pwfile = $filepath+"\ChangePass_Pwd_$date.txt"
# Function for title.
function title {
    Write-Host "`n--- Create Local Admin v$version ---`n"
    Start-Sleep 2
}
# Function to create administrator account.
function createlocaladmin {
    $computerlist = $filepath+"\Create_Admin_List_$date.txt"
    $global:noresponse = $filepath+"\Create_Admin_NoResponse_$date.txt"
    Get-ADComputer -Filter {OperatingSystem -like "Windows*"} -Properties Name | Select-Object -ExpandProperty Name > $computerlist
    $computers = Get-Content -Path $computerlist
    #
    ForEach ($computer in $computers) {
        if (Test-Connection $computer -Count 1 -Quiet){
            Write-Host "`n$computer" -BackgroundColor black -ForegroundColor Magenta
            Write-Host "Attempting to create user account '$username'..."    
            Start-Sleep 1
            Invoke-Command -ComputerName $computer -ScriptBlock {Net User $args[0] $args[1] /add /y /expires:never} -ArgumentList $username,$passwd
            Write-Host "Attempting to add '$username' to the local Administrators group..."
            Start-Sleep 1
            Invoke-Command -ComputerName $computer -ScriptBlock {Net localgroup $args[0] $args[1] /add} -ArgumentList $group,$username
            } else {
            "Computer $computer is not responding. " >> $noresponse
            }
        }
    }
# Function to set username.
function setuser {
$global:username = Read-Host -Prompt "Enter the administrator account name to create"
Start-Sleep 2
#Call setpasswd function.
setpasswd
            }
# Function for filepathexist.
function filepathexist {
    #$global:logdriveexist = Test-Path $logdrive
    Write-Host "Verifying the drive letter or path exists...`n"
    Start-Sleep 2
    if (Test-Path $filepath){
        Start-Sleep 1
        Write-Host "Drive letter or path does exists...`n"
        Start-Sleep 2
        Write-Host "Starting 'setuser' function...`n" -BackgroundColor black -ForegroundColor green
        Start-Sleep 2
                # Call setuser function
                setuser
        } else {
        Write-Warning "The drive letter or folder path entered does not exist.`n`nVerify the driver letter or folder path exists and try again.`n"
        Start-Sleep 3
        Clear-Host
        # Call title function.
        title
        # Call filepath function.
        filepath
        }
    }  
# Function for filepath
function filepath {
    $global:filepath = Read-Host "`nEnter the drive letter or path that will house the 'Create_Local_Admin' files `n(Ex. C:, C:\Create_Local_Admin)"
    Write-Host ""
    # Call filepathexit function.
    filepathexist
}
# Function to verify password.
function verify {
    if ($passwd -ne $passwdcf){
        Start-Sleep 2
        Write-Host ""
        Write-Warning "`nThe passwords do not match. Please try again."
        Start-Sleep 2
        # Call setpasswd function.
        setpasswd
        } 
        # Call createlocaladmin function.
        Write-Host "`nThe passwords match. Starting 'createlocaladmin' function." -BackgroundColor black -ForegroundColor green
        Start-Sleep 2
        createlocaladmin
    }
        # Function to set password.
        function setpasswd {
        $global:passwd = Read-Host -AsSecureString "`nEnter the new password for '$username'"
        $global:passwd = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($global:passwd))
        Write-Host ""
        $global:passwdcf = Read-Host -AsSecureString "Enter the new password again to confirm"
        $global:passwdcf = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($passwdcf))
        #
        Start-Sleep 1
        Write-Host "`nVerifying the passwords match..."
        # Call verify function.
        Start-Sleep 2
        verify
        }
        Clear-Host
        # Requirements
        #requires -version 4.0
        #requires -runasadministrator
        #
        # Call title function.
        title
        #
        # Call filepath function.
        filepath
        #
Start-Sleep 2
        #
        if (Test-Path $noresponse)
        {
            Write-Warning "Not all Windows computers responded. `n`nThis could be due to the Windows Remote Management Service (WinR) being disabled or the computer is turned off.`n`nReview the $noresponse file for the list of computers that did not respond.`n"
            Start-Sleep 5
        }
        #
        Write-Host "`nScript finished."
        Read-Host "`nPress ENTER to exit the script"
        # Close PowerShell Instance
        Stop-Process -Id $PID
        exit