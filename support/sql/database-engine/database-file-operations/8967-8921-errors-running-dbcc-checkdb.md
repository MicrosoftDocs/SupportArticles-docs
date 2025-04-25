---
title: Error when you run the DBCC CHECKDB command
description: This article provides a workaround for the problem that occurs when you run the DBCC CHECKDB command on a SQL Server database.
ms.date: 04/25/2025
ms.custom: sap:File, Filegroup, Database Operations or Corruption
ms.reviewer: sureshka, ryanston, sunila, davco
---
# Error message when you run the DBCC CHECKDB command on a SQL Server database

This article hepls you work around the problem that occurs when you run the `DBCC CHECKDB` command on a computer that contains a SQL Server database.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 960791

## Symptoms

Consider the following scenario:

- You restore a Microsoft SQL Server 2008 or SQL Server 2005 database from a backup.

- You receive errors during the restore process that prevent you from restoring the database.

- You successfully restore the database from the same backup by using the CONTINUE_AFTER_ERROR option.

In this scenario, when you run the DBCC CHECKDB command on the computer that contains the SQL Server database, you receive an error message that resembles the following:

> Msg 8967, Level 16, State 216, Server \<server name>, Line 2  
An internal error occurred in DBCC which prevented further processing. Please contact Customer Support.  
DBCC results for '\<database name>'.  
>
> Msg 8921, Level 16, State 1, Server \<server name>, Line 1
>
> Check terminated. A failure was detected while collecting facts. Possibly tempdb out of space or a system table is inconsistent. Check previous errors.

Additionally, a message that resembles the following may be displayed in the SQL Server error log:

> 2007-05-26 07:13:49.21 spid58 DBCC encountered a page with an LSN greater than the current end of log LSN (\<LSN>) for its internal database snapshot. Could not read page (file id:page id), database '\<database name' (database ID database id>), LSN = (\<LSN>), type = 32, isInSparseFile = 1. Please re-run this DBCC command.

## Cause

This problem occurs if the `DBCC CHECKDB` command cannot perform the necessary checks to confirm the consistency of the database. These checks could not be performed for many reasons. For example, this behavior may occur if there are fundamental inconsistencies in the database, such as metadata inconsistencies or database snapshot corruption. More information about the specific cause of this error can be determined by examining the different state that is displayed in the error message. In the scenario that is described in the [Symptoms](#symptoms) section, the state 216 message indicates that the `DBCC CHECKDB` command read a page from the internal snapshot that has a larger log sequence number (LSN) than the end of log LSN. This behavior might occur if you restore databases by using the **CONTINUE_AFTER_ERROR** option.

## Workaround

To work around this problem, use the [TABLOCK hint](/sql/t-sql/database-console-commands/dbcc-checkdb-transact-sql#tablock) with the `DBCC CHECKDB` command. This lets the `DBCC CHECKDB` command finish without generating the error message.

For more information about TABLOCK hints, see [Hints (Transact-SQL) - Table](/sql/t-sql/queries/hints-transact-sql-table).
