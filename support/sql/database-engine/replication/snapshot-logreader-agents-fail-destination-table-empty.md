---
title: Snapshot or Logreader agents fail
description: This article provides a workaround for the problem that Snapshot or Logreader agents fail when a destination table is empty.
ms.date: 07/22/2020
ms.custom: sap:Replication, change tracking, change data capture
ms.reviewer: rvrosa
---
# Snapshot or Logreader agents fail when destination table is empty in SQL Server

This article helps you work around the problem that Snapshot or Logreader agents fail when a destination table is empty.

_Original product version:_ &nbsp; SQL Server 2014, SQL Server 2012  
_Original KB number:_ &nbsp; 3144065

## Symptoms

In a transactional replication in Microsoft SQL Server, an article in a SQL query has an empty string in a destination table (@destination_table = N"") in a Transact-SQL statement. In this situation, you may receive the following error messages in the specified locations:

- In the Snapshot agent:

    > Value cannot be null.Parameter name: strObjectName

- In the Logreader agent:

    > The process could not execute 'sp_replcmds' on 'SERVER'

- In the error log file:

    > SQL Server Assertion: File: <replrowset.cpp>, line=2853 Failed Assertion = 'dwColLen'.

> [!NOTE]
> The third error may be timing-related. If the error persists after you rerun the statement, use `DBCC CHECKDB` to check the database for structural integrity. Or, restart the server to make sure that in-memory data structures are not corrupted. A dump file is created in the `\Log` folder that contains the details of the assertion.  
> The second and third errors are triggered only if publication has the **immediate sync** option enabled.

## Cause

This issue occurs because an empty string is not a valid destination table name.

## Workaround

To work around this issue, set a valid destination table name, or remove the invalid destination table name.

## Applies to

- SQL Server 2014 Business Intelligence
- SQL Server 2014 Developer
- SQL Server 2014 Enterprise
- SQL Server 2014 Enterprise Core
- SQL Server 2014 Express
- SQL Server 2014 Standard
- SQL Server 2014 Web
- SQL Server 2012 Business Intelligence
- SQL Server 2012 Developer
- SQL Server 2012 Enterprise
- SQL Server 2012 Enterprise Core
- SQL Server 2012 Express
- SQL Server 2012 Web
- SQL Server 2012 Standard
