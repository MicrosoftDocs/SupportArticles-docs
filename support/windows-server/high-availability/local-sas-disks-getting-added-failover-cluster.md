---
title: Local SAS Disks Getting Added in Windows Server Failover Cluster
description: Provides a workaround for the issue that Local SAS Disks getting added in Windows Server Failover Cluster
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, eldenc
ms.custom: sap:cannot-bring-a-resource-online, csstroubleshoot
---
# Local SAS Disks Getting Added in Windows Server Failover Cluster

This article provides a workaround for the issue that Local SAS Disks getting added in Windows Server Failover Cluster.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2813005

## Symptoms

On a Windows Server 2012 or Windows Server 2012 R2 Failover Cluster, local SAS drives may be clustered. After adding the Physical Disk resource, they may fail to come online. Additionally, you may receive the following error message:

Error Code: 0x80070001  
Incorrect function

Looking at the event logs you may notice the following event getting logged in the system event log:

## Cause

A local SAS drive may be clustered due to changes in the default behavior of cluster-able disk criteria introduced in Windows Server 2012.

## Workaround

To work around this problem, remove the disk resource from Failover Cluster Manager (FCM) if you do not want them to be part of Cluster. Additionally, you need to bring these drives online in Disk Management once you remove them from Failover Cluster Manager.

Identify non-shared disk signature on Cluster Nodes (For example use f6f6806f Disk Signature that is highlighted by validation report in the More information section).

#### Method 1


1. Open an elevated PowerShell prompt (right-click the tile or the icon and it's an option at the bottom bar).
2. Copy and paste below command to identify only the SAS drives

$signature = @{Label="Signature";Expression={[System.Convert]::ToString($_.signature, 16) }} 
Get-Disk |?{$_.bustype -eq "SAS"} | ft Number, $signature, Bustype -a  

Sample out-put of the above PowerShell command:

Number     Signature    BusType  
\--------- ----------- ----------  
 0 daf34ee4 SAS  
 1 f6f6806f SAS


#### Method 2

1. Open the Windows run box using keyboard, press Windows logo key‌ :::image type="icon" source="media/local-sas-disks-getting-added-failover-cluster/windows-logo-key.png" border="false"::: +R
2. Type Regedit and press enter
3. Locate and navigate to HKEY_LOCAL_MACHINE\SYSTEM\MountedDevices

    :::image type="content" source="media/local-sas-disks-getting-added-failover-cluster/mounted-devices.png" alt-text="Screenshot of the registry with the mounted device selected.":::

4. Reading Disk Signature from above registry is little tricky, you need to read key in reverse order

    :::image type="content" source="media/local-sas-disks-getting-added-failover-cluster/disk-signature-from-registry.png" alt-text="Screenshot of the disk signature from above registry.":::
  
   6f 80 f6 f6 would be read as F6F6806F 

5. Repeat same steps on all the nodes of the cluster.Note: If you are not aware of the drive letter, then you may need to compare all volume GUIDs and read data in the reverse order as mentioned in step 4 above.

## More information

A new feature enhancement in Failover Clustering for Windows Server 2012 and Windows Server 2012 R2 is that it supports an Asymmetric Storage Configuration. In Windows Server 2012 a disk is considered clusterable if it is presented to one or more nodes, and is not the boot / system disk, or contain a page file. In previous releases a disk had to be presented to all nodes in the cluster. This type of configuration is more common in multi-site clusters. Failover Cluster Manager (FCM) would automatically add these SAS drives that are exposed to one or more nodes during Adding Node in Cluster.

For more explicit control of which disks are clustered users can disable clustering from automatically clustering disks by unchecking "Add all eligible Storage to the Cluster" during creating wizard or Add desired disk later by using "Add Disk" in FCM.

:::image type="content" source="media/local-sas-disks-getting-added-failover-cluster/add-disk-in-fcm.png" alt-text="Screenshot of the Add Node Wizard window with the Add all eligible storage to the cluster checkbox selected.":::

Use Cluster Validation to determine if Disk can be used in Cluster. In below example, validation clearly depicts that disk is only visible on one node that usually can happen if the disks are local SAS to the node.

List Potential Cluster Disks 

Physical disk f6f6806f is visible from only one node and will not be tested. Validation requires that the disk be visible from at least two nodes. The disk is reported as visible at node:\<Node Name>  

Under the possible causes section you will find the following warning message:
*The cluster does not use shared storage. A cluster must use a hardware solution based either on shared storage or on replication between nodes. If your solution is based on replication between nodes, you do not need to rerun Storage tests. Instead, work with the provider of your replication solution to ensure that replicated copies of the cluster configuration database can be maintained across the nodes.

Failover Cluster would not add SAS drives if they contain the following information:
- Boot Files
- System File or Page file
- Pass through for Hyper-V
