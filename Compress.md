# Backing Up All Scripts to ZIP
```console
Get-ChildItem -Path $Home -Filter *.ps1 -Recurse -ErrorAction SilentlyContinue | Compress-Archive -DestinationPath "$Home\desktop\backupAllScripts.zip" -CompressionLevel Optimal
```
