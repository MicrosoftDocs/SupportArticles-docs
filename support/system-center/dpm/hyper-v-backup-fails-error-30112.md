---
title: Hyper-V backup fails with error 30112
description: Fixes an issue where you can't initiate a Hyper-V backup using a child partition for a guest and receive error 30112.
ms.date: 07/27/2020
ms.reviewer: mjacquet
---
# A DPM 2010 initiated Hyper-V backup using a child partition for a guest fails with error 30112

This article helps you fix an issue where you can't initiate a Hyper-V backup using a child partition for a guest in System Center Data Protection Manager 2010 and receive error 30112.

_Original product version:_ &nbsp; System Center Data Protection Manager 2010  
_Original KB number:_ &nbsp; 2462424

## Symptoms

When System Center Data Protection Manager 2010 (DPM) initiates a Hyper-V backup using a child partition for a guest, the DPM backup job fails with the following details and alert:

> Type: Recovery point  
Status: Failed  
Description: DPM encountered a retryable VSS error. (ID 30112 Details: VssError:The writer experienced a transient error. If the backup process is retried, the error may not reoccur.  (0x800423F3))  
More information  
End time:  
Start time:  
Time elapsed:  
Data transferred: 0 MB  
Cluster node Hyper-V-Node.contoso.com  
Recovery Point Type Express Full  
Source details: \Backup Using Child Partition Snapshot\My-Guest  
Protection group: VMs on CSV
>
> Affected area: \Backup Using Child Partition Snapshot\My-Guest  
Occurred since:  
Description: Recovery point creation jobs for Microsoft Hyper-V \Backup Using Child Partition Snapshot\My-Guest on My-Guest.Hyper-V-Node.contoso.com
have been failing. The number of failed recovery point creation jobs = 1.  
If the datasource protected is SharePoint, then click on the Error Details to view the list of databases for which recovery point creation failed. (ID 3114)  
DPM encountered a retryable VSS error. (ID 30112 Details: VssError:The writer experienced a transient error. If the backup process is retried, the error may not reoccur. (0x800423F3))  
More information  
Recommended action: Check the Application Event Log on Hyper-V-Node.contoso.com for the cause of the failure. Fix the cause and retry the operation.  
For more information on this error, go to [http://go.microsoft.com/fwlink/?LinkId=132612](https://go.microsoft.com/fwlink/?LinkId=132612).  
Create a recovery point...  
Resolution: To dismiss the alert, click below  
Inactivate alert
>
The only event found on the Hyper-V host may be the following:

> Log name:  Microsoft-Windows-Hyper-V-VMMS/Admin  
Source:  Hyper-V-VMMS  
Event ID: 10111  
Level: Error  
Description:  failed to mount the virtual hard drive '\\\\?\Volume{guid}\vm_name\vm_name.vhd' for virtual machine 'vm_name' (Virtual machine ID GUID).

You may also receive the following events when using the Microsoft iSCSI hardware provider:

> Log Name:   Application  
Source: VSS  
Date:  
Event ID: 12289  
Task Category: None  
Level: Error  
Keywords: Classic  
User: N/A  
Computer: Hyper-V-Node.contoso.com  
Description:  
Volume Shadow Copy Service error: Unexpected error DeviceIoControl(\\\\?\fdc#generic_floppy_drive#5&e581bb8&0&0#{53f5630d-b6bf-11d0-94f2-00a0c91efb8b} - 0000000000000318,0x00560000,0000000000000000,0,0000000000306370,4096,[0]).  hr = 0x80070001, Incorrect function.  
>
> Operation:  
Exposing Recovered Volumes  
Locating shadow-copy LUNs  
PostSnapshot Event  
Executing Asynchronous Operation
>
> Context:  
Device: \\\\?\fdc#generic_floppy_drive#5&e581bb8&0&0#{53f5630d-b6bf-11d0-94f2-00a0c91efb8b}  
Examining Detected Volume: Existing - \\\\?\fdc#generic_floppy_drive#5&e581bb8&0&0#{53f5630d-b6bf-11d0-94f2-00a0c91efb8b}  
Execution Context: Provider  
Provider Name: Microsoft iSCSI Target VSS Hardware Provider  
Provider Version: 3.3.16544  
Provider ID: {2f900f90-00e9-440e-873a-96ca5eb079e5}  
Current State: DoSnapshotSet

## Cause

This can occur if you have a VSS hardware provider installed that doesn't support autorecovery [VSS_VOLSNAP_ATTR_AUTORECOVERY]. This causes all Hyper-V host online backups to fail.

Autorecovery is defined as:

- In the virtual machine, a volume snapshot is taken.
- In the host, take a snapshot of the volume hosting the virtual machine (VM) vhd.
- In the autorecovery phase, VSS fixes up the vhd on the host volume snapshot to a consistent state.

One such provider that doesn't support Auto-Recovery is the **Microsoft iSCSI Target VSS Hardware Provider** as seen below.

*DISKSHADOW> list providers*  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \* *ProviderID: {2f900f90-00e9-440e-873a-96ca5eb079e5}*  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Type: [3] VSS_PROV_HARDWARE*  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Name: Microsoft iSCSI Target VSS Hardware Provider*  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Version: 3.3.16544*  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *CLSID: {363948d2-035d-4d1d-9bfc-473fece07dab}*  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; \* *ProviderID: {b5946137-7b9f-4925-af80-51abd60b20d5}*  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Type: [1] VSS_PROV_SYSTEM*  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Name: Microsoft Software Shadow Copy provider 1.0*  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Version: 1.0.0.7*  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *CLSID: {65ee1dba-8ff4-4a58-ac1c-3470ee2f376a}*  

To confirm which VSS provider is used when a snapshot is taken, look for the following line in the DPMRACurr.errlog file on the protected server and match up the **ProviderID:[guid]** with **vssadmin list providers** output or diskshadow list providers output. The below confirms we're using the **Microsoft iSCSI Target VSS Hardware Provider**:

> 0990 17D8 11/05 13:02:42.416 31 vsssnapshotrequestor.cpp(585) [00000000003970D0] NORMAL CVssSnapshotRequestor:: ProviderId:[{2F900F90-00E9-440E-873A-96CA5EB079E5}], h/w provider:[65536], volume:[\\\\?\Volume{de393808-58d8-11df-be86-00155d4e0e00}\\]

## Resolution

Since the VSS hardware provider doesn't support auto-recovery, you need to choose one of the options below, then perform the appropriate steps under that option in order to get good Hyper-V guest backups:

### Option 1

Continue to use the VSS hardware provider but take saved state backups. This will allow DPM to continue to take up to three simultaneous guest backups per node, however the VMs will need to be backed up in a saved state so autorecovery is not used.

1. In the **Settings** of every guest under **Integration Services**, uncheck the option **Backup (volume snapshot)**.
2. Configure the DPM protection group to perform the host level backups of the guests after normal production hours so users will not be impacted when the guest goes into a saved state when a backup is initiated.

### Option 2

Configure each node to use the built-in System VSS Provider, then enable Hyper-V serialization. This will take longer to back up the guests since only one guest can be backed up at a time per node or per CSV.

1. On every node in the Hyper-V cluster, open `regedit` and add the key below. This will tell the DPM agent to use System Software Provider:

   `HKEY_LOCAL_MACHINE\Software\Microsoft\Microsoft Data Protection Manager\Agent\UseSystemSoftwareProvider`

2. Enable Hyper-V serialization according to [Considerations for Backing Up Virtual Machines on CSV with the System VSS Provider](/previous-versions/system-center/data-protection-manager-2010/ff634192(v=technet.10)?redirectedfrom=MSDN).

## More information

[Microsoft iSCSI Software Target 3.3: Support Policies on Windows Server 2008 R2](/previous-versions/windows/it-pro/windows-server-storage-solutions/gg983493(v=ws.10)?redirectedfrom=MSDN)

> [!NOTE]
> Hyper-V host backup (using auto recovery) isn't supported in this release. For application-consistent backup, you can invoke the backup within the VM guest machine.
