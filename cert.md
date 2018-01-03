Get-ExecutionPolicy
Set-ExecutionPolicy RemoteSigned

# dot-sourcing
.\test-remote.ps1
CanPing

. .\test-remote.ps1
canPing

# signed scripts
Get-AuthenticodeSignature -FilePath $pshome\types.ps1xml
Get-AuthenticodeSignature -FilePath .\test-remote.ps1


# self-signed scripts
help about_Signing

# create local CA
makecert -n "CN=PowerShell Local Certificate Root" -a sha1 `
         -eku 1.3.6.1.5.5.7.3.3 -r -sv root.pvk root.cer `
         -ss Root -sr localMachine
         
# create self-signed cert
makecert -pe -n "CN=PowerShell User" -ss MY -a sha1 `
         -eku 1.3.6.1.5.5.7.3.3 -iv root.pvk -ic root.cer
         
$cert = @(Get-ChildItem cert:\currentUser\My -CodeSigningCert)[0]
Set-AuthenticodeSignature .\test-remote.ps1 $cert

Set-ExecutionPolicy AllSigned

