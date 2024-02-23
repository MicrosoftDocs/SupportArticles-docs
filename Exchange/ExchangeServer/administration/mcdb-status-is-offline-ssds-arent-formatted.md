---
title: MCDB status is Offline and SSDs aren't formatted in Exchange Server 2019
description: Describes an issue in which Microsoft Exchange Server 2019 MCDB status is Offline and SSDs are not formatted when you use the Manage-MetaCacheDatabase.ps1 script to enable MCDB. Provides a workaround.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CI 107238
  - CSSTroubleshoot
ms.reviewer: ralfle, v-six
appliesto: 
  - Exchange Server 2019
search.appverid: 
  - MET150
ms.date: 01/24/2024
---

# MCDB status is "Offline" and SSDs are not formatted in Exchange Server 2019

## Symptoms

Assume that you deploy Microsoft Exchange Server 2019 in Windows Server 2019. You use the **Manage-MetaCacheDatabase.ps1** script to enable [MetaCacheDatabase (MCDB)](/exchange/high-availability/database-availability-groups/metacachedatabase-setup?preserve-view=true&view=exchserver-2019).

For example:

```powershell
Manage-MCDB -DagName TestDag1 -ServerAllowMCDB $false -ServerName "exhs-5046" -ForceFailover $true
```

Then, you use the `Get-MailboxDatabaseCopyStatus` cmdlet to view the health and status information for the database copies.

For example:

```
Get-MailboxDatabaseCopyStatus | Fl name, *meta*

Name : DB01\Server01
MetaCacheDatabaseStatus : Offline
MetaCacheDatabaseStatusMessage : Partition not attached in active Store worker process.
MetaCacheDatabaseFilePath : C:\ExchangeMetaCacheDbs\DB01\DB01.mcdb\DB01-mcdb.edb
MetaCacheDatabaseLastReset :
```
This example returns the status for the copy of database DB01 on Mailbox server Server01.

In the results, you find that the solid state drive (SSD) is not formatted as expected, and the MCDB status is "Offline." Additionally, not all designated SSDs are formatted, and mount points are not created as expected.

## Cause

This issue occurs because of a new behavior in Windows Server 2019 that causes **Get-Disk** to return all uninitialized discs within the database availability group (DAG) or cluster, and the script incorrectly tries to format an SSD on another DAG member.

## Workaround

To work around this issue, follow these steps:

1. Locate the Manage-MetaCacheDatabase.ps1 file (the default path is: `%programfiles%\Microsoft\Exchange Server\V15\Scripts`​).
2. Open the file by using a text editor, such as Notepad.​
3. Change the **Manage-MetaCacheDatabase.ps1** script as follows:

    ```
    At line 607:
    From: ​$SSDS = Get-PhysicalDisk | where {$_.MediaType -eq "SSD"}
    To: ​ $SSDS = Get-Disk | Where-Object {$_.Number -NE $NULL} | Get-PhysicalDisk | where {$_.MediaType -eq "SSD"}​

    At line 659: ​
    From: ​$SSDDisk = Get-Disk -Partition $Partition​​
    To:​ $SSDDisk = Get-Disk -Partition $Partition | Where-Object {$_.Number -NE $NULL}​
    ```

4. Remove the script signature starting at **line 1050**, and then save and close the file.
5. Repeat the previous steps on all DAG members, or copy and replace the script on other member servers. ​
6. In the Exchange Management Shell session, enable the shell to run unsigned PowerShell scripts. To do that, run the following command: ​

    ```powershell
    Set-ExecutionPolicy Unrestricted​
    ```

7. Rerun `Manage-MCDB` to enable MCDB. We recommend that you reset the **ExecutionPolicy** value to the previous value after the MCDB configuration is completed. ​

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section and will post more information in this article when it becomes available.