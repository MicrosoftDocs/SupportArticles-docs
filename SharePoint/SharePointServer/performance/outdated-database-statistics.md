---
title: Outdated database statistics decrease SharePoint Server performance, cause time-outs, and generate run-time errors
description: Discusses how to display database statistics and the reasons to update statistics to avoid performance issues, time-outs issues, and run-time errors in SharePoint Server.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Administration\Performance
  - CSSTroubleshoot
appliesto: 
  - SharePoint Server 2019
  - SharePoint Server 2016
  - SharePoint Server 2013
  - SharePoint Server 2010
ms.date: 12/17/2023
---

# Outdated database statistics decrease SharePoint Server performance  

## About database statistics   

Statistics for query optimization are objects that contain statistical information about the distribution of values in one or more columns of a table or indexed view. The query optimizer uses these statistics to estimate the cardinality, or number of rows, in the query result. These cardinality estimates enable the query optimizer to create a high-quality query plan.  

For example, the query optimizer can improve query performance by using cardinality estimates to select the index seek operator instead of the more resource-intensive index scan operator. Otherwise, outdated statistics may decrease query performance by using inefficient query plans.  

Large enterprise SharePoint deployments must have database maintenance plans to update database statistics on content databases that reside in Microsoft SQL Server. Customers should not rely only on SharePoint-based database maintenance jobs to perform these tasks. For more information, see [Best practices for SQL Server in a SharePoint Server farm](/SharePoint/administration/best-practices-for-sql-server-in-a-sharepoint-server-farm).  

## Symptoms  

When database statistics become outdated, SharePoint Server installations may experience one or more of the following symptoms:  

- Slow load times and decreased performance that may generate an HTTP 500 error when you open a site page   
- Slower performance that generates error messages such as the following sample:  

   ```
   Service unavailable  
   Unknown SQL Exception 53  
   Server Error in '/' Application Runtime Error
   ```  
- Performing search crawls causes unexpected SQL Server performance, database locking, and blocking   
- Long-running timer jobs such as the "Microsoft SharePoint Foundation Usage Data Processing" jobs that take progressively longer to finish during each iteration.   
- The inability to open a SharePoint site, and an error message that resembles the following:   
   ```
   Unexpected System.Web.HttpException: Request timed out   
   ```
- Site rendering time-outs when you load navigation, and the following error message:  
   ```
   PortalSiteMapProvider was unable to fetch children for node   
   ```
- High CPU usage on the server that's running SQL Server when it processes SharePoint queries     

## Cause  

These issues may be caused by outdated database statistics. SharePoint runs a timer job daily to update database statistics by using the proc_updatestatistics SQL procedure. However, for various reasons, this timer job may not be completed or may not update all tables consistently. For example, if a Backup is running against the content database from SQL Server concurrently with the SharePoint timer job, the job won't continue.  

When the SharePoint timer job that updates statistics is completed, the followings events may be written to the ULS logs:  

- e9bf "An error occurred while updating statistics in the database, {0}"   
- cm1y "Updating statistics in the database, {0}"   
- dbl2 "Skipping statistics update of the database {0} because its status is {1}"   
- cm1x "Updating statistics in all databases on {0}"     

If these conditions aren't monitored closely and if corrective actions aren't taken, database statistics become outdated, and SharePoint performance issues eventually occur.  

## Resolution  

To prevent these symptoms and potential service outages, SQL Server maintenance plans should be implemented to keep SharePoint content database statistics updated by using the FULLSCAN option. For more information, see [Index statistics](/previous-versions/sql/sql-server-2005/ms190397(v=sql.90)).  

When implementing the SQL Server maintenance plan to update the statistics on your SharePoint databases, it is not required to disable the job from SharePoint. However, because these maintenance tasks perform similar functions from both locations, it is permissible to disable the "Databases used by SharePoint have outdated index statistics" Heath Analyzer rule from the SharePoint farm if databases are being managed by SQL. For more information about how to manage the index update job from SharePoint Server, see [Databases used by SharePoint have outdated index statistics (SharePoint 2013)](/SharePoint/technical-reference/databases-used-by-sharepoint-have-outdated-index-statistics).   

## More Information  

Updating the statistics of SharePoint content databases, using the FULLSCAN option, on a daily basis from the SQL Server is a recommend best practice. For more information, see [Best practices for SQL Server in a SharePoint Server farm](/SharePoint/administration/best-practices-for-sql-server-in-a-sharepoint-server-farm) and [Database maintenance for SharePoint Foundation 2010](/previous-versions/office/sharepoint-foundation-2010/hh133453(v=office.14)).   

However, if your SharePoint farm is currently experiencing performance issues because of outdated STATS, the following information can be used as a one-time mitigation step to alleviate this issue.   

To display database statistics information from a specific database, run the following query:

```  
-- Checking the DB Stats  
select a.id as 'ObjectID', isnull(a.name,'Heap') as 'IndexName', b.name as 'TableName',   
stats_date (id,indid) as stats_last_updated_time   
from sys.sysindexes as a   
inner join sys.objects as b   
on a.id = b.object_id   
where b.type = 'U'  
```  

For more information about database statistics review, see [DBCC SHOW_STATISTICS](https://technet.microsoft.com/library/aa258821%28v=sql.80%29.aspx).   

To update database statistics on a single database that uses the FULLSCAN option, run the following query:   

```  
-- Update DB Stats  
EXEC sp_MSforeachtable 'UPDATE STATISTICS ? WITH FULLSCAN'  
```  

Important note  The "sp_MSforeachtable" option is an undocumented procedure that's provided "as is" and should only be used to mitigate the immediate issue. We do not recommended that you use this procedure as part of a regular maintenance plan. Instead, see our [UPDATE STATISTICS (Transact-SQL)](/sql/t-sql/statements/update-statistics-transact-sql) documentation about how to implement a plan to UPDATE STATISTICS, using the FULLSCAN option.   

Depending on how outdated the database statistics have become, you may have to clear the query plan cache by running the [DBCC FREEPROCCACHE](/sql/t-sql/database-console-commands/dbcc-freeproccache-transact-sql) command after you update the database statistics. You'll find the syntax and arguments for this procedure in [DBCC FREEPROCCACHE (Transact-SQL)](/sql/t-sql/database-console-commands/dbcc-freeproccache-transact-sql). Doing this makes sure that new queries use the optimal execution plan after the database statistics are updated. For example, see the following query:  

```  
-- Remove all elements from the plan cache  
DBCC FREEPROCCACHE  
```  

> [!IMPORTANT]
> Running the DBCC FREEPROCCACHE command clears the cache for all query plans in in the SQL instance. This command should be well understood before you execute it during production hours.  

If the [DBCC FREEPROCCACHE](/sql/t-sql/database-console-commands/dbcc-freeproccache-transact-sql) command was not executed after updating the outdated database statistics, queries with inefficient execution plans may still reside in cache and be used. If this is the case, force a recompile on the specified stored procedure by using the stored procedure (see [sp_recompile (Transact-SQL)](/sql/relational-databases/system-stored-procedures/sp-recompile-transact-sql)). For example, see the following query:   

```  
USE SP2013_Content_DB  
GO  
sp_recompile proc_getwebnavstruct  
```  

Running the [sp_recompile](/sql/relational-databases/system-stored-procedures/sp-recompile-transact-sql) command together with procedure, function, or table parameters target a single element in the cache for removal without affecting the instance.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
