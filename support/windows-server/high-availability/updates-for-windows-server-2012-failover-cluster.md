---
title: Recommended updates for Windows Server 2012-based failover clusters
description: Describes the hotfixes that are currently available for Windows Server 2012-based failover clusters.
ms.date: 03/24/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: cpuckett, kaushika
ms.custom: sap:cluster-aware-updating-cau, csstroubleshoot
ms.subservice: high-availability
---
# Recommended hotfixes and updates for Windows Server 2012-based failover clusters

This article describes the hotfixes that are currently available for Windows Server 2012-based failover clusters and highly recommended to be installed on each server of a failover cluster.

_Applies to:_ &nbsp; Windows Server 2012  
_Original KB number:_ &nbsp; 2784261

## Summary

Failover Cluster Management enables multiple servers to provide a high availability of server roles. Failover Cluster Management is frequently used for file services, virtual machines, database applications, and mail applications.

> [!IMPORTANT]
> The process for installing service packs and hotfixes on Windows Server 2012 differs from the process in earlier versions. In Windows Server 2012, you can use the Cluster-Aware Updating (CAU) feature. CAU automates the software-updating process on clustered servers while maintaining availability. For more information, see [Cluster-Aware Updating Overview](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831694(v=ws.11)).

## Introduction

The following Microsoft Knowledge Base articles describe the currently available fixes that are highly recommended to be installed on all failover clusters. Most of the updates apply to computers that are running Windows Server 2012. Some updates, such as KB [976424](https://support.microsoft.com/help/976424), may be needed on computers that are running Windows Server 2008 R2 or Windows Server 2008 if those operating systems are present in the environment.

These updates are considered to be important to install to ensure the highest level of reliability.

> [!NOTE]
> You may substitute a newer monthly rollup in place of KB 4282815. The remainder of the updates in this list are still needed as some components in those updates released before September 2016 and are not included in the newer monthly rollup.

|Date when the hotfix was added|Knowledge Base article|Title|Component|Why we recommend this hotfix|
|---|---|---|---|---|
|September 30, 2016| [3185280](https://support.microsoft.com/help/3185280)|September 2016 update rollup for Windows Server 2012|`Clussvc.exe`|Resolves an issue when a cluster node sends an Internet Control Message Protocol (ICMP) request to a gateway, TCPIP returns a timeout error (Error code 11010, IP_REQ_TIMED_OUT), even if ICMP doesn't receive a timeout. Available from Windows Update. Includes the fixes in [3090343](https://support.microsoft.com/help/3090343) and [3076953](https://support.microsoft.com/help/3076953). |
|July 22, 2015| [3062586](https://support.microsoft.com/help/3062586)|0x000000D1 Stop error on a Windows Server 2012-based cluster|Netft|Prevents a Stop 0xD1 when processing a network buffer list (NBL). Not all 0x000000D1 Stop errors are caused by this issue. Available for individual download.|
|July 6, 2015| [3018489](https://support.microsoft.com/help/3018489)|"No host bus adapter is present" error when querying SAS cable issues in Windows Server 2012 R2 or Windows Server 2012|Storport|To receive the updated logging capabilities of storport.sys covered in [KB 2819476](https://support.microsoft.com/help/2819476) plus the fixes in [KB 3018489](https://support.microsoft.com/help/3018489), [KB 2908783](https://support.microsoft.com/help/2908783) and [KB 2867201](https://support.microsoft.com/help/2867201). Available for individual download.|
|April 22, 2015| [3048474](https://support.microsoft.com/help/3048474)|WMI provider cannot start when you manage Hyper-V or failover cluster in Windows 8 or Windows Server 2012|WMI|Recovers a WMI provider when it has hit the WMI memory threshold so you can continue to manage Hyper-V or failover cluster in Windows 8 or Windows Server 2012. Available for individual download.|
|January 13, 2015| [3004098](https://support.microsoft.com/help/3004098)|Memory leak occurs when you create or delete CSV snapshots by using a VSS hardware provider in Windows|`Csvfs.sys`|Prevents a memory leak when you create or delete CSV snapshots by using a hardware Volume Shadow Copy Service (VSS) provider. Available for individual download.|
|April 8, 2014| [2916993](https://support.microsoft.com/help/2916993)|Stop error 0x9E in Windows Server 2012 or Windows 8|`Ntoskrnl.exe`|Prevents a lock contention and Stop 0x9e when a large file is mapped into the system cache, for instance a backup operation is copying files from snapshots. Available for individual download.|
|March 17, 2014| [2929869](https://support.microsoft.com/help/2929869)|CSV snapshot file is corrupted when you create some files on the live volume|`Csvflt.sys` `Csvfs.sys`<br/>`Volsnap.sys`|Prevents CSV snapshot file corruption when a file is deleted and recreated on the live volume. Available for individual download.|
|Jan. 15, 2014| [2913695](https://support.microsoft.com/help/2913695)|OffloadWrite is doing PrepareForCriticalIo for the whole VHD in a Windows Server 2012 or Windows Server 2012 R2 Hyper-V host|NTFS.sys|Performance improvement when there is an offload write for a virtual hard disk (VHD) in the host. Available for individual download.|
|Jan. 2, 2014| [2878635](https://support.microsoft.com/help/2878635)|Update is available that improves the resiliency of the cloud service provider in Windows Server 2012: December 2013|Multiple|This hotfix prevents a CSV failover by fixing an underlying issue in NTFS, software snapshots, and by increasing the overall resilience of the Cluster service and CSV during expected pause states. Available for individual download.|
|Nov. 14, 2013| [2894464](https://support.microsoft.com/help/2894464)|Error message when you try to schedule a shadow copy task in Windows Server 2012|Failover Cluster Resource DLL|This hotfix resolves an error when you try to schedule a shadow copy task on a shared disk. Available for individual download.|
|June 14, 2013| [2838043](https://support.microsoft.com/help/2838043)|Can't access a resource that is hosted on a Windows Server 2012-based failover cluster|Failover Cluster Resource DLL|This hotfix prevents an error when resources that are hosted on a Windows 8-based or Windows Server 2012-based failover cluster are accessed from a Windows XP-based or Windows Server 2003-based client computer.<br/><br/>This hotfix also resolves an Event ID 1196 with error: The handle is invalid when the cluster network name resource does not come online and register in DNS.<br/><br/>Available for individual download and included in [2889784](https://support.microsoft.com/help/2889784) (Windows RT, Windows 8, and Windows Server 2012 update rollup: November 2013).|
|Jan. 23, 2013| [2803748](https://support.microsoft.com/help/2803748)|Failover Cluster Management snap-in crashes after you install update 2750149 on a Windows Server 2012-based failover cluster|Failover Cluster Management snap-in|Resolves a crash in the Failover Cluster Management snap-in after update 2750149 is installed on a Windows Server 2012-based failover cluster. Available from Windows Update or the Microsoft Download Center.|
|Nov. 13, 2012| [2770917](https://support.microsoft.com/help/2770917)|Windows 8 and Windows Server 2012 cumulative update: November 2012|Multiple|Improves clustered server performance and reliability in Hyper-V and Scale-Out File Server scenarios. Improves SMB service and client reliability under certain stress conditions. Install update 2770917 by using Windows Update in order to receive the cumulative update as described in KB 2770917.|
|Nov. 13, 2012| [976424](https://support.microsoft.com/help/976424)|Error code when the kpasswd protocol fails after you perform an authoritative restore: "KDC_ERROR_S_PRINCIPAL_UNKNOWN"|KDCSVC|Install on every domain controller that is running Windows Server 2008 Service Pack 2 or Windows Server 2008 R2 in order to add a Windows Server 2012 failover cluster. Otherwise, Create Cluster may fail with error message: CreateClusterNameCOIfNotExists (6783): Unable to set password on \<ClusterName$> when it tries to set the password for the cluster computer object. This hotfix is included in Windows Server 2008 R2 Service Pack 1.|

## More information

For more information about the recommended hotfixes and updates for Windows Server 2012-based Hyper-V servers and Windows Server 2012 R2-based failover clusters, see the following resources:

- [Hyper-V: Update List for Windows Server 2012](https://social.technet.microsoft.com/wiki/contents/articles/15576.hyper-v-update-list-for-windows-server-2012.aspx)

- [Recommended hotfixes and updates for Windows Server 2012 R2-based failover clusters](https://support.microsoft.com/help/2920151)
