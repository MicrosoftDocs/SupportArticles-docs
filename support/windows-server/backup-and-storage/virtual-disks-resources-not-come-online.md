---
title: Virtual Disks resources don't come online and in No Redundancy or Detached status in a Storage Spaces Direct cluster
description: Address an issue in which Virtual Disks resources do not come online and are in No Redundancy or Detached status in a Storage Spaces Direct cluster.
ms.date: 12/07/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: 
---
# Virtual Disks resources are in No Redundancy or Detached status in a Storage Spaces Direct cluster

_Original product version:_ &nbsp; Windows Server 2016 Datacenter, Windows Server 2019 Datacenter  
_Original KB number:_ &nbsp; 4294480

## Symptoms

### Issue 1

Assume that the nodes of a Storage Spaces Direct (S2D) system restart unexpectedly because of a crash or power failure. Then, one or more of the virtual disks may not come online, and you see the description "Not enough redundancy information ..."FriendlyName ResiliencySettingName OperationalStatus HealthStatus IsManualAttach Size PSComputerName ------------ --------------------- ----------------- ------------ -------------- ----- -------------- Disk4 Mirror OK Healthy True 10 TB Node-01.conto... Disk3 Mirror OK Healthy True 10 TB Node-01.conto... Disk2 Mirror No Redundancy Unhealthy True 10 TB Node-01.conto... Disk1 Mirror {No Redundancy, InService} Unhealthy True 10 TB Node-01.conto...
 Additionally, after an attempt to bring the virtual disk online, the following information is logged in the Cluster log. (DiskRecoveryAction). 
 [Verbose] 00002904.00001040::YYYY/MM/DD-12:03:44.891 INFO [RES] Physical Disk <DiskName>: OnlineThread: SuGetSpace returned 0. 
 [Verbose] 00002904.00001040:: YYYY/MM/DD -12:03:44.891 WARN [RES] Physical Disk < DiskName>: Underlying virtual disk is in 'no redundancy' state; its volume(s) may fail to mount. 
 [Verbose] 00002904.00001040:: YYYY/MM/DD -12:03:44.891 ERR [RES] Physical Disk <DiskName>: Failing online due to virtual disk in 'no redundancy' state. If you would like to attempt to online the disk anyway, first set this resource's private property 'DiskRecoveryAction' to 1. We will try to bring the disk online for recovery, but even if successful, its volume(s) or CSV may be unavailable. 

### Issue 2 

When you run the **Get-VirtualDisk** cmdlet, the **OperationalStatus** for one or more Storage Spaces Direct virtual disks is **Detached**.  However, the **HealthStatus** reported by the **Get-PhysicalDisk** cmdlet indicates that all the physical disks are in aHealthystate. 
 The following is an example of the output from the **Get-VirtualDisk** cmdlet. FriendlyName ResiliencySettingName OperationalStatus HealthStatus IsManualAttach Size PSComputerName ------------ --------------------- ----------------- ------------ -------------- ----- -------------- Disk4 Mirror OK Healthy True 10 TB Node-01.conto... Disk3 Mirror OK Healthy True 10 TB Node-01.conto... Disk2 Mirror Detached Unknown True 10 TB Node-01.conto... Disk1 Mirror Detached Unknown True 10 TB Node-01.conto...
Additionally, the following events may be logged on the nodes:
Log Name:      Microsoft-Windows-StorageSpaces-Driver/Operational
Source:        Microsoft-Windows-StorageSpaces-Driver
Event ID:      311
Level:         Error
User:          SYSTEM
Computer:      Node#.contoso.local
Description:
Virtual disk {GUID} requires a data integrity scan.                 

Data on the disk is out-of-sync and a data integrity scan is required.                 
To start the scan, run the following command:                 

Get-ScheduledTask -TaskName "Data Integrity Scan for Crash Recovery" | Start-ScheduledTask                 

Once you have resolved the condition listed above,                 
you can online the disk by using the following commands in PowerShell:                 

Get-VirtualDisk | ?{ $_.ObjectId -Match "{GUID}" } | Get-Disk | Set-Disk -IsReadOnly $false                 
Get-VirtualDisk | ?{ $_.ObjectId -Match "{GUID}" } | Get-Disk | Set-Disk -IsOffline  $false

Log Name:      System
Source:        Microsoft-Windows-ReFS
Event ID:      134
Level:         Error
User:          SYSTEM
Computer:     Node#.contoso.local
Description:
The file system was unable to write metadata to the media backing volume <VolumeId>. A write failed with status "A device which does not exist was specified." ReFS will take the volume offline. It may be mounted again automatically.

Log Name:      Microsoft-Windows-ReFS/Operational
Source:        Microsoft-Windows-ReFS
Event ID:      5
Level:         Error
User:          SYSTEM
Computer:      Node#.contoso.local
Description:
ReFS failed to mount the volume.
Context: 0xffffbb89f53f4180
Error: A device which does not exist was specified.

Volume GUID:{00000000-0000-0000-0000-000000000000}
DeviceName:
Volume Name:

## Cause

### For issue 1

The **No Redundancy** **OperationalStatus** can occur if a disk failed or if the system is unable to access data on the virtual disk. This issue can occur if a reboot occurs on a node during maintenance on the nodes.

### For issue 2

The **Detached** **OperationalStatus** can occur if the dirty region tracking (DRT) log is full. Storage Spaces uses dirty region tracking (DRT) for mirrored spaces to make sure that when a power failure occurs, any in-flight updates to metadata are logged to make sure that the storage space can redo or undo operations to bring the storage space back into a flexible and consistent state when power is restored and the system comes back up. If the DRT log is full, the virtual disk can't be brought online until the DRT metadata is synchronized and flushed. This process requires running a full scan, which can take several hours to finish.
 A preventive fix is included in the October 18, 2018, cumulative update for Windows Server 2016 ([KB4462928]()) to reduce the chances of filling the dirty region tracking (DRT) log, reduce the time that is required to run the data integrity scan and add performance counters to monitor progress. If the system is already experiencing this condition, you will need to use the resolution steps to clear the DRT. 
 **Important** If the nodes currently have a Windows Server 2016 cumulative update that was released before the October 18, 2018, cumulative update for Windows Server 2016 (KB4462928) installed, we recommend that you use Storage Maintenance Mode to install the October 18, 2018, cumulative update for Windows Server 2016 (KB4462928) or a later version. This is to make sure all the nodes are updated with the new dirty region tracking improvements at the same time and reduce the risk of experiencing the Detached symptom described in this article because of a full dirty region tracking log.  For more information about invoking Storage Maintenance Mode, see the steps in the Workaround section of [KB4462487]().

## Resolution

### For issue 1

To fix this issue, follow these steps:
1. 
 Remove the affected Virtual Disks from CSV. This will put them in the "Available storage" group in the cluster and start showing as a ResourceType of "Physical Disk." Remove-ClusterSharedVolume -name "VdiskName"
2. 
 On the node that owns the Available Storage group, run the following command on every disk that's in aNo Redundancystate. To identify which node the "Available Storage" group is on you can run the following command. Get-ClusterGroup
3. 
 Set the disk recovery action and then start the disk(s). Get-ClusterResource "VdiskName" | Set-ClusterParameter -Name DiskRecoveryAction -Value 1 Start-ClusterResource -Name "VdiskName"
1. 
 A repair should automatically start. Wait for the repair to finish. It may go into a suspended state and start again. To monitor the progress: 
   - 
 Run **Get-StorageJob** to monitor the status of the repair and to see when it is completed. 
   - 
 Run **Get-VirtualDisk** and verify that the Space returns a HealthStatus ofHealthy. 
2. 
 After the repair finishes and the Virtual Disks areHealthy, change the Virtual Disk parameters back. Get-ClusterResource "VdiskName" | Set-ClusterParameter -Name DiskRecoveryAction -Value 0  

1. 
 Take the disk(s) offline and then online again to have the DiskRecoveryAction take effect: Stop-ClusterResource "VdiskName" Start-ClusterResource "VdiskName"
2. 
 Add the affected Virtual Disks back to CSV. Add-ClusterSharedVolume -name "VdiskName"

### For issue 2

To fix this issue, follow these steps:
1. Remove the affected Virtual Disks from CSV. Remove-ClusterSharedVolume -name "VdiskName"
2. Run the following commands on every disk that's not coming online. Get-ClusterResource -Name "VdiskName" | Set-ClusterParameter DiskRunChkDsk 7 Start-ClusterResource -Name "VdiskName"
3. Run the following command on every node in which the detached volume is online. Get-ScheduledTask -TaskName "Data Integrity Scan for Crash Recovery" | Start-ScheduledTask This task should be initiated on all nodes on which the detached volume is online. A repair should automatically start. Wait for the repair to finish. It may go into a suspended state and start again. To monitor the progress: 
   - Run **Get-StorageJob** to monitor the status of the repair and to see when it is completed. 
   - Run **Get-VirtualDisk** and verify the Space returns a HealthStatus ofHealthy. 
   - The "Data Integrity Scan for Crash Recovery" is a task that doesn't show as a storage job, and there is no progress indicator. If the task is showing asrunning, it is running. When it completes, it will showcompleted.  Additionally, you can view the status of a running schedule task by using the following cmdlet: Get-ScheduledTask | ? State -eq running 
4. As soon as the " Data Integrity Scan for Crash Recovery" is finished, the repair finishes and the Virtual Disks areHealthy, change the Virtual Disk parameters back. Get-ClusterResource -Name "VdiskName" | Set-ClusterParameter DiskRunChkDsk 0
5. Add the affected Virtual Disks back to CSV. Add-ClusterSharedVolume -name "VdiskName"

## More information

**DiskRecoveryAction** is an override switch that enables attaching the Space volume inread-writemode without any checks. The property enables you to do diagnostics into why a volume won't come online. It is very similar to Maintenance Mode but can be invoked on a resource that is in aFailedstate. It also allows you to access the data, which can be helpful in situations such as " No Redundancy," where you can get access to whatever data you can and copy it. The **DiskRecoveryAction** property was added in the [February 22, 2018, update, KB 4077525](https://support.microsoft.com/help/4077525). 
 **DiskRunChkdsk** value 7 is used to attach the Space volume and have the partition inread-onlymode. This enables Spaces to self-discover and self-heal by triggering a repair. Repair will run automatically once mounted. It also allows you to access the data, which can be helpful to get access to whatever data you can to copy. For some fault conditions, such as a full DRT log, you need to run the **Data Integrity Scan for Crash Recovery** scheduled task. 
 **Data Integrity Scan for Crash Recovery** task is used to synchronize and clear a full dirty region tracking ( DRT) log. This task can take several hours to complete. The "Data Integrity Scan for Crash Recovery" is a task that doesn't show as a storage job, and there is no progress indicator. If the task is showing asrunning, it is running. When it completes, it will show as completed. If you cancel the task or restart a node while this task is running, the task will need to start over from the beginning. 
For more information, see [Storage Spaces Direct Health and operational states](https://docs.microsoft.com/windows-server/storage/storage-spaces/storage-spaces-states).
