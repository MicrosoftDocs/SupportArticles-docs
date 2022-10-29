---
title: Troubleshoot slow queries due to query optimizer timeout
description: Provides an explanation on what optimizer timeout is and how it can affect query performance in SQL Server.
ms.date: 10/29/2022
ms.custom: sap:Performance
ms.topic: troubleshooting
ms.prod: sql
author: PijoCoder 
ms.author: jopilov
---

# Troubleshoot slow queries affected by query optimizer timeout

_Applies to:_ &nbsp; SQL Server

This article provides an explanation on what optimizer timeout is and how it can affect query performance in SQL Server.

## Define an Optimizer timeout


SQL Server uses a cost-based query optimizer. Therefore, it selects a query plan with the lowest cost after it has built and examined multiple query plans. One of the objectives of the SQL Server query optimizer (QO) is to spend a "reasonable time" in query optimization as compared to query execution. Therefore, QO has a built-in threshold of tasks to consider before it stops the optimization process. If this threshold is reached before QO has considered most, if not all, possible plans then it has reached the Optimizer TimeOut limit. An event is reported in the query plan as Time Out under "Reason For Early Termination of Statement Optimization." It's important to understand that this threshold isn't based on clock time but on number of possibilities considered. In current SQL QO versions, over a half million possibilities are considered before a time out is reached.

Optimizer timeout is designed in Microsoft SQL Server and in many cases encountering it is not a factor affecting query performance. However, in some cases the SQL query plan choice may be affected by optimizer timeout and thus performance could be impacted. When you encounter such issues, if you understand optimizer timeout mechanism and how complex queries can be affected in SQL Server, it can help you to better troubleshoot and improve your performance issue.

### How to detect an optimizer timeout



Here are some of the factors involved:

- You have a complex query that involves lots of joined tables (for example, 8 or more tables are joined).
 

- The query may run slowly or slower than when you compare it to another SQL Server version or another system.
 

- The query plan of the query shows the following information in the XML query plan: StatementOptmEarlyAbortReason="TimeOut". Or, if you verify the properties of the left-most plan operator in Microsoft SQL Server Management Studio, you notice the value of "Reason For Early Termination of Statement Optimization" is “TimeOut.”



For example, the following is the XML output of a query plan that shows the optimizer timeout:

```xml
<?xml version="1.0" encoding="utf-16"?>
<ShowPlanXML xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" Version="1.518" Build="13.0.5201.2" xmlns="http://schemas.microsoft.com/sqlserver/2004/07/showplan">
<BatchSequence>
<Batch>
<Statements>
<StmtSimple StatementCompId="6" StatementEstRows="419.335" StatementId="1" StatementOptmLevel="FULL" StatementOptmEarlyAbortReason="TimeOut" ......>
...
<Statements>
<Batch>
<BatchSequence>
```



The following is an example of a graphical representation of a plan, which displays a "TimeOut" value:

<<<<< picture here >>>>>


## What causes an optimizer timeout? 

There's no simple formula to determine what conditions would cause the optimizer threshold to be reached or exceeded. However, the following are some factors that determine how many plans are explored by QO in the process of looking for a "best plan":

### In what order to join tables:

Here is an example of the decision options with three tables (Table1, Table2, Table3)

- join Table1 with Table2 and the result with Table3
- join Table1 with Table3 and the result with Table2
- join Table2 with Table3 and the result with Table1

Note The larger the number of tables, the larger the possibilities are.
 

### What heap or binary tree (HoBT) access structure to use to retrieve the rows from a table?

- Nonclustered Index1
- Nonclustered Index2
- Clustered index
- .. and so on


### What physical access method to use?

- Index seek
- Index scan
- Table scan


### What physical join operator to use?

- Nested Loop
- Hash Match
- Merge Join (NL, HM, MJ)

### Should a parallel plan be used or a serial one?


To illustrate, take an example of a join between 3 tables (T1, T2 and T3) and each table has a clustered index only. There are two joins involved here and because there are 3 physical join possibilities (NL, HM, MJ), then each of the two joins can be performed in 6 (2 * 3) ways. Also consider the join order:





T1 joined to T2 and then to T3
 

T1 joined to T3 and then to T2
 

T2 joined to T3 and then to T1



Now multiply 6 ways * 3 join orders and we have a minimum of 18 possible plans to choose from. If you include the possibility of parallelism and other factors like Seek or Scan of the HoBT, then the possible plans increase even more. If you are a math wizard you can figure out that when a query involves for example 10 tables, the possible permutations there are in the millions. Therefore, you can see that a query with lots of joins is more likely to reach the optimizer timeout threshold than one with fewer joins.

 

Note The query predicates (filters in the WHERE clause) and existence of constraints will reduce the number of access methods considered and thus the possibilities considered.

 

The result of reaching the optimizer timeout threshold is that SQL Server has not considered the entire set of possibilities for optimization and it may have missed a set of plans that could produce shorter execution times. QO will stop at the threshold and consider the least-costly query plan at that point, although there may be better unexplored options. This may result in a query execution that's suboptimal.