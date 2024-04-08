---
title: BMR backup fails in DPM or Azure Backup Server
description: Describes an issue in which BMR backup fails because of high I/O latency if it uses Microsoft Azure Backup Server or System Center Data Protection Manager.
ms.date: 07/23/2020
ms.custom: sap:System Center 2016 Data Protection Manager
---
# BMR backup fails in Data Protection Manager or Azure Backup Server

This article helps you fix an issue where a bare metal recovery (BMR) backup fails because of high input/output (I/O) latency in Microsoft Azure Backup Server or System Center Data Protection Manager (DPM).

_Original product version:_ &nbsp; System Center 2016 Data Protection Manager  
_Original KB number:_ &nbsp; 4512842

## Symptoms

When you do a BMR backup by using Azure Backup Server or System Center Data Protection Manager, the backup fails. You receive one of the following error messages on the DPM server:

> DPM cannot create a backup because Windows Server Backup (WSB) on the protected computer encountered an error (WSB Event ID: 517, WSB Error Code: 0x6B48C3A0). (ID 30229 Details: Internal error code: 0x80990ED0)

> Log Name: DPM Alerts  
> Source: DPM-EM  
> Date: \<Date> \<Time>  
> Event ID: 3106  
> Task Category: None  
> Level: Error  
> Keywords: Classic  
> User: N/A  
> Computer: \<servername>  
> Description: The replica of Non VSS Datasource Writer on \<servername> is inconsistent with the protected data source. All protection activities for data source will fail until the replica is synchronized with consistency check. (ID: 3106)  
> **The storage involving the current operation could not be read from or written to. (ID: 40003)**  

The following error entries are logged on the protected server:

> Log Name: Microsoft-Windows-Backup  
> Source: Microsoft-Windows-Backup  
> Date: \<Date> \<Time>  
> Event ID: 5  
> Task Category: None  
> Level: Error  
> Keywords:  
> User: SYSTEM  
> Computer: \<Servername>  
> Description:  
> The backup operation that started at '\<Time>' has failed with following error code '0x8078015B' (Windows Backup encountered an error when accessing the remote shared folder. Please retry the operation after making sure that the remote shared folder is available and accessible.). Please review the event details for a solution, and then rerun the backup operation once the issue is resolved.

> Log Name: Microsoft-Windows-SmbClient/Connectivity  
> Source: Microsoft-Windows-SMBClient  
> Date: \<Date> \<Time>  
> Event ID: 30809  
> Task Category: None  
> Level: Error  
> Keywords: (64)  
> User: N/A  
> Computer: \<servername>  
> Description:  
> A request timed out because there was no response from the server.  
>
> Server name: \<Servername>  
> Session ID: \<Session ID>  
> Tree ID:0x1  
> Message ID:0x4000015  
> Command: Flush  
> Guidance:  
> The server is responding over TCP but not over SMB. Ensure the Server service is running and responsive, and the disks do not have high per-IO latency, which makes the disks appear unresponsive to SMB. Also, ensure the server is responsive overall and not paused; for instance, make sure you can log on to it.  

> Log Name: Microsoft-Windows-SMBServer/Operational  
> Source: Microsoft-Windows-SMBServer  
> Date: \<Date> \<Time>  
> Event ID: 1020  
> Task Category: (1020)  
> Level: Warning  
> Keywords: (8)  
> User: SYSTEM  
> Computer: \<ServerName>  
> Description:  
> File system operation has taken longer than expected.  
> Client Name: \<IP>  
> Client Address: \<IP:Port>  
> User Name: \<Username>  
> Session ID: \<Session ID>  
> Share Name: \<sharename>  
> File Name: WINDOWSIMAGEBACKUP\\\<Servername>\\\<Backupdate>\\\<GUID>.VHDX  
> Command: 7  
> Duration (in milliseconds): 353151  
> Warning Threshold (in milliseconds): 120000  
> Guidance:  
> The underlying file system has taken too long to respond to an operation. This typically indicates a problem with the storage and not SMB.  

## Cause

Windows backup server writes directly to the DPM or Azure Backup Server share during backup. This issue occurs if the input/output (I/O) latency is greater than the standard SMB time-out (60 seconds).

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To fix the issue, follow these steps:

1. On the protected server, open Registry Editor, and then add the `SessTimeout` registry entry as shown under the following subkey:

    |subkey|Name|Type|Data|
    |---|---|---|---|
    |`HKLM\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters`|SessTimeout|REG_DWORD|1200|

    > [!NOTE]
    > The 1,200 seconds (20 minutes) time-out is a recommended value. Adjust the value as appropriate. You can review the Resilient File System (ReFS) event logs on the DPM or Azure Backup Server server to find any suspected I/O latency.

2. Restart the protected server.

    If you can't restart the protected server, stop and restart the Workstation (Lanmanworkstation) service.

    > [!NOTE]
    > Make sure that you check the list of dependencies for the Workstation (Lanmanworkstation) service. The services that depend on this service must also be restarted.

## More information

When you use BMR backup, make sure that the following prerequisites are met:

- The latest update for DPM or Azure Backup Server is installed.

- The replica size is set correctly. For more information, see [How to increase DPM 2016 replica when using Modern Backup Storage (MBS)](https://techcommunity.microsoft.com/t5/system-center-blog/how-to-increase-dpm-2016-replica-when-using-modern-backup/ba-p/351818).
