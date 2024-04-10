---
title: Updates for Windows Server 2012 R2-based failover clusters
description: Describes the hotfixes and updates that are currently available for Windows Server 2012 R2-based failover clusters.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: cpuckett, kaushika
ms.custom: sap:Clustering and High Availability\Root cause of an unexpected failover, csstroubleshoot
---
# Recommended hotfixes and updates for Windows Server 2012 R2-based failover clusters

This article describes the hotfixes that are currently available for Windows Server 2012 R2-based failover clusters and are highly recommended to be installed on each server of a failover cluster.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2920151

## Summary

Failover Cluster Management enables multiple servers to provide a high availability of server roles. Failover Cluster Management is frequently used for file services, virtual machines, database applications, and mail applications.

> [!IMPORTANT]
> The process for installing service packs and hotfixes for Windows Server 2012 R2 differs from the process for earlier versions of Windows Server. In Windows Server 2012 R2, you can use the Cluster-Aware Updating (CAU) feature. CAU automates the software-updating process on clustered servers and maintains availability. For more information, see [Cluster-Aware Updating Overview](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831694(v=ws.11)).

The following Microsoft Knowledge Base articles describe the currently available fixes that are highly recommended to be installed on all failover clusters. Most of the updates apply to computers that are running Windows Server 2012 R2. Some updates, such as [KB 976424](https://support.microsoft.com/help/976424), may be required on computers that are running Windows Server 2008 R2 or Windows Server 2008 if those operating systems are present in the environment.

These updates are considered to be important installations to ensure the highest level of reliability.

## Any Windows Server 2012 R2 cluster

> [!NOTE]
> You may substitute a newer monthly rollup in place of KB 4282815. The remainder of the updates in this list are still needed as some components in those updates released before September 2016 and are not included in the newer monthly rollup.

|Date that update was added|Related Knowledge Base article|Title|Component|Why we recommend this update|
|---|---|---|---|---|
|June 14, 2018| [4284815](https://support.microsoft.com/help/4284815)|June 12, 2018-KB4284815 (Monthly Rollup)|Multiple|This security update rollup includes improvements and fixes that were released after September 2016. Available from Windows Update or for individual download from Microsoft Update Catalog and Microsoft Download Center. To apply this update, you must first install update [2919355](https://support.microsoft.com/help/2919355) on Windows Server 2012 R2.|
|June 21, 2017| [3137728](https://support.microsoft.com/help/3137728)|VSS restore fails when you use ResyncLuns VSS API in Windows Server 2012 R2-based failover cluster|Vssvc|Includes the fix from [3123538](https://support.microsoft.com/help/3123538). Available from Windows Update or for individual download from Microsoft Update Catalog and Microsoft Download Center. To apply this update, you must first install update [2919355](https://support.microsoft.com/help/2919355) on Windows Server 2012 R2.|
|August 22, 2016| [3179574](https://support.microsoft.com/help/3179574)|August 2016 update rollup for Windows RT 8.1, Windows 8.1, and Windows Server 2012 R2|Multiple|This rollup includes a fix that addresses an issue with cluster services that may stop working when network loss logging occurs when a network connection is down and virtual machines are configured with one possible owner. Available from Windows Update or for individual download from Microsoft Update Catalog. To apply this update, you must first install the update [2919355](https://support.microsoft.com/help/2919355) on Windows Server 2012 R2.|
|July 21, 2016| [3172614](https://support.microsoft.com/help/3172614)|July 2016 update rollup for Windows RT 8.1, Windows 8.1, and Windows Server 2012 R2|Multiple|This rollup includes improvements and fixes from June 2016 update rollup KB 3161606 and May 2016 update rollup KB 3156418 including an update ([3153887](https://support.microsoft.com/help/3153887)) that increases the default values of **SameSubnetThreshold**, CrossSubnetThreshold, and RouteHistoryLength to be more tolerant of brief transient network issues. Available on Windows update or for individual download from Microsoft Update Catalog. To apply this update, you must first install the update [2919355](https://support.microsoft.com/help/2919355) on Windows Server 2012 R2.|
|October 28, 2015| [3091057](https://support.microsoft.com/help/3091057)|Cluster validation fails in the **Validate Simultaneous Failover** test in a Windows Server 2012 R2-based failover cluster|Cprepsrv|Changes some timing of the **Validate Simultaneous failover** test to more accurately verify the storage compatibility with the failover cluster. Available for individual download.|
|December 18, 2014| [3013769](https://support.microsoft.com/help/3013769)|December 2014 update rollup for Windows RT 8.1, Windows 8.1, and Windows Server 2012 R2|Multiple|An update rollup package that resolves issues and includes performance and reliability improvements. Available from Windows Update and for individual download from Download Center. To apply this update, you must first install the update [2919355](https://support.microsoft.com/help/2919355) on Windows Server 2012 R2.|
|November 18, 2014| [3000850](https://support.microsoft.com/help/3000850)|November 2014 update rollup for Windows RT 8.1, Windows 8.1, and Windows Server 2012 R2|Multiple|A cumulative update that includes the security updates and nonsecurity updates including Failover Clustering updates that were released between April 2014 and November 2014. Available from Windows Update and for individual download from Download Center. To apply this update, you must first install the update [2919355](https://support.microsoft.com/help/2919355) on Windows Server 2012 R2.|
|April 8, 2014| [2919355](https://support.microsoft.com/help/2919355)|Windows RT 8.1, Windows 8.1, and Windows Server 2012 R2 Update April, 2014|Multiple|A cumulative update that includes the security updates and nonsecurity updates including Failover Clustering updates that were released before March 2014. Available from Windows Update and for individual download from Download Center.|
|December 18, 2013| [976424](https://support.microsoft.com/help/976424)|Error code when the kpasswd protocol fails after you perform an authoritative restore: "KDC_ERROR_S_PRINCIPAL_UNKNOWN"|KDCSVC|Enables you to add a Windows Server 2012 failover cluster. Install on every domain controller that is running Windows Server 2008 Service Pack 2 (SP2) or Windows Server 2008 R2. Otherwise, Create Cluster may fail when you try to set the password for the cluster computer object, and you receive a **CreateClusterNameCOIfNotExists (6783): Unable to set password on \<ClusterName$>** error message. This hotfix is included in Windows Server 2008 R2 Service Pack 1 (SP1).|

## Windows Server 2012 R2 Hyper-V clusters

In addition to the updates listed above, the following Microsoft Knowledge Base articles describe currently available fixes that are highly recommended to be installed on Hyper-V failover clusters. These updates target reliability improvements when backing up virtual machines on Hyper-V failover clusters.

|Date that update was added|Related Knowledge Base article|Title|Component|Why we recommend this update|
|---|---|---|---|---|
|June 21, 2017| [3145384](https://support.microsoft.com/help/3145384)|MinDiffAreaFileSize registry value limit is increased from 3 GB to 50 GB in Windows 8.1 or Windows Server 2012 R2|Volsnap.sys| Describes an update that increases the [MinDiffAreaFileSize](/windows/win32/backup/registry-keys-for-backup-and-restore#mindiffareafilesize) registry key value limit from 3 GB to 50 GB in Windows 8.1 and Windows Server 2012 R2. Before you install this update, see the "Prerequisites" section. Includes the fix from [3060678](https://support.microsoft.com/help/3060678). Available from Windows Update or for individual download from Microsoft Update Catalog. To apply this update, you must first install the update [2919355](https://support.microsoft.com/help/2919355) on Windows Server 2012 R2. |
|September 15, 2015| [3063283](https://support.microsoft.com/help/3063283)|Update to improve the backup of Hyper-V Integrated components in Hyper-V Server 2012 R2|Hyper-V Integration Services|Increases the time-out to detect the volumes to shadow copy when the Guest OS has multiple volumes. Available for individual download. To apply this update, you must first install the update [2919355](https://support.microsoft.com/help/2919355) on Windows Server 2012 R2.|

## References

For more information about the recommended hotfixes and updates for Windows Server 2012-based Hyper-V servers and Windows Server 2012-based Failover Clusters, see:

- [Hyper-V: Update List for Windows Server 2012](https://social.technet.microsoft.com/wiki/contents/articles/15576.hyper-v-update-list-for-windows-server-2012.aspx)

- [2784261](https://support.microsoft.com/help/2784261)
