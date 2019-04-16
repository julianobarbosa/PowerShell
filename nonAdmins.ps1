# URL: https://blog.ipswitch.com/implementing-chocolatey-self-service-for-non-admin-users-1
# Set directory for installation - Chocolatey does not lock
# down the directory if not the default
$env:ChocolateyBinRoot="D:\tools"
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
cinst GoogleChrome -y
cinst sublimetext3 -y
choco install sublimetext3.powershellalias -y
choco install visualstudiocode -y
choco install visualCppBuildTools -y
choco install powershell-core -y
choco install neovim -y
cinst javaruntime -y
cinst java.jdk -y
cinst notepadplusplus -y
cinst putty -y
cinst sysinternals -y
cinst git -y
cinst 7zip -y
cinst 7zip.commandline -y
cinst nodejs -y
cinst vlc -y
cinst ChocolateyGUI -y
cinst Firefox -y
cinst PowerShell -y
cinst flashplayeractivex -y
cinst flashplayerplugin -y
cinst fiddler -y
cinst ccleaner -y
cinst filezilla -y
cinst paint.net -y
cinst windirstat -y
cinst autoit.commandline -y
cinst ScriptCs -y
cinst Compass -y
cinst mysql.workbench -y
cinst Yeoman -y
cinst Wget -y
cinst libjpeg-turbo -y
cinst curl -y
cinst gitextensions -y
cinst VirtualCloneDrive -y
cinst autohotkey_l -y
cinst PDFCreator -y
cinst gimp -y
cinst libreoffice -y
cinst winmerge -y
cinst wireshark -y
cinst FoxitReader -y
cinst beyondcompare -y
cinst winscp -y
cinst greenshot -y
cinst PowerGUI -y
cinst SourceCodePro -y
cinst defraggler -y
cinst k-litecodecpackbasic -y
cinst nmap -y
cinst speccy -y
cinst audacity -y
cinst googledrive -y
cinst TeraCopy -y
cinst picasa -y
cinst pscx -y
cinst mp3tag -y
cinst ffmpeg -y
cinst Recuva -y
cinst procmon -y
cinst f.lux -y
cinst PSWindowsUpdate -y
cinst cpu-z -y
cinst wincdemu -y
cinst wincommandpaste -y
cinst NimbleText -y
choco install vmware-powercli-psmodule -y
cinst rktools.2003 -y
choco install rdm -y
choco install vmwareworkstation -y
choco install rvtools -y
choco install rufus -y
choco install rapidee -y
choco install gitkraken -y
choco install teamviewer -y
choco install firacode -y
choco install xming -y
choco install ctags -y
choco install dropbox -y
choco install everything -y
choco install linkshellextension -y
choco install Ditto.install -y
choco install ag -y
cinst windbg -y
cinst CutePDF -y
cinst sqliteadmin -y
# pick an editor 
#choco install visualstudiocode.portable -y # not yet available
choco install notepadplusplus.commandline -y
#choco install nano -y
#choco install vim-tux.portable

# What else can I install without admin rights?
# https://chocolatey.org/packages?q=id%3Aportable
