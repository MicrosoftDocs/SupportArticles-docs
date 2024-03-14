---
title: Cannot set up Management Reporter 2012 Application Service
description: Describes an error message that may occur when you configure the application and process services for Management Reporter.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Financial - Management Reporter
---
# Management Reporter 2012 Application Service fails to configure

This article provides a resolution for the issue that you can't configure Management Reporter 2012 Application Service due to the **Could not obtain exclusive lock on database 'model'** error.

_Applies to:_ &nbsp; Microsoft Management Reporter 2012, Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 3076964

## Symptom

When you attempt to configure the application and process service for Management Reporter 2012, a red X appears on the application service.

This can also happen when you add a new integration to a new data mart database using the configuration console for Microsoft Management Reporter 2012. The creation of the data mart database fails.

When this happens, check the deployment log at *C:\ProgramData\Microsoft Dynamics ERP\Management Reporter\Logs\Deployment-Date_Time.log*. The following error message will be displayed in the log file:

>.Net SqlClient Data Provider: Msg 1807, Level 16, State 3, Line 1 Could not obtain exclusive lock on database 'model'. Retry the operation later.

## Cause

This issue can occur if there is a connection to the model database in Microsoft SQL Server. The Management Reporter application will not be able to gain an exclusive lock on the model database, causing the creation of the ManagementReporter database to fail. This can also occur when attempting to create a new ManagementReporterDM data mart database.

There are other applications that may keep a lock on the model database.

## Resolution

Use the following query in Microsoft SQL Server Management Studio where you are attempting to create the Management Reporter database, to find further details on the process with a connection to the model database:

```sql
select
'Session ID' = sp.spid
,'Database Name' = db.name
,HostName = sp.hostname
,'Program Name' = sp.program_name
,'Login Name' = sp.loginame
,'Task Manager PID' = sp.hostprocess
,Status = sp.status from sys.sysprocesses sp
join sys.databases db on db.database_id = sp.dbid
where db.name = 'model'
```

With the results of the above query, review the HostName column using the steps below.

1. Sign in to the server in the hostname results and open Task Manager.
2. Add the PID column in the Processes view.
   - Server 2012: Right-click the **Name** column header and then select **PID**.
   - Server 2008: Select **View**, select **Select Columns...** and then select **PID**.

Compare the Task Manager PID results from the above query with the PID in Task Manager to gain additional information on the process.

Depending on the application running the process, stop the related service or close the program that is holding a lock on the model database.

For example, if the process holding a lock is stemming from SQL Management Studio, close the query window where the Model database is selected.

If the process holding the lock is stemming from an application, go to services on the server and stop the service for that application.
