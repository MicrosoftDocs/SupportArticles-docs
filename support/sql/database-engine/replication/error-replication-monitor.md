---
title: Error message in SQL Server 2008 Replication Monitor  
description: This article provides a workaround for a problem that occurs when you try to view a publication in Replication Monitor.
ms.date: 07/22/2020
ms.custom: sap:Replication, change tracking, change data capture
ms.reviewer: cmathews
---
# Error message in SQL Server 2008 Replication Monitor: An error occurred while retrieving the publication data

This article helps you work around the problem that occurs when you try to view a publication in Replication Monitor.

_Original product version:_ &nbsp; SQL Server 2008  
_Original KB number:_ &nbsp; 2650553

## Symptoms

Consider the following scenario:

- You start Microsoft SQL Server 2008 Management Studio.
- You start Replication Monitor.
- You expand a **publisher** and then select a **publication**.

In this scenario, you may receive an error message that resembles the following:

> An error occurred while retrieving the publication data. Unable to case object of type 'System.DBNull' to type 'Microsoft.sqlserver.Replication.PublisherMonitor.

## Cause

This issue occurs if you select the **publication** before the list of publishers is populated.

## Workaround

To work around this issue, wait until the list of publishers is fully populated before you click a publication.

## More information

Typically, the issue that is mentioned in the [Symptoms](#symptoms) section occurs when many servers are listed as publishers. The publisher list may also populate slowly if the servers are busy or are on slow network connections.

## References

For more information about Replication Monitor, see: [Overview of the Replication Monitor Interface](/sql/relational-databases/replication/monitor/overview-of-the-replication-monitor-interface)

## Applies to

- SQL Server 2008 Developer
- SQL Server 2008 Enterprise
- SQL Server 2008 R2 Datacenter
- SQL Server 2008 R2 Developer
- SQL Server 2008 R2 Enterprise
- SQL Server 2008 R2 Express
- SQL Server 2008 R2 Standard
- SQL Server 2008 R2 Standard Edition for Small Business
- SQL Server 2008 R2 Web
- SQL Server 2008 R2 Workgroup
- SQL Server 2008 Standard
- SQL Server 2008 Web  
