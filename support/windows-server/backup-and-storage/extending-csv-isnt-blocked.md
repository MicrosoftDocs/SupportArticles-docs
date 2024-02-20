---
title: Extending Cluster Shared Volume isn't blocked from a non-coordinator node
description: Provides a solution to an issue where extending a Cluster Shared Volume by using Diskpart or PowerShell isn't blocked from a non-coordinator node.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, josefh
ms.custom: sap:data-corruption-and-disk-errors, csstroubleshoot
---
# Extending a CSV by using Diskpart or PowerShell isn't blocked from a non-coordinator node

This article provides a solution to an issue where extending a Cluster Shared Volume by using Diskpart or PowerShell isn't blocked from a non-coordinator node.

_Applies to:_ &nbsp; Windows Server 2016, Windows Server 2019, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3189825

## Symptoms

Consider the following scenario:

- You have a failover cluster that has a Cluster Shared Volume (CSV) configured.
- You have to extend the CSV volume.
- From a non-coordinator node, you use the Diskpart command or a Windows PowerShell cmdlet to extend the volume.

In this scenario, the extend process is completed successfully. However, the Capacity section of the Disk Management console continues to show the old disk size value from before the extend process. In the Cluster GUI, the disk view shows the correct extended size but the volume size reflects the old values.

Additionally, you can't reduce the extended volume. If you try to do this, the process fails and you may receive the following error message:

> Wrong parameter

## Cause

This problem occurs because an extend write operation causes the Cluster Shared Volumes File System (CSVFS) to extend all or some of the following values:

- File allocation size
- File size
- Valid data length

A read operation could cause the CSVFS to query some information from NTFS. On the coordinator node, the CSVFS forwards metadata IO directly to the NTFS volume, but other nodes use the Server Message Block (SMB) to forward the metadata over the network.

In the Cluster GUI, you may notice that the **Extend Volume** option is greyed out on a non-coordinator node.

## Resolution

To resolve this problem, don't run any metadata operation from a non-coordinator node.

## More information

For more information about clustering and high-availability, see the following Failover Clustering and Network Load-Balancing Team Blog article:

[Cluster Shared Volume (CSV) Inside Out](https://techcommunity.microsoft.com/t5/failover-clustering/cluster-shared-volume-csv-inside-out/ba-p/371872)

## Workaround

To work around this problem, increase the disk space that's allocated to the CSV. To do this, extend the disk on the CSV owner node (coordinator node) by using the Cluster GUI, the Diskpart tool, or Windows PowerShell.

> [!NOTE]
> After you extend the disk, all displayed disk sizes and capacity values are updated to the correct size.
