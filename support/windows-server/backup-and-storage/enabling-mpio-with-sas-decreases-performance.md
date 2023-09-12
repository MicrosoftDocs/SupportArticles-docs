---
title: Enabling MPIO with SAS disks decreases performance
description: After enabling MPIO when using Storage Spaces and SAS storage, storage performance degrades significantly. This article provides workarounds for this issue.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:multipath-i/o-mpio-and-storport, csstroubleshoot
ms.technology: windows-server-backup-and-storage
---
# Enabling MPIO with SAS Storage decreases performance

This article provides help to solve an issue where sequential write performance of disks decreases by approximately 50% after you enable the Multipath I/O (MPIO) feature on a system using Serial Attached Storage (SAS) disks.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2744261

## Symptoms

On a Windows Server 2012, after enabling the MPIO feature on a system using SAS disks, the sequential write performance of disks used with MPIO decreases by approximately 50% when operating with the Round Robin load balancing policy.

## Cause

This issue can occur when disks are configured as below:

- The MPIO feature is enabled to provide access via both SAS ports.
- Disk firmware does not provide optimal performance when both SAS ports are in use.

> [!NOTE]
> This issue may occur when using Storage Spaces in conjunction with SAS disks and MPIO.

## Resolution

To resolve this issue, obtain updated firmware from your disk vendor.

You can work around this issue by trying a different Load Balance policy using the appropriate options mentioned below:

### Work around when using Storage Spaces or when LB policies have not been manually set per-disk

Use the Set-MSDSMGlobalDefaultLoadBalancePolicy  cmdlet from the MPIO module in Windows PowerShell to specify a different LB policy to apply to all pool disks.

### Work around when not using Storage Spaces, or when LB policies have been set per-disk manually

1. Open Disk Management. To open Disk Management, on the Windows desktop, click Start; in the Start Search field, type diskmgmt.msc; and then, in the Programs list, click diskmgmt.
2. Right-click the multipathed disk for which you want to change the policy setting, and click Properties.
3. Click the MPIO tab.
4. In the Select the MPIO Policy dropdown list select another policy, such as Least Blocks.
5. Click OK.
6. Repeat above steps for all other multipathed disks exhibiting slow performance.

## More information

For a complete listing of the cmdlets contained in the iSCSI module for Windows PowerShell, refer to the following documents:

[iSCSI](/powershell/module/iscsi/?view=win10-ps&preserve-view=true)

[iSCSI Initiator WMI Classes](/previous-versions/windows/desktop/iscsidisc/iscsi-initiator-wmi-classes)
