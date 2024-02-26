---
title: When you use the Volume Shadow Copy Service on computers that run many I/O operations, disk volumes take longer to go online
description: Describes a workaround for an issue in which disk volumes take more time to go online after you enable the Volume Shadow Copy Service on the volumes
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, ronsto
ms.custom: sap:volume-shadow-copy-service-vss, csstroubleshoot
---
# Disk volumes take longer to go online when you use the Volume Shadow Copy Service on computers that run many I/O operations

This article describes a workaround for an issue in which disk volumes take more time to go online after you enable the Volume Shadow Copy Service on the volumes.  

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 945058

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure that you back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[322756](https://support.microsoft.com/help/322756) How to back up and restore the registry in Windows  

## Symptoms

When you use the Volume Shadow Copy Service in Windows Server based computers that run many I/O operations and that have lots of data, you experience the following symptoms:

- Cluster failover time is longer for the cluster groups that contain disk resources for which you have enabled the Volume Shadow Copy Service. Also, the disk volumes of the cluster nodes take longer to go online and offline during a cluster failover. Taking a disk offline and then online on the same node also has the same delay.

- Non-cluster servers take longer to start. When you disable the Volume Shadow Copy Service on the server volumes, the servers start as expected.

## Cause

This issue occurs because of the way the Volume Shadow Copy driver (Volsnap.sys) manages the shadow copy files. If lots of shadow copy files are created on the disk volumes, the Volume Shadow Copy driver takes more time to process those shadow copy files when the system brings the disk volumes online.

## Workaround

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

To work around this issue, create a new registry key to restrict the number of shadow copy files that are created on each disk volume to 20.

> [!NOTE]
> This value is only a suggested starting value. We recommend that you find a value that is appropriate for your working environment.

To create the new registry key, follow these steps:

1. Click **Start**, click **Run**, type *regedit*, and then press ENTER.
2. Locate and then right-click the following registry subkey:  
 `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\VSS\Settings`
3. Point to **New**, and then click **DWORD Value**.
4. Type *MaxShadowCopies*, and then press ENTER.
5. Double-click **MaxShadowCopies**, type *20* in the **Value data** box, and then click **OK**.
6. Exit Registry Editor.
7. Restart the computer.
