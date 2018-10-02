# Cluster
## iSCSI Initiators (pre-target) 

# start iscsi inititator service on both nodes
Invoke-Command CL1-NUG, CL2-NUG { Get-Service *iscsi* | Set-Service -StartupType AUtomatic -PassThru | Start-Service }

# View iscsi initiator addresses
Invoke-Command CL1-NUG, CL2-NUG { Get-InitiatorPort }

# Create iscsi target portal for discovery
Invoke-Command CL1-NUG, CL2-NUG { New-IscsiTargetPortal -TargetPortalAddress 192.168.3.105 }


## iSCSI Target

# create iscsi lun
Invoke-Command FS-NUG { New-IscsiVirtualDisk -Path D:\CL-DataDisk.vhdx -SizeByte 100GB }
Invoke-Command FS-NUG { New-IscsiVirtualDisk -Path D:\CL-QuorumDisk.vhdx -SizeByte 1GB }

# carete iscsi target
Invoke-Command FS-NUG { New-IscsiServer Target -TargetName CL-Target -InitiatorId 'iid' }

# assign luns to target
Invoke-Command FS-NUG { Add-IscsiVirtualDiskTargetMapping -TargetName CL-Target -Path D:\CL-DataDisk.vhdx }
Invoke-Command FS-NUG { Add-IscsiVirtualDiskTargetMapping -TargetName CL-Target -Path D:\CL-Quorum.vhdx }


## iSCSI Initiators (post-target)

# update discovery portal with new target information
Invoke-Command CL1-NUG, CL2-NUG { Get-IscsiTargetPortal | Update-IscsiTargetPortal }

# view iscsi target
Invoke_command CL1-NUG, CL2-NUG { Get-IscsiTarget }

# connect initiators to target
Invoke-COmmand CL1-NUG, CL2-NUG { Get-IscsiTarget | Connect-IscsiTarget }

# connect initiators to target
Invoke-Command CL1-NUG, CL2-NUG { Get-IscsiSession | Register-IscsiSession }


## Failover Clustering
# install failover clustering feature on both nodes
Invoke-Command CL1-NUG, CL2-NUG { Install-WindowsFeature Failover-Clustering }

# run cluster validation
Test-Cluster -Node CL1-NUG, CL2-NUG

# create a new cluster (single domain)
New-Cluster -Name CL-NUG -Node CL1-NUG, CL2-NUG -StaticAddress 192.168.1.150

# create a new cluster (multi-domain/workgroup - no network name)
New-Cluster -Name CL-NUG -Node CL1-NUG, CL2-NUG -StaticAddress 192.168.1.150 -AdmistrativeAccessPoint Dns


# Reference
https://docs.microsoft.com/en-us/windows-server/failover-clustering/failover-clustering-overview

