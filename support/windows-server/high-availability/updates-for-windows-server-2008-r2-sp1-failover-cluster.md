---
title: Recommended updates for Windows Server 2008 R2 SP1 Failover Clusters
description: Describes the hotfixes for Windows Server 2008 R2 SP1 Failover Clusters that we recommend you install, depending on your environment.
ms.date: 45286
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: ctimon, kaushika
ms.custom: sap:setup-and-configuration-of-clustered-services-and-applications, csstroubleshoot
---
# Recommended hotfixes and updates for Windows Server 2008 R2 SP1 Failover Clusters

This article documents recommended hotfixes for Windows Server 2008 R2 Service Pack 1 (SP1) Failover Clusters. Applying these fixes can improve the reliability of your high availability solution.

_Applies to:_ &nbsp; Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2545685

> [!NOTE]
> We recommend that you evaluate each fix to determine whether it applies to your environment. If you determine that Failover Clusters in your environment may be affected by the problem(s) that a fix addresses, install the fix on each cluster node by using the procedures that are described in [How to update Windows Server failover clusters](windows-server-failover-clusters-service-packs-hotfixes.md).
>
> Use the information in the More information section to help you determine whether a particular fix applies to the cluster. Before you install a particular fix, we recommend that you review the original Microsoft Knowledge Base (KB) article that describes the fix.

## Recommended hotfixes and updates

| Date when the hotfix was added| Knowledge Base article| Title| Component| Why we recommend this hotfix |
|---|---|---|---|---|
|January 22, 2015| [3033918](https://support.microsoft.com/help/3033918)|Disk resource does not come online in Windows Server 2012 R2 or Windows Server 2008 R2-based failover cluster|Clusres.dll|Makes sure that chkdsk works correctly on clustered volumes.|
|November 19, 2014| [2972254](https://support.microsoft.com/help/2972254)|Hyper-V virtual machines cannot be connected to sometimes when TCP connections reconnect in Windows|Clussvc.exe<br/><br/>Cluswmi.dll|Prevents connectivity issues between nodes.|
|July 23, 2014| [2871803](https://support.microsoft.com/help/2871803)|0x0000007E Stop error when you log off from a Windows Server 2008 R2 SP1-based failover cluster|Clusauthmgr.dll<br/><br/>Csvfilter.sys|Prevents a blue screen error when you log off Cluster Administrator. Available for individual download.|
|November 17, 2012| [2524478](https://support.microsoft.com/help/2524478)|The network location profile changes from Domain to Public in Windows 7 or in Windows Server 2008 R2|Ncsi.dll<br/><br/>Nlaapi.dll<br/><br/>Nlasvc.dll|Prevents loss of Cluster communication.|
|April 25, 2012| [2559392](https://support.microsoft.com/help/2559392)|The List Running Processes test fails when you run the Failover Cluster Validation Wizard on a Windows 7-based or Windows Server 2008 R2-based cluster node|Multiple Validation DLL's|Prevents Cluster Validation failure. Passing validation is required to have a Supported Cluster configuration.|
|June 14, 2011| [2545850](https://support.microsoft.com/help/2545850)|Users cannot access an IIS-hosted website after the computer password for the server is changed in Windows 7 or in Windows Server 2008 R2|Multiple Authentication DLL's|Prevents CNO and VCO objects from failing to register in DNS because of Kerberos authentication failure after the computer password is changed.|

To see the latest list of hotfixes for Windows Server 2008 R2 Hyper-V configurations, see [Hyper-V Update List for Windows Server 2008 R2](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ff394763(v=ws.10)).
