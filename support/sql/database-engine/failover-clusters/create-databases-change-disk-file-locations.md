---
title: Create databases or change disk file locations
description: This article describes how to create databases or change disk file locations on a shared cluster drive on which SQL Server was not originally installed.
ms.date: 10/30/2020
ms.custom: sap:Failover Clusters
ms.reviewer: MICHWE
ms.topic: how-to
---
# Create databases or change disk file locations on a shared cluster drive on which SQL Server was not originally installed

This article describes how to create databases or change disk file locations on a shared cluster drive on which SQL Server was not originally installed.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 295732

## Summary

After you install a SQL Server virtual server instance, you may want to create databases, or move existing data or log files on to a secondary shared cluster disk. To create databases, or move existing data or log files, the other disk that SQL Server is to use must be added as a dependency to the SQL Server resource in the Cluster Administrator.

If you attempt to create a database on another shared cluster drive when the SQL Server resource is not dependent on that disk, you may receive an error similar to:

> Server: Msg 5184, Level 16, State 2, Line 1. Cannot use file '%.*ls' for clustered server. Only formatted files on which the cluster resource of the server has a dependency can be used.  
Server: Msg 1802, Level 16, State 1, Line 1  
CREATE DATABASE failed. Some file names listed could not be created. Check previous errors.

A similar error is displayed when you try to move or add files to an existing database onto a shared cluster drive that is not in the SQL Server group and that also does not have the SQL Server resource dependence.

Additionally, if you try to create a full-text index catalog on a disk on which the SQL Server resource is not dependant, the following error is displayed:

> Server: Msg 7627, Level 16, State 1, Procedure sp_fulltext_database, Line 61 Full-text catalog in directory 'Y:\FTDATA' for clustered server cannot be created. Only directories on a disk in the cluster group of the server can be used.

## More information

To add a disk as a dependency to the SQL Server, the shared cluster disk must reside in the same group in the Cluster Administrator as the SQL Server resources.

To move the shared cluster disk, select the disk you want to move to the SQL Server group, and then right-click that resource. Click **Change Group**. After the disk is in the same group in which the SQL Server resource resides, follow these steps to add it as a SQL Server dependency:

1. Open the Cluster Administrator.
2. Make sure that all the physical disk resources that contain SQL Server databases are in the same group as the SQL Server resource.
3. Right-click the SQL Server resource, and then bring the resource into an Offline state by selecting **Bring Offline**.
4. Right-click the SQL Server resource, and then select **Properties**.
5. Select the **Dependencies** tab.
6. Select **Modify** to add the disk to the dependencies list for that resource.
7. Bring the SQL Server resource back online, and then put the SQL Server files on that shared cluster disk.
