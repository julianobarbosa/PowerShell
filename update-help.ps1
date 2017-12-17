# updating help from the internet
Get-Help Update-Help -Examples

# saving & updating help locally
Save-Help -DestinationPath \\fsnugget\psv4\help
Update-Help -SourcePath \\fsnugget\psv4\help

# searching help
Get-Help *variable*
Get-Help about_automatic_variables | more #doesn't work in ISE !

# getting help
help Get-Service -Detailed #params & examples
help Get-Service -Exemples #examples
help Get-Service -Full #full help: params, examples, notes, input/output types
help Get_service -Parameter d*

# using help
help Start-Service -Online
help Start-Service -ShowWindow

Get-Service bi* -ComputerName DCNUGGET, FSNUGGET
Get-Service bi* -ComputerName DCNUGGET, FSNUGGET | Start-Service #input object paramenter set
Start-Service -DisplayName 'Background Inelligent Transfer Service' -c DCNUGGET, FSNUGGET #displayname parameter set
Start-Service bi* -ComputerName DCNUGGET, FSNUGGET #default parameter set
