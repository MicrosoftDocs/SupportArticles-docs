---
title: iSCSI virtual disk size limits are incorrect
description: Resolve issues that occur when you provision new iSCSI Target virtual disks through the New iSCSI Target Virtual Disk wizard by using Server Manager File and Storage Services GUI.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:iscsi, csstroubleshoot
---
# iSCSI virtual disk size limits in Server Manager GUI are incorrect

This article provides help to solve issues that occur when you provision new iSCSI Target virtual disks through the **New iSCSI Target Virtual Disk** wizard by using Server Manager File and Storage Services GUI.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2896757

## Symptoms

In Windows Server 2012 R2, you can provision new iSCSI Target virtual disks through the **New iSCSI Target Virtual Disk** wizard using Server Manager File and Storage Services GUI. This wizard has the following two incorrect behaviors:

1. The wizard incorrectly blocks any virtual disk size to >= 16TB. Default behavior is to allow up to 64TB in Windows Server 2012 R2. In this case, the wizard fails with the following error message:

    > The size of the iSCSI virtual disk must be between 8MB and 16TB

2. The wizard incorrectly blocks a dynamic virtual disk size to >= free space available on the hosting volume. Default behavior is to allow virtual disk creation if the initial dynamic VHDX file (typically a few MB in size) can be successfully created on the volume. In this case, the wizard fails with the following error message:

    > The size of the iSCSI virtual disk must be less than or equal to the remaining free space on the volume

## Cause

The GUI behavior corresponds to Windows Server 2012 limits. In Windows Server 2012 R2, support of VHDX as the default storage format for iSCSI virtual disks has increased the upper limit to 64TB and the newly added support for dynamic VHDX also meant that the hosting volume is not required to have the capacity for a fully provisioned virtual disk up front when a dynamic virtual disk is created on this volume. So the GUI behavior in these cases is erroneous in Windows Server 2012 R2.

## Resolution

As of October 2013, there is no GUI resolution to work around these GUI problems.

However, the easy workaround is to use Windows PowerShell instead in these cases, use the `New-iSCSIVirtualDisk` cmdlet. The cmdlet documentation is available at [New-IscsiVirtualDisk](/powershell/module/iscsitarget/new-iscsivirtualdisk).

## References

[iscsi target server in Windows Server 2012 R2](https://blogs.technet.com/b/filecab/archive/2013/07/31/iscsi-target-server-in-windows-server-2012-r2.aspx)
