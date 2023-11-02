---
title: Performance decreases in Team Foundation Server
description: This article provides a workaround for the decrease performance in Team Foundation Server 2013 Update 2 problem after you upgrade to SQL Server 2014. This issue affects Work Item Tracking and also affects throughput and other processes if you have a large number of project collections.
ms.date: 08/14/2020
ms.custom: sap:Installation, Migration, and Move
ms.reviewer: andreas, georgea
ms.service: azure-devops-server
---
# Performance decreases in Team Foundation Server 2013 Update 2 after you upgrade to SQL Server 2014

This article helps you work around the decrease performance in Team Foundation Server 2013 Update 2 problem after you upgrade to SQL Server 2014.

_Original product version:_ &nbsp; Team Foundation Server 2013  
_Original KB number:_ &nbsp; 2953452

## Symptoms

After you upgrade to Microsoft SQL Server 2014, you notice a decrease in performance in Microsoft Team Foundation Server 2013 Update 2.

For example, you notice that Work Item Tracking slows down. When this occurs, it takes longer to open and change work items if you have many fields that are set to **syncnamechanges=true**.

Additionally, if you have many Team Project collections in the affected Team Foundation Server instance, you notice the following issues:

- Throughput drops significantly, as measured by the following performance counters:
  - Batch requests/sec (DT)
  - Team Foundation Server Services/Current Reqs/sec (AT)
  - Web Services/Total Method Requests/sec (AT)
- The following DT performance counters increase on average:
  - SQL Compilations/sec
  - SQL Re-compilations/sec
  - %Processor Time

## Cause

These issues occur because the hardware requirements for SQL Server 2014 are greater than those for earlier versions of SQL Server.

The Work Item Tracking performance issue occurs because several views that are used by Work Item Tracking contain one or more joins to the Constants table for each field that includes this attribute. The new cardinality estimator in SQL Server 2014 sometimes determines incorrectly that these joins will return more than one row. When there are many of these joins, SQL Server can miscalculate the total number of rows that are returned by the views as a large number. Therefore, the program determines incorrectly that it must spend lots of time to optimize the query plans that involve the views.

## Workaround

To work around the overall performance issue, use the following methods:

- If you have a large configuration (500 or more users), increase the RAM on the computer that is hosting SQL Server. A good standard to follow is 0.4 gigabytes (GB) per collection database.

    If the performance issues persist, try the next method.

- Perform the following tasks:
  - Make sure that the SQL minimum and maximum memory settings are set explicitly to leave at least 2 GB of free physical memory for the system.
  - Enable locked pages for the account that is running the SQL service.
  - Enable SQL trace flag 8032.
  
To specifically work around the Work Item Tracking performance issue, use the following method:

- If you see a significant decrease in performance when you open or edit work items after you upgrade to SQL Server 2014, change the **Compatibility Level** setting of your databases to **110**. This causes SQL Server to use the earlier cardinality estimator tool. This tool more accurately estimates the number of rows that are returned by the joins.

## More information

- For a description of trace flag 8032, see: [DBCC TRACEON - Trace Flags (Transact-SQL)](https://technet.microsoft.com/library/ms188396.aspx)

    > [!NOTE]
    > This information relates to SQL Server 2012 but also applies to SQL Server 2014.

- For more information about the Work Item Tracking `syncnamechanges` attribute, see:
[Enable Synchronization of Person-Name Custom Fields](/previous-versions/visualstudio/visual-studio-2010/dd286562(v=vs.100))

- For more information about how to view or change the compatibility Level of a database, see:
[View or Change the Compatibility Level of a Database](/sql/relational-databases/databases/view-or-change-the-compatibility-level-of-a-database)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
