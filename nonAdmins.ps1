# Set directory for installation - Chocolatey does not lock
# down the directory if not the default
$InstallDir='D:\Tools\Chocolatey'
$env:ChocolateyInstall="$InstallDir"

# If your PowerShell Execution policy is restrictive, you may
# not be able to get around that. Try setting your session to
# Bypass.
Set-ExecutionPolicy Bypass

# All install options - offline, proxy, etc at
# https://chocolatey.org/install
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
# PowerShell 3+?
#iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex

choco install puppet-agent.portable -y
choco install ruby.portable -y
choco install git.commandline -y
choco feature -h
choco feature enable -nallowGlobalConfirmation
cinst GoogleChrome
cinst sublimetext3
choco install sublimetext3.powershellalias
choco install visualstudiocode
choco install powershell-core
cinst javaruntime
cinst java.jdk
cinst notepadplusplus
cinst vim
cinst putty
cinst sysinternals
cinst git
cinst 7zip
cinst 7zip.commandline
cinst nodejs
cinst vlc
cinst ChocolateyGUI
cinst Firefox
cinst PowerShell
cinst python
cinst msysgit
cinst ruby
cinst ruby.devkit
cinst flashplayeractivex
cinst flashplayerplugin
cinst fiddler
cinst ccleaner
cinst filezilla
cinst paint.net
cinst windirstat
cinst autoit.commandline
cinst ScriptCs
cinst Compass
cinst mysql.workbench
cinst Yeoman
cinst Wget
cinst libjpeg-turbo
cinst curl
cinst gitextensions
cinst VirtualCloneDrive
cinst autohotkey_l
cinst PDFCreator
cinst gimp
cinst libreoffice
cinst winmerge
cinst keepass
cinst cyg-get
cinst procexp
cinst wireshark
cinst FoxitReader
cinst beyondcompare
cinst winscp
cinst greenshot
cinst PowerGUI
cinst SourceCodePro
cinst defraggler
cinst k-litecodecpackbasic
cinst nmap
cinst speccy
cinst audacity
cinst googledrive
cinst TeraCopy
cinst picasa
cinst pscx
cinst mono
cinst monodevelop
cinst mp3tag
cinst ffmpeg
cinst Recuva
cinst procmon
cinst f.lux
cinst eclipse-java-juno
cinst PSWindowsUpdate
cinst cpu-z
cinst wincdemu
cinst wincommandpaste
cinst NimbleText
choco install vmware-powercli-psmodule
cinst rktools.2003
choco install rdm
choco install vmwareworkstation
choco install rvtools
cinst windbg
cinst CutePDF
cinst sqliteadmin
# pick an editor
#choco install visualstudiocode.portable -y # not yet available
choco install notepadplusplus.commandline -y
#choco install nano -y
#choco install vim-tux.portable

# What else can I install without admin rights?
# https://chocolatey.org/packages?q=id%3Aportable
