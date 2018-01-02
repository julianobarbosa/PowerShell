# WorkFlow

WorkFlow Copy-Files {
    Param (
        [String]$Source,
        [String]$Destination
    )
  
    $files = Get-ChildITem $Source
  
    Foreach -parallel ($file in $files) { #parallel
        Copy-Item -Path $file.FullName -Destination $Destination
        Write-Output "$file copied."
  }
  
  Write-Output "Copy-Files complete!"
}

New-Item C:\installs -ItemType Directory
Copy-Files \\fsflexsol\ps\installs c:\installs
