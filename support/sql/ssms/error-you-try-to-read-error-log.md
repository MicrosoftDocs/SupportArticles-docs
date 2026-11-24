---
title: Startup Failures and Error Reading Error Log in SSMS
description: Learn how to fix SQL Server Agent startup failures and the Failed to retrieve data error when you read the error log in SSMS, caused by an older MS ODBC 13 driver.
ms.date: 11/24/2026
ms.custom: sap:SQL Server Management, Query and Data Tools
---
# SQL Server Agent fails to start or 'Failed to retrieve data' error when you try to read error log from SSMS

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 3185365

## Summary

SQL Server Agent might fail to start, and SQL Server Management Studio (SSMS) might return a "Failed to retrieve data" error when you try to read the SQL Server error log. These problems can occur on certain SQL Server named instances when SSMS and SQL Server Agent use an older version of the MS ODBC 13 driver. This article describes the symptoms, explains the cause, and shows how to resolve the problems by using the [MS ODBC 13.1 driver](/sql/connect/odbc/windows/release-notes-odbc-sql-server-windows#131) or newer driver.

## Symptoms

When you use an older version of the MS ODBC 13 driver with SQL Server named instances, you might experience one of the following symptoms.

### Symptom 1: SQL Server Agent can't connect to the instance and doesn't start

The [SQL Server Agent log file](/sql/ssms/agent/sql-server-agent-error-log) displays a message that resembles the following:

> 2016-08-06 14:54:41 - ! [000] Unable to connect to server 'servername\instancename';
SQLServerAgent cannot start  
2016-08-06 14:54:46 - ! [298] SQLServer Error:  
65535, SQL Server Network Interfaces: Error Locating Server/Instance Specified  
[xFFFFFFFF]. [SQLSTATE 08001]  
2016-08-06 14:54:46 - ! [165] ODBC Error: 0,  
Login timeout expired [SQLSTATE HYT00]  
2016-08-06 14:54:46 - ! [298]  
SQLServer Error: 65535, A network-related or instance-specific error has occurred while establishing a connection to SQL Server.  
Server is not found or not accessible.  
Check if instance name is correct and if SQL Server is configured to allow remote connections.   For more information, see SQL Server Books Online. [SQLSTATE 08001]

### Symptom 2: "Failed to retrieve data" error when you read the SQL Server error log

When you try to read the SQL Server error log in SSMS, the attempt fails, and an error that resembles the following is returned:

> Failed to retrieve data for this request. (Microsoft.SqlServer.Management.Sdk.Sfc)  
An exception occurred while executing a Transact-SQL statement or batch. (Microsoft.SqlServer.ConnectionInfo)

Also, when you try to execute `xp_readerrorlog`, this action might trigger the following errors:

> Msg 22004, Level 16, State 1, Line 0  
Failed to open loopback connection. Please see event log for more information.  
Msg 22004, Level 16, State 1, Line 0  
Error log location not found.

### Symptom 3: Maintenance plans or SQL Server Agent jobs fail silently

Certain maintenance plans or SQL Server Agent jobs, such as a maintenance cleanup task to delete old backup or report files, fail without any error message. For example, the cleanup task doesn't delete the files you expect when you run the corresponding job, and it doesn't write an error to the SQL Server log. Running [`sp_readerrorlog`](/sql/relational-databases/system-stored-procedures/sp-readerrorlog-transact-sql) returns the errors that are described in Symptom 2.

## Cause

This issue is caused by a defect in the MS ODBC 13 driver. SQL Server Management Studio (SSMS) and SQL Server Agent use this driver to connect to the SQL Server computer.

## Resolution

This issue is fixed in the [MS ODBC 13.1 driver](/sql/connect/odbc/windows/release-notes-odbc-sql-server-windows#131). Update the driver on the computer that runs SSMS and SQL Server Agent.

## Related content

- [SQL Server Agent shuts down unexpectedly when you try to start it](../database-engine/startup-shutdown/sql-server-agent-crashes-upon-start.md)
- [SQL Server Agent fails to start while connecting to SQL Server](../database-engine/connect/unable-to-start-sql-agent.md)
- [Manage the SQL Server error log](../database-engine/startup-shutdown/manage-error-log.md)
