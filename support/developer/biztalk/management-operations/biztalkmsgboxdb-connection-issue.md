---
title: BizTalkMsgBoxDb database connection issues
description: Discusses an issue where you experience blocking, deadlocks, or other connection issues when you try to connect to the BizTalkMsgBoxDb database. This issue may occur in BizTalk Server.
ms.date: 05/08/2023
ms.reviewer: v-jayaramanp
ms.custom: sap:Management and Operations
---

# Blocking, deadlock conditions, or other SQL Server issues when you connect to the BizTalkMsgBoxDb database in BizTalk Server

This article provides information about resolving SQL Server issues when you connect to the `BizTalkMsgBoxDb` database in Microsoft BizTalk Server.

_Original product version:_ &nbsp; BizTalk Server  
_Original KB number:_ &nbsp; 917845

## Symptoms

In BizTalk Server, you experience blocking, deadlock conditions, or other Microsoft SQL Server issues when you try to connect to the `BizTalkMsgBoxDb` database.

## Cause

This issue may occur if one or more of the following conditions are true:

- The **Auto Create Statistics** option is enabled on the `BizTalkMsgBoxDb` database.
- The **Auto Update Statistics** option is enabled on the `BizTalkMsgBoxDb` database.
- The **max degree of parallelism** option is set to a value other than 1 for the `BizTalkMsgBoxDb` database or the SQL instance hosting this database.
- You defragment or rebuild an index in the `BizTalkMsgBoxDb` database when BizTalk Server is processing data.

## Resolution 1: Disable the Auto Create Statistics option and the Auto Update Statistics option

To resolve this issue, disable the **Auto Create Statistics** and the **Auto Update Statistics** options on the `BizTalkMsgBoxDb` database in SQL Server.

## Resolution 2: Set the max degree of parallelism option to 1

To resolve this issue, set the **max degree of parallelism** option to **1** in the `BizTalkMsgBoxDb` database setting or the SQL instance hosting this database.

## Resolution 3: Don't rebuild an index when BizTalk Server is processing data

To resolve this issue, don't run the `bts_RebuildIndexes` stored procedure or any SQL command that rebuilds an index in a BizTalk Server database when BizTalk Server is processing data.

> [!NOTE]
> Defragmenting an index in a BizTalk Server database isn't supported.

## The bts_RebuildIndexes stored procedure

The only supported method to rebuild an index in the `BizTalkMsgBoxDb` database is to run the `bts_RebuildIndexes` stored procedure. On BizTalk Server 2006 and later versions, you can run the `dtasp_RebuildIndexes` stored procedure to rebuild indexes in the `BizTalkDTADb` database.

Most of the BizTalk indexes are GUID-based. Many tests have shown that as long as the tables are not scanned, GUID-based indexes can perform better than identity-based indexes for BizTalk-specific workloads. This may cause fragmentation. However, because data flows in and out of the tables at a steady pace, fragmentation may not cause any issues. If lots of data is expected to build up in the `BizTalkMsgBox` database, you can periodically rebuild indexes during scheduled downtime. The same guidelines apply to the tracking database.

You can use the `DBCC DBREINDEX` SQL command to rebuild an index in the other BizTalk Server databases. For an example of how to use the `DBCC DBREINDEX` SQL command, right-click the `bts_RebuildIndexes` stored procedure, and then click **Properties**.

Microsoft only supports rebuilding database indexes during BizTalk Server downtime. You should stop all host instances and SQL Server Agent before you rebuild an index. When you run the `bts_RebuildIndexes` stored procedure in BizTalk Server 2006 and later versions, you may receive one of the following error messages:

- Error message 1

    > Msg 5239, Level 16, State 1, Procedure bts_RebuildIndexes, Line 4 Unable to process object ID 674101442 (object 'TrackingData')  
    > This database consistency checker (DBCC) command does not support this kind of object.

- Error message 2

    > Msg 5239, Level 16, State 1, Procedure bts_RebuildIndexes, Line 4 Unable to process object ID 722101613 (object 'TrackingData') because this DBCC command does not support objects of this type.

This problem occurs because the `TrackingData` object is a view in BizTalk Server 2006 and later versions. To resolve this problem, do the following and then execute the `bts_RebuildIndexes` stored procedure:

1. Comment out the following line in the `bts_RebuildIndexes` stored procedure.

    ```sql
    DBCC DBREINDEX ('[dbo].[TrackingData]') WITH NO_INFOMSGS
    ```

2. Add the following lines to the `bts_RebuildIndexes` stored procedure.

    ```sql
    DBCC DBREINDEX ('[dbo].[TrackingData_0_0]') WITH NO_INFOMSGS
    DBCC DBREINDEX ('[dbo].[TrackingData_0_1]') WITH NO_INFOMSGS
    DBCC DBREINDEX ('[dbo].[TrackingData_0_2]') WITH NO_INFOMSGS
    DBCC DBREINDEX ('[dbo].[TrackingData_0_3]') WITH NO_INFOMSGS
    DBCC DBREINDEX ('[dbo].[TrackingData_1_0]') WITH NO_INFOMSGS
    DBCC DBREINDEX ('[dbo].[TrackingData_1_1]') WITH NO_INFOMSGS
    DBCC DBREINDEX ('[dbo].[TrackingData_1_2]') WITH NO_INFOMSGS
    DBCC DBREINDEX ('[dbo].[TrackingData_1_3]') WITH NO_INFOMSGS
    ```
