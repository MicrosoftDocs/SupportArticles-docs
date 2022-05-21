---
title: A host level backup fails with error 0x8007173D
description: Fixes an issue where a host level backup fails with error 0x8007173D in System Center Data Protection Manager 2010.
ms.date: 07/27/2020
ms.reviewer: mjacquet, michvar
---
# A host level backup fails with error 0x8007173D in System Center Data Protection Manager 2010

This article helps you fix an issue where a host level backup of guests fails with error 0x8007173D in System Center Data Protection Manager 2010.

_Original product version:_ &nbsp; System Center Data Protection Manager 2010  
_Original KB number:_ &nbsp; 2549533

## Symptoms

When using System Center Data Protection Manager (DPM) 2010 to perform a host level backup of guests located on a CSV in Windows Server 2008 Hyper-V cluster, some recovery point jobs fail intermittently with one or more of the following errors:

> Type:&nbsp;&nbsp;&nbsp;&nbsp;Recovery point  
Status:&nbsp;&nbsp;Failed  
Description:&nbsp;&nbsp;&nbsp;Failed to prepare a Cluster Shared Volume (CSV) for backup as another backup using the same CSV is in progress. (ID 32612 Details: Backup is in progress. Please wait for backup completion before trying this operation again (0x8007173D))  
More information  
End time:  
Start time:  
Time elapsed:  
Data transferred:&nbsp;&nbsp; 0 MB  
Cluster node&nbsp;&nbsp;&nbsp;N2-HyperV.contoso.COM  
Recovery Point Type&nbsp;&nbsp;&nbsp;Express Full  
Source details:&nbsp; \Backup Using Child Partition Snapshot\Hyper-V Guest Name  
Protection group:&nbsp;&nbsp;&nbsp;PG-NAME

> Type:&nbsp;&nbsp;&nbsp;&nbsp;Recovery point  
Status:&nbsp; Failed  
Description:&nbsp;&nbsp;&nbsp;An unexpected error occurred while the job was running. (ID 104 Details: The cluster resource could not be found (0x8007138F))  
More information  
End time:  
Start time:  
Time elapsed:&nbsp;&nbsp;&nbsp; 00:07:34  
Data transferred:&nbsp;&nbsp;&nbsp;0 MB  
Cluster node&nbsp;&nbsp;&nbsp;N2-HyperV.contoso.COM  
Recovery Point Type&nbsp;&nbsp;&nbsp;Express Full  
Source details:&nbsp; \Backup Using Child Partition Snapshot\Hyper-V Guest Name  
Protection group:&nbsp;&nbsp;&nbsp;PG-NAME

## Cause

This usually occurs if the cluster nodes hosting the Cluster Shared Volume (CSV) storage don't have a Volume Shadow Copy Service (VSS) Hardware snapshot provider installed. When no VSS hardware snapshot provider is installed, you must enable both cluster and CSV serialization as documented in [Considerations for Backing Up Virtual Machines on CSV with the System VSS Provider](/previous-versions/system-center/data-protection-manager-2010/ff634192(v=technet.10)?redirectedfrom=MSDN).

To see what VSS Snapshot providers are installed on the system, run `VSSADMIN LIST PROVIDERS` from an administrative command prompt. The default in-box system software provider is listed as follows. Note the **Provider ID GUID** is the same across Windows operating system versions.

- Provider name: Microsoft Software Shadow Copy provider 1.0
- Provider type: System
- Provider ID: **{b5946137-7b9f-4925-af80-51abd60b20d5}**  

However, even when using a VSS hardware snapshot provider, the error may still occur if you have a single CSV hosting all your guests.

If serialization is enabled and you have a special character like **&** in your Hyper-V virtual machine guest name, that will cause the `%programfiles%\Microsoft DPM\DPM\Config\DataSourceGroups.xml` file not to be parsed properly and the serialization will not work even when configured properly.

## Resolution

If you believe you have serialization enabled properly, check the `%programfiles%\Microsoft DPM\DPM\Config\DataSourceGroups.xml` file on the DPM server for special characters like **&** character. The easiest way to accomplish that is to open the DataSourceGroups.xml file using Internet Explorer. There should be no errors.

Regardless if using hardware or software snapshot provider, the following registry settings allow you to make adjustments to how DPM performs retries to claim the CSV in order to get reliable backups.

- `CsvMaxRetryAttempt` - Adjust the maximum number of times (Default is **1**) the DPM agent will attempt to claim the CSV volume. The value 0xC8 = 200 times.
- `CsvAttemptWaitTime` - Adjusts the amount of time in milliseconds to wait between retry attempts. The value 0x2bf20 = 3 minutes.

1. Copy the following in notepad, then save the file as csvretry.reg.

    ```console
    Windows Registry Editor Version 5.00
    [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft Data Protection Manager\Agent\CSV]
    "CsvMaxRetryAttempt"=dword:000000C8
    "CsvAttemptWaitTime"=dword:0002bf20
    ```

2. Copy the csvretry.reg file to each node in the cluster.
3. Sign in to each node in the cluster as an administrator, right-click the csvretry.reg file and then select **Open With** > **Registry Editor** option to import the registry settings.

If you continue to see the 0x8007173D errors, investigate further using this procedure:

1. Collect the `%Programfiles%\Microsoft Data Protection Manager\DPM\Temp\DPMRACURR.ERRLOG` from each node of the cluster.
2. Using notepad, open each Dpmracurr.errlog and save as ANSI using file name as node-name.
3. From a command prompt, run the following command:

    ```console
    Findstr /S "vsssnapshotrequestor.cpp(170) vsssnapshotrequestor.cpp(390) vsssnapshotrequestor.cpp(424) csvapi.cpp(400) vsssnapshotrequestor.cpp(585) hypervwriterhelperplugin.cpp(960) datasetfixupsubtaskbase.cpp(227) vsssnapshotrequestor.cpp(1111) freesnapshotsubtask.cpp(671)" <DPMRA>.errlog > ALL-BACKUP-START-FINISH.TXT
    ```

Open the ALL-BACKUP-START-FINISH.TXT text file in notepad and remove any entries not within the time period of the Hyper-V backup times. You can see the order of the backups and the CSV retry attempts.

### Example of good Hyper-V guest backup log entry

The `ProviderID` in this case is the **Microsoft Software VSS Provider**.

> N1-DPMRACurr.errlog:0CF4  9-May 4:00:19 PM vsssnapshotrequestor.cpp(170)     NORMAL CVssSnapshotRequestor::InitializeSnapshotCreation  
N1-DPMRACurr.errlog:0CF4  9-May 4:00:26 PM vsssnapshotrequestor.cpp(390)     NORMAL CVssSnapshotRequestor: AddVolumeForSnapshot - Marked volume C:\ClusterStorage\Volume1\ to be snapshot  
N1-DPMRACurr.errlog:0CF4  9-May 4:01:06 PM vsssnapshotrequestor.cpp(585)     NORMAL "CVssSnapshotRequestor:: ProviderId:[{B5946137-7B9F-4925-AF80-51ABD60B20D5}], h/w provider:[0], volume:[\\\\?\Volume{GUD}\\]"  
N1-DPMRACurr.errlog:0CF4  9-May 4:01:07 PM hypervwriterhelperplugin.cpp(960) NORMAL VhdChain with ssBaseVhdOfVhdChain : C:\ClusterStorage\Volume1\Guest_name\Gues.vhd  
N1-DPMRACurr.errlog:0CF4  9-May 4:01:07 PM datasetfixupsubtaskbase.cpp(227)  NORMAL CDatasetFixupSubTaskBase::BeginDataMove  
N1-DPMRACurr.errlog:0CF4  9-May 4:10:11 PM vsssnapshotrequestor.cpp(1111)    NORMAL CVssSnapshotRequestor::StartBackupComplete  
N1-DPMRACurr.errlog:0CF4  9-May 4:10:19 PM freesnapshotsubtask.cpp(671)      NORMAL CFreeSnapshotSubTask: ReleaseSnapshot  

### Example of failed backup even after four retries `CsvMaxRetryAttempt` = 3 and `CsvAttemptWaitTime` = 3 minutes

> N2-DPMRACurr.errlog:0900  9-May 4:00:40 PM vsssnapshotrequestor.cpp(170) NORMAL                    CVssSnapshotRequestor::InitializeSnapshotCreation  
N2-DPMRACurr.errlog:0900  9-May 4:00:45 PM vsssnapshotrequestor.cpp(390) NORMAL    CVssSnapshotRequestor: AddVolumeForSnapshot - Marked volume C:\ClusterStorage\Volume1\ to be snapshot  
N2-DPMRACurr.errlog:0900  9-May 4:00:45 PM csvapi.cpp(400)            WARNING  Failed: Hr: = [0x8007173d] : ClusterPrepareSharedVolumeForBackup for C:\ClusterStorage\Volume1\ failed  
N2-DPMRACurr.errlog:0900  9-May 4:03:46 PM csvapi.cpp(400)            WARNING  Failed: Hr: = [0x8007173d] : ClusterPrepareSharedVolumeForBackup for C:\ClusterStorage\Volume1\ failed  
N2-DPMRACurr.errlog:0900  9-May 4:06:46 PM csvapi.cpp(400)            WARNING  Failed: Hr: = [0x8007173d] : ClusterPrepareSharedVolumeForBackup for C:\ClusterStorage\Volume1\ failed  
N2-DPMRACurr.errlog:0900  9-May 4:09:47 PM csvapi.cpp(400)            WARNING  Failed: Hr: = [0x8007173d] : ClusterPrepareSharedVolumeForBackup for C:\ClusterStorage\Volume1\ failed  
N2-DPMRACurr.errlog:0900  9-May 4:12:47 PM csvapi.cpp(400)            WARNING  Failed: Hr: = [0x8007173d] : ClusterPrepareSharedVolumeForBackup for C:\ClusterStorage\Volume1\ failed  
N2-DPMRACurr.errlog:0900  9-May 4:12:49 PM freesnapshotsubtask.cpp(671)  NORMAL    CFreeSnapshotSubTask: ReleaseSnapshot

## More information

If the host level backups fail intermittently for other reasons, by default DPM will auto retry the backup one hour after the original failure. If that backup also fails, no additional retries are attempted.

To change the default auto retry interval and count, you can adjust the following registry settings.

> [!NOTE]
> These will affect all DPM jobs, not just Hyper-V Guest backup jobs.

- `AutoRerunDelay` - The delay in time in minutes before which DPM will attempt to automatically rerun failed jobs. If multiple reruns are configured, this is the gap between the reruns as well. The value of 0x3c = 60 minutes.
- `AutoRerunNumberOfAttempts` - The number of times a failed job will be retried before giving up if it consistently fails. Default is one. Increasing this value may increase the load on your system. The reruns are done at the gap of `AutoRerunDelay`.

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft Data Protection Manager\Configuration`

- `AutoRerunDelay` = dword:**0000003c**
- `AutoRerunNumberOfAttempts` = dword:**00000005**
