---
title: Recommended updates for Windows Server 2008 R2-based server clusters
description: Discusses the recommended hotfixes and updates for Windows Server 2008 R2-based server clusters, and describes these hotfixes and updates.
ms.date: 03/24/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:replacing-hardware-and-updating-the-operating-system, csstroubleshoot
---
# Recommended hotfixes and updates for Windows Server 2008 R2-based server clusters

This article describes the hotfixes and updates that we recommend that you install on each node of a Windows Server 2008 R2-based failover cluster.

_Applies to:_ &nbsp; Windows Server 2008 R2  
_Original KB number:_ &nbsp; 980054

## Summary

When you update your Windows Server 2008 R2-based failover cluster, you help reduce downtime. You also help decrease the number of errors, failed print jobs, and other support issues that you experience.

> [!NOTE]
> We recommend that you evaluate these hotfixes and updates to determine whether they might resolve problems in your environment. If you determine that cluster nodes that are in your environment may be affected by the problems that an update or hotfix addresses, install the hotfix or update on each cluster node that is in your environment.

Use the information in the [More information](#more-information) section to help you determine whether a particular hotfix or update applies to the server cluster. Before you install a particular hotfix or update, we recommend that you review the original Microsoft Knowledge Base (KB) article that describes that hotfix or update.

## More information

We recommend that you install Windows Server 2008 R2 Service Pack 1 (SP1), as it has many fixes for problems with Windows Clustering. We also recommend installing the hotfixes that are referenced in [Recommended hotfixes and updates for Windows Server 2008 R2 SP1 Failover Clusters](updates-for-windows-server-2008-r2-sp1-failover-cluster.md). If for any reason you cannot immediately apply SP1, we recommend that you install the following Windows Server 2008 R2 hotfixes, depending on your environment.

### General hotfixes

We recommend that you install the following hotfixes if you plan to install the failover clustering feature on Windows Server 2008 R2 Core:

| Date when the hotfix was added| Knowledge Base article| Title| Component| Why we recommend this hotfix |
|---|---|---|---|---|
|August 3, 2013| [2685891](https://support.microsoft.com/help/2685891)|CAP does not come online in a Windows Server 2008 R2-based or Windows Server 2008-based failover cluster|Clusres.dll|Prevents cluster outage when CAP fails to come online. Available for individual download.|
|April 25, 2012| [2559392](https://support.microsoft.com/help/2559392)|The List Running Processes test fails when you run the Failover Cluster Validation Wizard on a Windows 7-based or Windows Server 2008 R2-based cluster node|Multiple validation .dll files|Prevents cluster validation failure. Passing validation is required to have a supported cluster configuration. Available for individual download.|
|March 16, 2012| [2639032](https://support.microsoft.com/help/2639032)|0x0000003B, 0x00000027, and 0x0000007e Stop errors when a connection to a CSV is lost.|Clusauthmgr.dll<br/><br/>Csvfilter.sys|Prevents a Stop error. Available for individual download.|
|November 22, 2012| [2687646](https://support.microsoft.com/help/2687646)|A LUN that is registered to a cluster shared volume is invisible and inaccessible|clussvc.exe<br/><br/>cluswmi.dll|Prevents a LUN from not being detected by the operating system. Available for individual download.|
|January 17, 2012| [2524478](https://support.microsoft.com/help/2524478)|The network location profile changes from Domain to Public in<br/>Windows 7 or in Windows Server 2008 R2|Ncsi.dll<br/><br/>Nlaapi.dll<br/><br/>Nlasvc.dll|Prevents potential loss of cluster communication. Available for individual download.|
|May 14, 2011| [2545850](https://support.microsoft.com/help/2545850)|Users cannot access an IIS-hosted website after the computer password for the server is changed in Windows 7 or in Windows Server 2008 R2|Multiple Authentication DLL's|Prevents CNO and VCO objects from failing to register in DNS due to Kerberos authentication not working after the computer password is changed.|
|March 24, 2010| [978309](https://support.microsoft.com/help/978309)|IPv6 transition technologies, such as ISATAP, 6to4, and Teredo do not work on a computer that is running Windows Server 2008 R2 Server Core|Tunnel.sys|Fixes components leveraged by failover cluster on 2008 R2 Server Core installations. Available for individual download.|
|September 4, 2010| [976571](https://support.microsoft.com/help/976571)|Stability update for Windows Server 2008 R2 Failover Print Clusters|Win32spl.dll|Fixes print cluster stability. Apply only if print cluster resources are configured. Available for individual download.|

To avoid problems that affect the cluster operation when the network is unreliable, install the following hotfix:

[2552040](https://support.microsoft.com/help/2552040)  A Windows Server 2008 R2 failover cluster loses quorum when an asymmetric communication failure occurs

To avoid performance issues on the cluster and possible system crashes, install the following hotfix:

[2520235](https://support.microsoft.com/help/2520235) 0x0000009E Stop error when you add an extra storage disk to a failover cluster in Windows Server 2008 R2

### Resource-specific hotfixes

We recommend that you install the following hotfixes, depending on the resources that are running on the server cluster. You do not have to install these hotfixes if you are not running these resources on the server cluster.

[976571](https://support.microsoft.com/help/976571) Stability update for Windows Server 2008 R2 Failover Print Clusters
