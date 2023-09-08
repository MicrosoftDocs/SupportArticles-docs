---
title: Error when you try to read error log
description: This article lists various problems that occur in SSMS when using an older version of MS ODBC 13 driver and the resolution for these problems.
ms.date: 09/15/2020
ms.custom: sap:Tools
---
# SQL Server 2016 Agent fails to start or 'Failed to retrieve data' error when you try to read error log from SSMS 2016

This article lists various problems that occur in SSMS when using an older version of MS ODBC 13 driver and the resolution for these problems.

_Original product version:_ &nbsp; SQL Server 2016 Developer  
_Original KB number:_ &nbsp; 3185365

## Symptoms

When you have a Microsoft SQL Server 2016 RTM or SQL Server 2016 RTM CU1 named instance, you may experience one of the following symptoms.

## Symptom 1

The SQL Server Agent log file displays a message that resembles the following:

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

## Symptom 2

When you try to read the SQL Server error log, the attempt fails, and an error that resembles the following is returned:

> Failed to retrieve data for this request. (Microsoft.SqlServer.Management.Sdk.Sfc)  
An exception occurred while executing a Transact-SQL statement or batch. (Microsoft.SqlServer.ConnectionInfo)

Additionally, when you try to execute xp_readerrorlog, this may trigger the following errors:

> Msg 22004, Level 16, State 1, Line 0  
Failed to open loopback connection. Please see event log for more information.  
Msg 22004, Level 16, State 1, Line 0  
Error log location not found.

## Symptom 3

Certain maintenance plans or SQL Agent jobs, such as a maintenance cleanup task to delete old backup or report files "silently" fail. In the case of the cleanup task, the files that you expect to be deleted are not deleted when the corresponding job is run, and no error is written to the SQL Server log. Executing `sp_readerrorlog` would result in Symptom 2.

## Cause

This issue is caused by a defect in the MS ODBC 13 driver. SQL Server Management Studio (SSMS) and SQL Server Agent use this driver to connect to SQL Server computer.

## Resolution

This issue is fixed in the [MS ODBC 13.1 driver](https://www.microsoft.com/download/details.aspx?id=53339).
