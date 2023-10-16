---
title: Physical disk resource doesn't come online
description: Describes an issue that occurs after you install Symantec Endpoint Protection 11.0 Release Update 5 on a cluster node that is running Windows Server 2012 R2.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:cannot-bring-a-resource-online, csstroubleshoot
ms.technology: windows-server-high-availability
---
# A physical disk resource may not come online on a cluster node

This article helps solve an issue where a physical disk resource doesn't come online on a cluster node.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 981475

## Symptoms

On a cluster node that is running Windows Server, a physical disk resource may enter the **Failed** state when you try to move a group that contains the physical disk resource. If you restart the cluster node that has the physical disk resource that did not come online, the problem is temporarily resolved.

When this problem occurs, the following entries are logged in the Cluster log for the physical disk resource that entered the **failed** state:

> 000020cc.000014d0::*\<DateTime>* ERR Physical Disk \<Disk Q:>:  
DiskspCheckPath: GetFileAttrs(Q:) returned status of 87.  
000020cc.000014d0::*\<DateTime>* WARN Physical Disk \<Disk Q:>:  
DiskspCheckDriveLetter: Checking drive name (Q:) returns 87

Additionally, the following events are logged in the System Event log:

> Event Type: Error  
Event Source: ClusSvc  
Event Category: Physical Disk Resource  
Event ID: 1066  
Date: \<date>  
Time: \<time>  
User: N/A  
Computer: \<node name>  
Description: Cluster disk resource "Disk Q:" is corrupt. Run 'ChkDsk /F' to repair problems. The volume name for this resource is "<\\?\Volume{4323d41e-1379-11dd-9538-001e0b20dfe6}\>". If available, ChkDsk output will be in the file "C:\WINDOWS\Cluster\ChkDsk_Disk2_SigB05E593B.log". ChkDsk may write information to the Application Event Log with Event ID 26180.
>
> Event Type: Error  
Event Source: ClusSvc  
Event Category: Physical Disk Resource  
Event ID: 1035  
Date: \<date>  
Time: \<time>  
User: N/A  
Computer: \<node name>  
Description: Cluster disk resource 'Disk Q:' could not be mounted.

Similarly, on a Windows Server cluster node you may see following entries are logged in the Cluster log:

> 00000db0.00000868::*\<DateTime>* WARN [RES] Physical Disk \<Cluster Disk 1>: OnlineThread: Failed to get volume guid for device \\?\GLOBALROOT\Device\Harddisk15\Partition1\. Error 3  
00000db0.00000868::*\<DateTime>* WARN [RES] Physical Disk \<Cluster Disk 1>: OnlineThread: Failed to set volguid \??\Volume{3cb36133-0d0b-11df-afcf-005056ab58b9}. Error: 183.  
00000db0.00000868::*\<DateTime>* INFO [RES] Physical Disk \<Cluster Disk 1>: VolumeIsNtfs: Volume \\?\GLOBALROOT\Device\Harddisk15\Partition1\ has FS type NTFS

## Cause

This problem is known to occur when antivirus software that is not cluster-aware is installed, upgraded, or reconfigured. For example, this problem is known to occur after you install or migrate to Symantec Endpoint Protection 11.0 Release Update 5 (RU5) on the cluster nodes.

## Resolution

To resolve this problem, follow these steps:

1. Verify that this problem is caused by Symantec Endpoint Protection (SEP) 11.0 Release Update 5 (RU5). To do this, run the Handle.exe utility immediately after the issue occurs on the cluster node where the physical disk resource did not come online.

    At an elevated command prompt, type the following command, and then press ENTER: `Handle.exe -a -u drive_letter`.

    > [!NOTE]
    > The **drive_letter** placeholder is the drive designation for the cluster drive that did not come online.

    For example, assume that the drive designation for the cluster drive that did not come online is drive Q. To run the Handle.exe utility in this scenario, type the following command, and then press ENTER: `Handle.exe -a -u Q:`.

    The problem is caused by the Symantec application if you receive the following message that identifies the Smc.exe process as the process that owns the handle:

    > Handle v3.42  
    Copyright (C) 1997-2008 Mark Russinovich  
    Sysinternals - www.sysinternals.com

    `Smc.exe pid: 856 NT AUTHORITY\SYSTEM 66C: Q:`

2. If the problem is caused by the Symantec application, contact Symantec to obtain Symantec Endpoint Protection 11 Release Update 6 (RU6), which was released to resolve this issue.

## More information

For more information about the Handle.exe utility, see [Handle v4.22](/sysinternals/downloads/handle).

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.
