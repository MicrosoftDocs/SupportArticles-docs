---
title: Can't mount databases that are larger than 1024 GB
description: Fixes an issue that prevents you from remounting a large dismounted database (>1 TB) in Exchange Server 2019 Standard Edition, Exchange Server 2016 Standard Edition and Exchange Server 2013 Standard Edition. This issue concerns the default database size limit.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CI 119623
  - CSSTroubleshoot
ms.reviewer: dpaul, honche, jarrettr, genli, christys, v-six
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2019 Standard Edition
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2016 Standard Edition
ms.date: 01/24/2024
---
# Exchange Server 2013, 2016 and 2019 Standard Edition can't mount databases that are larger than 1024 GB

_Original KB number:_ &nbsp; 3059008

## Summary

This issue occurs because the default database size limit for Microsoft Exchange Server 2019 Standard Edition, Exchange Server 2016 Standard Edition and Exchange Server 2013 Standard Edition is 1,024 gigabytes (GB). There is no default database size limit for the Enterprise Edition. The Exchange store checks database size limits periodically and dismounts a database when the size limit is reached. Therefore, this issue may occur after the database is automatically dismounted.

Additionally, when you perform a failover of the database, the failover fails.

> [!NOTE]
> The database maximum size is hard-coded as 1,024 GB in the event, even though you may have changed it to a higher value in the registry.

## Resolution

In order to have the full functionality of the Exchange database availability group (DAG) again, you must buy an Enterprise Edition license and apply it to the server.

## Workaround

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To mount the database again, and to prevent the database from being automatically dismounted, follow these steps:

1. Start Registry Editor.
2. Locate the registry subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\MSExchangeIS\<Server Name>\Private-<database GUID>`.

    > [!NOTE]
    >  You can retrieve the GUID of a database by running the following command in the Exchange Management Shell:

    ```powershell
    Get-MailboxDatabase -Identity "<database name>" | Format-Table Name, GUID
    ```

3. If the `Database Size Limit in GB` DWORD value exists for the subkey, change it to the size that you want, in GB.
4. If the `Database Size Limit in GB` DWORD value does not exist for the subkey, create a new DWORD value with that name, and then set its value to the size that you want, in GB.
5. Mount the database on the server by using Exchange Management Shell and the `-Force` switch.

> [!NOTE]
>
> - When you change this setting, the change is propagated to all servers that host a copy of this database.
> - This registry key may be deleted after an Exchange cumulative update is applied.
> - This registry setting still doesn't allow the automatic failover of databases within the DAG. You must use the `-Force` switch when you mount the database with this registry setting in place.

## Status

Microsoft has confirmed that this is a problem.
