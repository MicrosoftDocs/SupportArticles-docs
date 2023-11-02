---
title: Support policy for clustered configurations
description: This article describes the Microsoft support policy for clustered configurations of SQL Server with Windows Server.
ms.date: 04/27/2023
ms.custom: sap:High Availability and Disaster Recovery Features
author: HaiyingYu
ms.author: haiyingyu
ms.reviewer: UTTAMKP, jaferebe
---

# The Microsoft support policy for clustered configurations of SQL Server with Windows Server

This article describes the Microsoft support policy for clustered configurations of SQL Server with Windows Server.

_Original product version:_ &nbsp; SQL Server 2012 and later versions  
_Original KB number:_ &nbsp; 327518

## Summary

This article describes the Microsoft support policy for SQL Server failover clustering. Microsoft supports SQL Server failover clustering that's based on the failover clustering features of the Windows Failover Cluster Service in the following products:

- Windows Server 2012
- Windows Server 2012 R2
- Windows Server 2016 Standard and Datacenter Editions
- Windows Server 2019 Standard and Datacenter Editions
- Windows Server 2022 Standard and Datacenter Editions

> [!NOTE]
> For Windows Server 2012 and Windows Server 2012 R2, see [Microsoft support policy for Windows server failover clusters](../../../windows-server/high-availability/microsoft-support-policy-failover-clusters.md).

Windows Server provides the following types of clustering services:

- [Failover Clustering](/windows-server/failover-clustering/failover-clustering-overview)
- [Network Load Balancing](/windows-server/networking/technologies/network-load-balancing)

Only the Server Cluster solutions can be used together with SQL Server for high availability if a node is lost or if a problem exists with an instance of SQL Server. Network Load Balancing may be used in some cases together with stand-alone read-only SQL Server installations. SQL Server Failover Cluster Instances each require a unique group. This requirement is true on cluster disk resources that use drive letters that are unique to the cluster and to each SQL Server Failover Cluster Instance. Each Failover Cluster Instance of SQL Server must also have at least one unique IP address. Depending on the version that is installed, multiple unique IP addresses may be possible. Additionally, each Failover Cluster Instance must have both virtual server and instance names that are unique to the domain to which the cluster belongs.

#### Cluster solutions other than Windows Failover Clustering

SQL Server was developed and tested using Microsoft Server Clustering. If you cluster it with any other clustering product, your primary contact for installation, performance, or cluster behavior issues should be the third-party cluster solution provider. Microsoft provides commercially reasonable support for third-party cluster installations as it does for stand-alone SQL Server.

## Information of SQL Server 2012 and later versions

- For the number of supported nodes of Always On failover cluster instances, see:

  - [SQL Server 2012](/previous-versions/sql/sql-server-2012/cc645993(v=sql.110)#high-availability) 
  - [SQL Server 2014](/previous-versions/sql/2014/getting-started/features-supported-by-the-editions-of-sql-server-2014#High_availability)
  - [SQL Server 2016](/sql/sql-server/editions-and-components-of-sql-server-2016#RDBMSHA)
  - [SQL Server 2017](/sql/sql-server/editions-and-components-of-sql-server-2017#RDBMSHA)
  - [SQL Server 2019](/sql/sql-server/editions-and-components-of-sql-server-2019#RDBMSHA)
  - [SQL Server 2022](/sql/sql-server/editions-and-components-of-sql-server-2022#RDBMSHA)
- For information about operating systems that are supported for SQL Server Failover Clustering, see [Verify your operating system before installing Failover Clustering](/sql/sql-server/failover-clusters/install/before-installing-failover-clustering#OS_Support)
- [Windows Server Failover Clustering with SQL Server](/sql/sql-server/failover-clusters/windows/windows-server-failover-clustering-wsfc-with-sql-server)
- [Failover Policy for Failover Cluster Instances](/sql/sql-server/failover-clusters/windows/failover-policy-for-failover-cluster-instances)

## Mounted drives

The use of mounted drives isn't supported on a cluster that includes a Microsoft SQL Server installation. For more information, see [SQL Server support for mounted volumes](/sql/sql-server/failover-clusters/install/before-installing-failover-clustering#Hardware).

## Cluster Shared Volumes (CSV)

Microsoft SQL Server 2012 and earlier versions don't support the use of CSV for SQL Server in a failover cluster.

To use CSV with SQL Server 2014 or later versions, check the following resources:

- [Deploying SQL Server 2014 with Cluster Shared Volumes](https://techcommunity.microsoft.com/t5/failover-clustering/deploying-sql-server-2014-with-cluster-shared-volumes/ba-p/371962)
- [Cluster Shared Volumes](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee830307(v=ws.10))
- [Use Cluster Shared Volumes in a failover cluster](/windows-server/failover-clustering/failover-cluster-csvs)

## Use of Domain Controller Servers within Windows Server Failover Cluster (WSFC)

SQL Server failover cluster instances aren't supported on failover cluster instance nodes configured as domain controllers.

## Migrating or changing SQL Server failover cluster instances to a new domain

SQL Server 2005 and later versions can't be migrated to a new domain. You need to uninstall and reinstall the failover cluster components. For more information about how to move a Windows Server cluster from one domain to another, see [Move a Windows Server cluster from one domain to another](../../../windows-server/high-availability/move-server-cluster-to-another-domain.md).

> [!IMPORTANT]
> Before uninstalling SQL Server, the following steps should be taken:
>
> - Set SQL Server to use mixed mode security or add new domain accounts to the SQL Server logins.
> - Rename the DATA folder containing system databases so that it can be swapped back in after reinstallation to reduce downtime.
> - Don't remove any of the following components: SQL Server support files, SQL Server Native Client, Integration Services, or Workstation Components, unless you are rebuilding the entire node.

> [!WARNING]
> If errors occur during the un-installation process, you may need to rebuild the node to successfully install SQL Server again.

## More information

- [Support policy for Microsoft SQL Server products that are running in a hardware virtualization environment](../../general/support-policy-hardware-virtualization-product.md)
- [Always On Failover Cluster Instances (SQL Server)](/sql/sql-server/failover-clusters/windows/always-on-failover-cluster-instances-sql-server)
