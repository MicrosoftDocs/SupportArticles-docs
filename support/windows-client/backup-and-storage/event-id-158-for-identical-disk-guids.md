---
title: Event ID 158 for identical disk GUIDs
description: Discusses that Event ID 158 is logged if identical disk GUIDs are found. Provides a resolution.
ms.date: 12/26/2023
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, aarthit, toklima
ms.custom: sap:storage-hardware, csstroubleshoot
---
# Event ID 158 is logged for identical disk GUIDs

This article provides a resolution to solve the event ID 158 that's logged for identical disk GUIDs in Windows 10.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2983588

## Symptoms

An error event for Event ID 158 is logged. The event indicates that two or more disk devices are assigned identical disk GUIDs.

> [!NOTE]
> The above event message has no functionality or performance impact on the client systems. This event provides a warning that multiple disks on the system shared the same identification information (like serial number, page 83 IDs, and so on.)

## Cause

This problem may be caused by any one of several different situations. The two most common situations are the following ones:

- Multiple paths to the same physical disk device are available. But Microsoft Multipath I/O (MPIO) isn't enabled. In this situation, the device is exposed to the system by all paths that are available. It causes the same device ID data (such as Device Serial Number, Vendor ID, Product ID, and so on) to be exposed multiple times.
- If Virtual Hard Disks (VHD) are duplicated by using a copy-and-paste operation to create more virtual machines (VMs), none of the internal data structures are changed. So, the VMs have the same disk GUIDs and the same ID information (such as Device Serial Number, Vendor ID, Product ID, and so on).

## Resolution

To resolve this problem, if multiple paths are available to the physical disk devices, enable MPIO. If MPIO is enabled, the system can claim the drives and expose only one instance of each disk device when the computer is restarted.

## More Information

For more information about how to enable MPIO, see [Installing and Configuring MPIO](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee619752(v=ws.10)).

If multiple VHDs are identified as duplicates, use the `ResetDiskIdentifier` parameter of the `Set-VHD` Windows PowerShell cmdlet. For more information about the `Set-VHD` cmdlet, see [Set-VHD](/powershell/module/hyper-v/set-vhd).
