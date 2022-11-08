---
title: Support policy for clustered configurations
description: This article describes the Microsoft support policy for clustered configurations of SQL Server with Windows Server.
ms.date: 11/09/2020
ms.custom: sap:High Availability and Disaster Recovery Features
ms.reviewer: UTTAMKP
ms.prod: sql
---
# The Microsoft support policy for clustered configurations of SQL Server with Windows Server

This article describes the Microsoft support policy for clustered configurations of SQL Server with Windows Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 327518

## Summary

This article describes the Microsoft support policy for SQL Server failover clustering. Microsoft Customer Support Services (CSS) supports SQL Server failover clustering that is based on the failover clustering features of the Windows Failover Cluster Service in the following products:

- Windows Server 2008 Enterprise Edition
- Windows Server 2008 Datacenter Edition
- Windows Server 2008 R2 Enterprise Edition
- Windows Server 2008 R2 Datacenter Edition
- Window Server 2012
- Windows Server 2012 R2
- Windows Server 2016 Standard and Datacenter Editions

> [!NOTE]
> Windows Server 2012 and Windows Server 2012 R2 should review the KB [Microsoft support policy for Windows server failover clusters](/troubleshoot/windows-server/high-availability/microsoft-support-policy-failover-clusters).

The following policies to any supported SQL Server version when it is installed as a SQL Server Failover Cluster Instance.

> [!IMPORTANT]
> The term **server clusters** means computers that run the Microsoft Cluster Service. The Windows Server 2003 family provides the following types of clustering services:

- Server Cluster (Failover Cluster)
- Network Load Balancing
- Compute Cluster Server

Only the Server Cluster solutions can be used together with SQL Server for high availability if a node is lost or if a problem exists with an instance of SQL Server. Network Load Balancing may be used in some cases together with stand-alone read-only SQL Server installations. SQL Server Failover Cluster Instances each require a unique group. This requirement is true on cluster disk resources that use drive letters that are unique to the cluster and to each SQL Server Failover Cluster Instance. Each Failover Cluster Instance of SQL Server must also have at least one unique IP address. Depending on the version that is installed, multiple unique IP addresses may be possible. Additionally, each Failover Cluster Instance must have both virtual server and instance names that are unique to the domain to which the cluster belongs.

Cluster solutions other than Windows Failover Clustering

If you cluster SQL Server with any clustering product other than Microsoft Server Clustering, your primary support contact is the third-party cluster solution provider for any support issues that are related to SQL Server. SQL Server was developed and tested by using Microsoft Server Clustering. Third-party clustering solution providers that support SQL Server installations should be your primary contact for any installation issues, performance issues, or cluster behavior issues. CSS provides commercially reasonable support for third-party cluster installations in same manner that we do for a stand-alone version of SQL Server.

## SQL Server 2008 and SQL Server 2008 R2 information

For SQL Server 2008 and SQL Server 2008 R2 editions, please refer to the following topics in SQL Server Books Online:

- For information about the number of supported nodes, see the following topic: [Editions and supported features of SQL Server 2016](/sql/sql-server/editions-and-components-of-sql-server-2016)

> [!NOTE]
> Although this is a SQL Server 2008 R2 Books Online topic, the same content applies to SQL Server 2008.

- For information about operating systems that are supported for SQL Server Failover Clustering, refer to the "Verify Your Operating System Settings" section in the following topic: [Before Installing Failover Clustering](/sql/sql-server/failover-clusters/install/before-installing-failover-clustering)

  In summary, SQL Server 2008 and SQL Server 2008 R2 editions support up to 8 nodes on Windows Server 2003 and 16 nodes on Windows Server 2008 and later versions-specific details as related to Always On installations.

SQL Server 2012, SQL Server 2014 and SQL Server 2016

Refer to the following MSDN articles for each of the versions:

- [Windows Server Failover Clustering (WSFC) with SQL Server](/previous-versions/sql/sql-server-2012/hh270278(v=sql.110))
- [Failover Policy for Failover Cluster Instances](/previous-versions/sql/sql-server-2012/ff878664(v=sql.110))
- [Windows Server Failover Clustering with SQL Server](/sql/sql-server/failover-clusters/windows/windows-server-failover-clustering-wsfc-with-sql-server)
- [Failover Policy for Failover Cluster Instances](/sql/sql-server/failover-clusters/windows/failover-policy-for-failover-cluster-instances)
- [Windows Server Failover Clustering (WSFC) with SQL Server 2016](/sql/sql-server/failover-clusters/windows/windows-server-failover-clustering-wsfc-with-sql-server?redirectedfrom=MSDN&view=sql-server-ver15&preserve-view=true)
- [SQL Server 2016 Failover Policy for Failover Cluster Instances](/sql/sql-server/failover-clusters/windows/failover-policy-for-failover-cluster-instances)

## Mounted drives

The use of mounted drives is not supported on a cluster that includes a Microsoft SQL Server installation. For more information, see [SQL Server support for mounted volumes](https://support.microsoft.com/help/819546).

## Cluster Shared Volumes (CSV)

Use Cluster Shared Volumes for SQL Server in a Failover Cluster prior to SQL Server 2014 is not supported.

Refer to the following articles about using CSV with SQL Server 2014 or a later version of SQL Server:

- [Deploying SQL Server 2014 with Cluster Shared Volumes](https://techcommunity.microsoft.com/t5/failover-clustering/deploying-sql-server-2014-with-cluster-shared-volumes/ba-p/371962)

- [Cluster Shared Volumes](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee830307(v=ws.10))

- [Use Cluster Shared Volumes in a Failover Cluster](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj612868(v=ws.11))

## Use of Domain Controller Servers within Windows Server Failover Cluster (WSFC)

SQL Server failover cluster instances are not supported on failover cluster instance nodes configured as domain controllers.

## Migrating or Changing SQL Server Failover Cluster Instances to New Domain

SQL Server 2005 and later versions cannot be migrated to new domain. You will need to uninstall and reinstall the failover cluster components. For more information about how to move a Windows Server cluster from one domain to another, see [Move a Windows Server cluster from one domain to another](/troubleshoot/windows-server/high-availability/move-server-cluster-to-another-domain).

**CRITICAL** - Prior to uninstalling, SQL Server must be set to use mixed mode security or new domain accounts added to the SQL Server logins and the DATA folder containing system databases must be renamed so this folder may be swapped back in once reinstalled to reduce down time. No removal of SQL Server support files, SQL Server Native Client, Integration Services or Workstation Components should be done. Unless you are going to rebuild the node in its entirety.

> [!WARNING]
> If during uninstall you get errors, it is likely that the node will need to be rebuilt else will not successfully install again.

## More information

Virtualization support  

For more information about installation of SQL Server failover clusters in a hardware virtualization environment, see [Support policy for Microsoft SQL Server products that are running in a hardware virtualization environment](https://support.microsoft.com/help/956893).

## References

For more information, see the **Failover clustering** topic in SQL Server Books Online or on the MSDN website.

## Applies to

- SQL Server 2008 Developer
- SQL Server 2008 Enterprise
- SQL Server 2008 Standard
- SQL Server 2008 R2 Datacenter
- SQL Server 2008 R2 Developer
- SQL Server 2008 R2 Enterprise
- SQL Server 2012 Analysis Services
- SQL Server 2012 Business Intelligence
- SQL Server 2012 Developer
- SQL Server 2012 Enterprise
- SQL Server 2012 Standard
- SQL Server 2012 Enterprise Core
- SQL Server 2014 Developer
- SQL Server 2014 Enterprise
- SQL Server 2014 Enterprise Core
- SQL Server 2014 Standard
- SQL Server 2016 Developer
- SQL Server 2016 Enterprise
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Standard
