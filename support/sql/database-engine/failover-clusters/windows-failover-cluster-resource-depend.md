---
title: Windows Failover cluster resource dependencies
description: This article describes the default resource dependencies in SQL Server and the restrictions on these dependencies.
ms.date: 07/22/2020
ms.custom: sap:High Availability and Disaster Recovery features
ms.reviewer: ramakoni
---

# Microsoft Windows Failover cluster resource dependencies in SQL Server

This article introduces the default resource dependencies in SQL Server and the restrictions on these dependencies.

_Original product version:_ &nbsp; SQL Server 2017, SQL Server 2016, SQL Server 2014, SQL Server 2012, SQL Server 2008  
_Original KB number:_ &nbsp; 835185

## Summary

When you install SQL Server on a cluster as a SQL Server failover cluster instance, a specific set of SQL Server resources that have dependencies on other resources in the cluster group are created.

> [!IMPORTANT]
> Don't change the default dependency tree except for the changes that are listed in this article or the changes that are listed in the following article in the Microsoft Knowledge Base:
[SQL Server support for mounted folders](https://support.microsoft.com/help/819546)

## Example 1 - Default SQL Server failover cluster instance dependencies

:::image type="content" source="media/windows-failover-cluster-resource-depend/default-sql-server-dependencies.png" alt-text="Diagram of the default SQL Server failover cluster instance dependency tree.":::

In this diagram, notice the following:

- Cluster Disk 1 has no required dependencies.
- IP Address: `xxx.xxx.xxx.xxx` has no required dependencies.
- IP Address: `xxxx:xxxx:xx:xxxx:xxxx:xxxx:xxxx:xxxx` has no required dependencies.
- Name: SOFTY dependencies are IP Address: `xxxx:xxxx:xx:xxxx:xxxx:xxxx:xxxx:xxxx` and IP Address: `xxx.xxx.xxx.xxx`.
- SQL Network Name (SOFTY) required dependencies are IP Address.
- SQL Server dependencies are Cluster Disk 1 and Name: *SOFTY*.
- SQL Server has no required dependencies.
- SQL Server Agent dependencies are SQL Server.
- SQL Server Agent has no required dependencies.

## Example 2 - SQL Server 2008 Analysis Services failover instance dependencies

:::image type="content" source="media/windows-failover-cluster-resource-depend/sql-server-2008-analysis-services-dependencies.png" alt-text="Diagram of SQL Server 2008 Analysis Services failover instance dependency tree.":::  

In this diagram, notice the following:

- Analysis Services (LOCALINSTANCE) dependencies are Cluster Disk 2 and Name: *STANDALONE2008R*.
- Analysis Services (LOCALINSTANCE) has no required dependencies.
- Cluster Disk 2 has no required dependencies.
- IP Address: `xxx.xxx.xxx.xxx` has no required dependencies.
- IP Address: `xxxx:xxxx:xx:xxxx:xxxx:xxxx:xxxx:xxxx` has no required dependencies.
- Name: STANDALONE2008R dependencies are IP Address: `xxxx:xxxx:xx:xxxx:xxxx:xxxx:xxxx:xxxx` and IP Address: `xxx.xxx.xxx.xxx`.
- SQL Network Name (STANDALONE2008R) required dependencies are IP Address.
- SQL Server (LOCALINSTANCE) dependencies are Cluster Disk 2 and Name: *STANDALONE2008R*.
- SQL Server (LOCALINSTANCE) has no required dependencies.
- SQL Server Agent (LOCALINSTANCE) dependencies are SQL Server (LOCALINSTANCE).
- SQL Server Agent (LOCALINSTANCE) has no required dependencies.

## Example 3 - SQL Server 2008 failover instance dependencies with a mount point

:::image type="content" source="media/windows-failover-cluster-resource-depend/sql-server-2008-dependencies-with-mount-point.png" alt-text="Diagram of SQL Server 2008 failover instance dependency tree with a mount point.":::

In this diagram, notice the following:

- Cluster Disk 1 has no required dependencies.
- Cluster Disk 4, Mountpoint dependencies are Cluster Disk 1.
- Cluster Disk 4, Mountpoint has no required dependencies.
- IP Address: `xxx:xxxx:c0:xxxx:xxxx:c597:8cb0:49f2` has no required dependencies.
- Name: SOFTY dependencies are IP Address: `xxx:xxxx:c0:xxxx:xxxx:c597:8cb0:49f2` and IP Address: `xxx.xxx.xxx.88`.
- SQL Network Name (SOFTY) required dependencies are IP Address.
- SQL Server dependencies are Name: SOFTY, Cluster Disk 4, Mountpoint, and Cluster Disk 1.
- SQL Server has no required dependencies.

> [!NOTE]
> The double dependency on the mount point is to make sure that SQL Server can't start and load databases without the physical disks being available. This helps prevent database corruption.

The default dependency tree for SQL Server has the following implications:

- The SQL Server Agent resource depends on the SQL Server resource.
- The SQL Server resource depends on the SQL network name resource, on the physical disk resources and on mounted folders that contain the database files.
- The SQL network name resource depends on the SQL IP address resource.
- The SQL IP address resource and the physical disk resources don't depend on any resources.

## More information

For information about how to add dependencies to a SQL Server resource, see:

- [How to add dependencies in SQL Server 2008](/previous-versions/sql/sql-server-2008/ms177447(v=sql.100))
- [How to add dependencies in SQL Server 2008 R2](/previous-versions/sql/sql-server-2008-r2/ms177447(v=sql.105))
- [How to add dependencies in SQL Server 2012](/previous-versions/sql/sql-server-2012/ms177447(v=sql.110))
- [How to add dependencies to a SQL Server 2016 or a later version of SQL Server](/sql/sql-server/failover-clusters/windows/add-dependencies-to-a-sql-server-resource)

### Limitations and restrictions

If you add any other resources to the SQL Server group, those resources must always have their own unique SQL network name resources and their own SQL IP address resources. Don't use the existing SQL network name resources and SQL IP address resources for anything other than SQL Server. If SQL Server resources are shared with other resources or are set up incorrectly, you may experience the following problems:

- Outages that are not expected may occur.
- Database corruption may occur.
- Service pack installations may not be successful.
- The SQL Server Setup program may not be successful. If this occurs, you can't install additional instances of SQL Server or perform routine maintenance.
- SQL Server may not come online.
- Disks may not be available for SQL Server use.

### Additional considerations

- FTP with SQL Server replication: For instances of SQL Server that use FTP with SQL Server replication, your FTP service must use one of the same physical disks that the installation of SQL Server that is set up to use the FTP service uses.
- SQL Server resource dependencies: If you add a resource to a SQL Server group, and if you have a dependency on the SQL Server resource to make sure that SQL Server is available, we recommend that you add a dependency on the SQL Server Agent resource instead of adding a dependency on the SQL Server resource. To make sure that the computer that's running SQL Server remains highly available, configure the SQL Server Agent resource so that it doesn't affect the SQL Server group if the SQL Server Agent resource fails.
- File shares and printer resources: An exception is the file share that is used by the SQL Server FILESTREAM feature. A printer resource shouldn't be in your SQL Server group. File Share or Printer resources require their own Network Name and IP resource on a Windows Server 2003 failover cluster. File shares and printer resources also require their own Network Name and IP resource for a Client Access Point on Windows Server 2008 and later versions. For a failover cluster instance on Windows Server 2008 or a later version, use the Create a Shared Folder Wizard to specify a unique name and other settings for the shared folder.
- Performance: Decrease in performance and loss of service to the computer that is running SQL Server may occur when the following conditions are true:
  - A File Share cluster resource that doesn't use the FILESTREAM feature is installed on the same physical disk resource on which SQL Server is installed.
  - A Printer cluster resource is installed on the same physical disk resource on which SQL Server is installed.

### MSDTC considerations

Reading [MSDTC Recommendations on SQL Failover Cluster](/archive/blogs/alwaysonpro/msdtc-recommendations-on-sql-failover-cluster) should be the starting point for any MSDTC dependency discussions, to determine whether it's required or not.

That MSDTC Recommendations FAQ (Frequently Asked Questions) addresses common questions and best practices with MSDTC (Microsoft Distributed Transaction Coordinator) when used with SQL Server Failover Clustered instances to include current recommendations and best practices.  

When you add an MSDTC resource to a SQL Server Group, you can use one of the SQL Server Disks or another disk. However, for the resource to work correctly and consistently and to be able to use the `Test-DTC` PowerShell cmdlet, you must use the SQL Server's network name and IP address and rename the MSDTC resource to your SQL Server's virtual server name.  

Starting with Windows Server 2012 and later when creating a New Distributed Transaction Coordinator using the Cluster Manager you have no choice in the resources name, it will always be New Distributed Transaction Coordinator, nor do you have the option to rename the resource in Cluster Manager.

PowerShell to the rescue, this command allows you to rename the New Distributed Transaction Coordinator to the name of your choosing, in this example the name is changed to MSDTC.  

```powershell
Get-ClusterResource "New Distributed Transaction Coordinator" | %{ $_.Name = MSDTC }
```

## Applies to

- SQL Server 2008 Standard
- SQL Server 2008 Enterprise
- SQL Server 2008 Developer
- SQL Server 2008 R2 Datacenter
- SQL Server 2008 R2 Developer
- SQL Server 2008 R2 Enterprise
- SQL Server 2008 R2 Standard
- SQL Server 2008 R2 Standard Edition for Small Business
- SQL Server 2008 R2 Express with Advanced Services
- SQL Server 2008 R2 Workgroup
- SQL Server 2012 Developer
- SQL Server 2012 Enterprise
- SQL Server 2012 Standard
- SQL Server 2012 Enterprise Core
- SQL Server 2014 Enterprise
- SQL Server 2014 Enterprise Core
- SQL Server 2014 Standard
- SQL Server 2014 Business Intelligence
- SQL Server 2016 Enterprise Core
- SQL Server 2016 Enterprise
- SQL Server 2016 Developer
- SQL Server 2016 Standard
- SQL Server 2017 Windows (all editions)
