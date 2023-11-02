---
title: Non-component VSS backups fail on servers
description: This article provides a workaround for the problem where non-component VSS backups such as Azure Site Recovery jobs fail on servers that host SQL Server instances with AUTO-CLOSE DBs.
ms.date: 11/05/2020
ms.custom: sap:Administration and Management
ms.reviewer: rvuppula, gfourrat
---
# Non-component VSS backups such as Azure Site Recovery jobs fail on servers hosting SQL Server instances with AUTO_CLOSE DBs

This article helps you resolve the problem where non-component Volume Shadow Copy Service (VSS) backups such as Azure Site Recovery (ASR) jobs fail on servers that host SQL Server instances with `AUTO-CLOSE` DBs.

_Original product version:_ &nbsp; SQL Server 2017 on Windows, SQL Server 2016, SQL Server 2014, SQL Server 2012, SQL Server 2008 R2, SQL Server 2008, SQL Server in VM - Windows  
_Original KB number:_ &nbsp; 4504104

## Symptoms

Consider the following scenario:

- You have a server that is running any version of Microsoft SQL Server.
- This SQL Server instance hosts databases that have the AUTO-CLOSE option set.
- You run a non-component VSS backup (for example, by using ASR Agent) against volumes of this server that is hosting SQL Server database files.

In this situation, you notice that the VSS backup fails and triggers the following entry in the Application log:

> A VSS writer has rejected an event with error 0x800423f4, the writer experienced a non-transient error. If the backup process is retried, the error is likely to reoccur. Changes that the writer made to the writer components while handling the event will not be available to the requester. Check the event log for related events from the application hosting the VSS writer.  
Operation:  
    PostSnapshot Event  
Context:  
    Execution Context: Writer  
    Writer Class Id: {ID}  
    Writer Name: SqlServerWriter  
    Writer Instance Name: Microsoft SQL Server 2012:SQLWriter  
    Writer Instance ID: {ID}  
    Command Line: ""C:\Program Files\Microsoft SQL Server\90\Shared\sqlwriter.exe""  
    Process ID: xxx"

## Cause

This problem occurs because SQL Server SQLWriter currently doesn't handle AUTO-CLOSE databases correctly in non-component mode VSS backup requests.

## Workaround

As a short-term mitigation, we recommend that you disable the AUTO-CLOSE option on all databases of all SQL Server instances that are hosted on servers that receive non-component VSS backups. Typically, Azure virtual machines that run SQL Server are affected because ASR Agent runs such non-component backups.

## More information

- By default, the `AUTO_CLOSE`  property is set to **OFF** in SQL Server [Understanding SQL Express behavior: Idle time resource usage, AUTO_CLOSE and User Instances](/archive/blogs/sqlexpress/understanding-sql-express-behavior-idle-time-resource-usage-auto_close-and-user-instances). If you're confident that you didn't enable this setting manually on servers that might be affected by this problem, investigate any SQL Server Express instances that may have been silently installed as components of other applications.

- To get a list of databases that have `AUTO_CLOSE`  mode enabled, run the query against a given SQL Server instance: `select name,database_id,is_auto_close_on from sys.databases where is_auto_close_on=1`.

- To change the setting, refer to the `AUTO_CLOSE` section of [ALTER DATABASE SET Options](/sql/t-sql/statements/alter-database-transact-sql-set-options) in online documentation for TSQL.

  - To toggle this option to OFF, run the following command in the default client sqlcmd.exe (for example, for the My Database database):
  
      ```sql
      alter database <myDatabase> set auto_close OFF
      ```

  - The change takes effect immediately. To revert this change, run the following command:
  
      ```sql
      alter database <myDatabase> set auto_close ON
      ```

- If you prefer a GUI method, use **Database Properties** > **Options** in SQL Server Management Studio.
