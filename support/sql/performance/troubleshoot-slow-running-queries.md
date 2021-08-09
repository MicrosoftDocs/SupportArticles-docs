---
title: Troubleshoot slow-running queries
description: This article describes how to handle a performance issue that applications may experience in conjunction with Microsoft SQL Server.
ms.date: 11/18/2020
ms.prod-support-area-path: Performance
ms.topic: how-to
ms.prod: sql
---
# Troubleshoot slow-running queries on SQL Server

## Introduction

This article describes how to handle a performance issue that applications may experience in conjunction with SQL Server: slow performance of a specific query or group of queries. If you are troubleshooting a performance issue, but you have not isolated the problem to a specific query or small group of queries that perform slower than expected, see [Monitor and Tune for Performance](/sql/relational-databases/performance/monitor-and-tune-for-performance) before you continue.

This article assumes that you have used the article 298475 to narrow down the scope of the problem, and that you have captured a SQL Profiler trace with the specific events and data columns that are detailed in the article 224587.

Tuning database queries can be a multi-faceted endeavor. The following sections discuss common items to examine when you are investigating query performance.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 243589

## Verify the Existence of the Correct Indexes

One of the first checks to perform when you are experiencing slow query execution times is an index analysis. If you are investigating a single query, you can use the Analyze Query in Database Engine Tuning Advisor option in SQL Query Analyzer; if you have a SQL Profiler trace of a large workload, you can use the Database Engine Tuning Advisor. Both methods use the SQL Server query optimizer to determine which indexes would be helpful for the specified queries. This is an efficient method for determining whether the correct indexes exist in your database.

For information about how to use the Database Engine Tuning Advisor, see the "Start and Use the Database Engine Tuning Advisor" topic in SQL Server Books Online.

If you have upgraded your application from a previous version of SQL Server, different indexes may be more efficient in new SQL Server build because of optimizer and storage engine changes. The Database Engine Tuning Advisor helps you to determine if a change in indexing strategy would improve performance.

## Remove All Query, Table, and Join Hints

Hints override query optimization and can prevent the query optimizer from choosing the fastest execution plan. Because of optimizer changes, hints that improved performance in earlier versions of SQL Server may have no effect or may adversely affect performance in later SQL Server builds. Additionally, join hints can cause performance degradation based on the following reasons:

- Join hints prevent an ad hoc query from being eligible for auto-parameterization and caching of the query plan.

- When you use a join hint, it implies that you want to force the join order for all tables in the query, even if those joins do not explicitly use a hint.

If the query that you are analyzing includes any hints, remove them, and then reevaluate the performance.

## Examine the Execution Plan

After you confirm that the correct indexes exist, and that no hints are restricting the optimizer's ability to generate an efficient plan, you can examine the query execution plan. You can use any of the following methods to view the execution plan for a query:

- SQL Profiler

  If you captured the MISC: Execution Plan event in SQL Profiler, it would occur immediately before the StmtCompleted event for the query for the system process ID (SPID).

- SQL Query Analyzer: Graphical Show plan

  With the query selected in the query window, click the Query menu, and then click Display Estimated Execution Plan.

  > [!NOTE]
  > If the stored procedure or batch creates and references temporary tables, you must use a SET STATISTICS PROFILE ON statement or explicitly create the temporary tables before you display the execution plan.

- `SHOWPLAN_ALL` and `SHOWPLAN_TEXT`

  To receive a text version of the estimated execution plan, you can use the SET SHOWPLAN_ALL and SET `SHOWPLAN_TEXT` options. See the **SET SHOWPLAN_ALL (T-SQL)** and **SET SHOWPLAN_TEXT (T-SQL)** topics in SQL Server Books Online for more details.

   > [!NOTE]
   > If the stored procedure or batch creates and references temporary tables, you must use the **SET STATISTICS PROFILE ON** option or explicitly create the temporary tables before displaying the execution plan.

- STATISTICS PROFILE

  When you are displaying the estimated execution plan, either graphically or by using SHOWPLAN, the query is not executed. Therefore, if you create temporary tables in a batch or a stored procedure, you cannot display the estimated execution plans because the temporary tables will not exist. STATISTICS PROFILE executes the query first, and then displays the actual execution plan. See the **SET STATISTICS PROFILE (T-SQL)** topic in SQL Server Books Online for more details. When it is running in SQL Query Analyzer, this appears in graphical format on the Execution Plan tab in the results pane.

For more information about how to display the estimated execution plan, see the **Display the Estimated Execution Plan** topic in SQL Server Books Online.

## Examine the Showplan Output

Showplan output provides much information about the execution plan that SQL Server is using for a particular query. The following are some basic aspects of the execution plan that you can view to determine whether you are using the best plan:

- Correct Index Usage

  The showplan output displays each table that is involved in the query and the access path that is used to obtain data from it. With graphical showplan, move the pointer over a table to see the details for each table. If an index is in use, you see Index Seek; if an index is not in use, you see either Table Scan for a heap or Clustered Index Scan for a table that has a clustered index. Clustered Index Scan indicates that the table is being scanned through the clustered index, not that the clustered index is being used to directly access individual rows.

  If you determine that a useful index exists and it is not being used for the query, you can try forcing the index by using an index hint. See the **FROM (T-SQL)** topic in SQL Server Books Online for more details about index hints.

- Correct Join Order

  The showplan output indicates in what order tables that are involved in a query are being joined. For nested loop joins, the upper table that is listed is the outer table and it should be the smaller of the two tables. For hash joins, the upper table becomes the build input and should also be the smaller of the two tables. However, note that the order is less critical because the query processor can reverse build and probe inputs at run time if it finds that the optimizer made a wrong decision. You can determine which table returns fewer rows by checking the Row Count estimates in the showplan output.

  If you determine that the query may benefit from a different join order, you can try forcing the join order with a join hint. See the **FROM (T-SQL)** topic in SQL Server Books Online for more details about join hints.

  > [!NOTE]
  > Using a join hint in a large query implicitly forces the join order for the other tables in the query as if `FORCEPLAN` was set.

- Correct Join Type

  SQL Server uses nested loop, hash, and merge joins. If a slow-performing query is using one join technique over another, you can try forcing a different join type. For example, if a query is using a hash join, you can force a nested loops join by using the LOOP join hint. See the "FROM (T-SQL)" topic in SQL Server Books Online for more details on join hints.

  Using a join hint in a large query implicitly forces the join type for the other tables in the query as if `FORCEPLAN` was set.

- Parallel Execution

  If you are using a multiprocessor computer, you can also investigate whether a parallel plan is in use. If parallelism is in use, you see a PARALLELISM (Gather Streams) event. If a particular query is slow when it is using a parallel plan, you can try forcing a non-parallel plan by using the OPTION (MAXDOP 1) hint. See the "SELECT (T-SQL)" topic in SQL Server Books Online for more details.

For more information about how to use Showplan execution plan output, see the following topics in SQL Server Books Online:

- Save an Execution Plan in XML format

- Compare and Analyze Execution Plans

- Showplan Logical and Physical Operators Reference

> [!CAUTION]
> Because the query optimizer typically selects the best execution plan for a query, Microsoft recommends that you use join hints, query hints, and table hints only as a last resort, and only if you are an experienced database administrators.
