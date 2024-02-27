---
title: Enable support for Clustered Windows Servers that use clustered RAID controllers
description: Describes the steps required to enable a Direct Attached clustered RAID Storage Solution for Clustered Windows Servers.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:setup-and-configuration-of-clustered-services-and-applications, csstroubleshoot
---
# Enable support for Clustered Windows Servers that use clustered RAID controllers

This article provides a solution to an issue where the validation may fail when you run a cluster validation wizard for Windows Server-based Failover Cluster.

_Applies to:_ &nbsp; Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2839292

## Symptoms

When you run a cluster validation wizard for Windows Server 2008 R2-based or Windows Server 2012-based Failover Cluster, the validation may fail. Additionally, you may receive an error message that resembles the following:

> Disk bus type does not support clustering

## Cause

This problem occurs if the shared storage type used by the system is Direct Attached clustered RAID controllers.

## Resolution

To resolve this problem, add a registry key that enables support for shared storage using Direct Attached clustered RAID controllers.

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs.
For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To add the key to the registry, follow these steps:

1. Open Registry editor (regedit.exe).
2. Locate and then select the following registry subkey:

    `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\ClusDisk\Parameters`
3. Right-click **Parameters** and then select **New**.
4. Select **DWORD** and give it a name of **AllowBusTypeRAID**.
5. Once the key is created, give it a value of 0x01.
6. Click **OK**.
7. Exit the Registry editor.
8. Restart the computer.

## More information

For more information on validated solutions for Cluster in a Box Validation Kit, visit the following article:

[Windows Server Storage documentation](/windows-server/storage/storage)
