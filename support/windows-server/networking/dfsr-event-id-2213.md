---
title: DFSR event ID 2213
description: Describes an issue that triggers event ID 2213 in Windows 2008 or Windows 2012. This event occurs when a server or the DFSR Service experiences a dirty shutdown. Best practices are included.
ms.date: 03/24/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: warrenw, kaushika
ms.custom: sap:dfsr, csstroubleshoot
---
# DFSR event ID 2213 in Windows Server 2008 R2

This article describes an issue that triggers event ID 2213 in Windows 2008 or Windows 2012.

_Applies to:_ &nbsp; Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2846759

## Summary

Microsoft has introduced new functionality to the DFS Replication (DFSR) service for Windows Server 2008 R2 through hotfix [2663685](https://support.microsoft.com/help/2663685). After you install hotfix 2663685 or a later version of Dfsrs.exe in Windows Server 2008 R2, the DFSR Service no longer performs automatic recovery of the Extensible Storage Engine (ESE)) database after the database experiences a dirty shutdown. Instead, when the new DFSR behavior is triggered, event ID 2213 is logged in the DFSR log. A DFSR administrator must manually resume replication after a dirty shutdown is detected by DFSR.

Windows Server 2012 exhibits this behavior by default.

The DFSR service maintains one ESE database per volume on volumes that host a replicated folder. DFSR uses this database to store metadata about each file and folder in the replicated folder. The integrity of the database must be maintained to make sure that the service continues to work correctly.

When DFSR is notified that the service must shut down, it starts to commit all outstanding changes to the ESE database. Dirty shutdown in DFSR occurs when the DFSR service cannot commit all pending changes to the DSFR ESE database before the DFSR service is shut down. During startup, the DFSR service checks the integrity of the database.

Dirty shutdown recovery may cause large backlogs, and these, in turn, may cause replication conflicts. In some cases, before the fix in [hotfix 2780453](https://support.microsoft.com/help/2780453) was released, the winning file may not be the version that the end-user wants. The update to stop replication during dirty shutdown was intended as a safeguard that lets administrators back up the data to capture deltas since the last backup was taken before replication is resumed.

After you install hotfix 2780453, you no longer have to pause replication during a dirty shutdown. The fix from [hotfix 2780453](https://support.microsoft.com/help/2780453) is included in all Windows 2012 default media.

## Best practices

Best practices for AutoRecovery based on server role, OS, and patch level:

|Role|Windows Server 2008 R2|Windows Server 2008 R2 with KB 2780453 installed|Windows Server 2012|
|---|---|---|---|
|DC|On|On|On|
|Cluster Node|On|On|On|
|Writable DFSR Server|Off|On|On|
|Read-only DFSR Server|On|On|On|
  
## Disable the Stop Replication functionality in AutoRecovery

To have DFSR perform AutoRecovery when a dirty database shutdown is detected, edit the following registry value after hotfix [2780453](https://support.microsoft.com/help/2780453) is installed in Windows Server 2008 R2. You can deploy this change on all versions of Windows Server 2012. If the value does not exist, you must create it.

- Key: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\DFSR\Parameters`
- Value: StopReplicationOnAutoRecovery
- Type: Dword
- Data: 0

## Resume replication after event 2213 is logged

After event 2213 is logged, an administrator must run a WMIC command in order to resume replication. The command specifics are provided in the text of event ID 2213.

### Step 1: Recovery steps for Event ID 2213 logged on your DFSR server

1. Back up the files in all replicated folders on the volume. Failure to do this may result in data loss from unexpected conflict resolution during the recovery of the replicated folders.

2. To resume the replication for this volume, use the `ResumeReplication` WMI method of the `DfsrVolumeConfig` class. For example, from an elevated command prompt, run the following command:

```console
wmic /namespace:\\root\microsoftdfs path dfsrVolumeConfig where volumeGuid="E18D8280-2379-11E2-A5A0-806E6F6E6963" call ResumeReplication
```

### Step 2: Copy the WMIC command from step 2 in event ID 2213 recovery steps, and then paste it into an elevated command prompt

When the command runs successfully, it returns the following results:

```console
wmic /namespace:\\root\microsoftdfs pathdfsrVolumeConfig where volumeGuid="F1CF316E-6A40-11E2-A826-00155D41C919" call ResumeReplication
```

> Executing(file://ww2008r2dc1/root/microsoftdfs:DfsrVolumeConfig.VolumeGuid=%22F1CF316E-6A40-11E2-A826-00155D41C919%22)-%3EResumeReplication()">\\WW2008R2DC1\root\microsoftdfs:DfsrVolumeConfig.VolumeGuid="F1CF316E-6A40-11E2-A826-00155D41C919")->ResumeReplication()  
Method execution successful.Out Parameters:instance of __PARAMETERS{ ReturnValue = 0;};

For PowerShell users, you have to add single quotation marks to the WMIC command to run it from PowerShell, as follows:

```powershell
wmic /namespace:\\root\microsoftdfs pathdfsrVolumeConfig where 'volumeGuid="F1CF316E-6A40-11E2-A826-00155D41C919"' call ResumeReplication
```

### Step 3: Check whether event IDs 2212 and 2214 have been logged

Check whether event IDs 2212 and 2214 have been logged on the server on which you ran the resume replication command. Additional note on recovery if you must reinitialize a replicated folder (or perform initial synchronization) after a dirty shutdown, follow these steps:

1. Disable the replicated folder.
2. Enable replication by using the steps in the preceding [Recovery steps for Event ID 2213 logged on your DFSR server](#step-1-recovery-steps-for-event-id-2213-logged-on-your-dfsr-server) section.
3. Enable the replicated folder.

If you disable and enable the replicated folder before you run the WMIC command, initial synchronization does not occur because the volume manager is offline.

## Steps to reduce the chances of a dirty shutdown

In Windows, a service has 30 seconds to shut down after it receives a shutdown notification. After 30 seconds, the Service Control Manager forces the service to shut down. Where the DFSR service is concerned, a busy hub server may need more than 30 seconds to commit outstanding changes to the database. If the DFSR service does not commit all changes in the 30 seconds that are allotted by the Service Control Manager, the service is forcibly closed, and this triggers a dirty shutdown recovery.

Power outages or any other hard reboot of a DFSR server may also trigger a dirty shutdown recovery. To reduce the chances of a dirty shutdown, make sure that your DFSR servers are connected to an uninterruptible power supply (UPS) to allow them to gracefully shut down.

## Extend service shutdown times

On DFSR servers that require more than 30 seconds to shut down, you can use the **WaitToKillServiceTimeout** value to extend the time period that's allowed for all services to shut down.

A DSFR server that needs more time to shut down typically logs events 2212 and 2214 on most server restarts or restarts of the service. Or if AutoRecovery from a dirty shutdown is enabled, event 2213 is logged on every server restart or restart of the DFSR service.

- Path: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control`
- Value: WaitToKillServiceTimeout
- Type: String
- Data: 300000

This value is in milliseconds. This example displays five minutes of shutdown time. The value can be increased or decreased as necessary. This value affects all services, not just DFSR. We recommend that you set this value to the lowest value that still gives DFSR sufficient time to shut down cleanly. Use the following process to determine how long your DFSR service needs to shut down:

1. Add the WaitToKillServiceTimeout registry value with a setting of 300000 milliseconds (5 minutes). Restart the server to enable the setting.

    > [!IMPORTANT]
    > See the note about installing [2549760](https://support.microsoft.com/help/2549760) in the following [Notes about WaitToKillServiceTimeOut](#notes-about-waittokillservicetimeout) section.)

2. Monitor the next few restarts of the server for DFSR events 1006 (DFSR is stopping) and 1008 (DFSR Stopped). Note the time that elapsed between events 1006 and 1008.

3. Adjust the time allowed for shutdown by the revising the **WaitToKillServiceTimeout** value so that it more closely reflects the actual time that DSFR needs to cleanly shut down.

### Notes about WaitToKillServiceTimeOut

- Restarting the server or restarting DFSR several times in a row will not provide an adequate sample of the time that DFSR needs to shut down. You must allow the service time to run a while in order to accumulate pending database transactions.

- The WaitToKillServiceTimeout setting has maximum value of one hour. If the setting exceeds one hour, SCM reverts to the default setting of 30 seconds for service shutdown.

- To make sure that SCM works correctly where the WaitToKillServiceTimeout setting is concerned, make sure that hotfix [2549760](https://support.microsoft.com/help/2549760)  is installed on Windows Server 2008 R2.
