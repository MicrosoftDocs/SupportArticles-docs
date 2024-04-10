---
title: Errors after you apply a cumulative update to a contained availability group
description: Fixes the errors that occur after you apply a cumulative update to an instance of SQL Server that has a contained availability group.
ms.date: 06/27/2023
ms.custom: KB5027331
ms.reviewer: matteot, dliao, sureshka, jaferebe, v-cuichen
appliesto:
- SQL Server 2022 on Windows
- SQL Server 2022 on Linux
---
# FIX: Errors occur after you apply a cumulative update to an instance of SQL Server that has a contained availability group

## Symptoms

Consider the following scenario:

- You have an instance of SQL Server 2022 that has a contained availability group deployed.
- You create server-level objects (logins and jobs) in the context of the contained availability group.

In this scenario, one of the following errors occurs after you install a cumulative update on this instance of SQL Server.

### Error 1

The SQL Server Agent job fails with the following error message:

> Unable to start execution of step 2 (reason: JobOwner \<JobOwner> doesn't have permissions to use proxy <#> for subsystem SSIS).&nbsp;&nbsp;The step failed.

You see the SQL Server Agent error log records error messages that resemble the following ones:

> \<Timestamp> - ! [298] SQLServer Error: 208, Invalid object name 'syssubsystems'. [SQLSTATE 42S02]  
> \<Timestamp> - ! [517] SQL error number 208, severity 16

At this stage, the `syssubsystems` table is missing from the `msdb` database of the contained availability group and exists in the instance-level `msdb` database. To fix these errors and allow the jobs to run successfully, you can manually copy the instance-level `syssubsystems` table to the `msdb` database of the contained availability group by connecting to the listener and creating the table and the rows in the table.

### Error 2

After you create a contained availability group, you see the following error message every five seconds:

> The activated proc '[dbo].[sp_syspolicy_events_reader]' running on queue '\<AGName>_AG_SYNC_CONTAINED_msdb.dbo.syspolicy_event_queue' output the following:&nbsp;&nbsp;'Cannot execute as the database principal because the principal "##MS_PolicyEventProcessingLogin##" does not exist, this type of principal cannot be impersonated, or you do not have permission.'

### Error 3

After Database Mail stops working, trying to run the `sysmail` stored procedure will report an error message that resembles the following one:

> The object '[dbo].[sp_syspolicy_events_reader]' does not exist in database 'master' or is invalid for this operation.

### Error 4

After you create a contained availability group, if you connect to the contained availability group listener and create a SQL Server login principal, you will receive the following error in SQL Server Management Studio (SSMS) when you connect by using the login principal:

> Error connecting to _\<your listener>_  
> Failed to retrieve data for this request. (Microsoft.SqlServer.Management.Sdk.Sfc)  
> An exception occurred while executing a Transact-SQL statement or batch. (Microsoft.SqlServer.ConnectionInfo)  
> The EXECUTE permission was denied on the object 'xp_msver', database 'mssqlsystemresource', schema 'sys'. (Microsoft SQL Server, Error: 229)

This error occurs because the `public` role isn't granted the `EXECUTE` permission on the `xp_msver` extended stored procedure on the contained availability group (AG) master.

## Resolution

This problem is fixed in the following cumulative update for SQL Server:

[Cumulative Update 4 for SQL Server 2022](cumulativeupdate4.md)

## About cumulative updates for SQL Server

Each new cumulative update for SQL Server contains all the hotfixes and security fixes that were in the previous build. We recommend that you install the latest build for your version of SQL Server:

[Latest cumulative update for SQL Server 2022](build-versions.md)

## Status

Microsoft is currently investigating these issues. This article will be updated as we find more information or guidance. Until then, you can take the following necessary precautions before you install a cumulative update to an installation that has a contained availability group:

- Script the server-level objects and SQL Server Agent objects.
- Drop the contained availability group.
- Apply the cumulative update.
- Recreate the contained availability group.

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.

## References

Learn about the [terminology](../../../windows-client/deployment/standard-terminology-software-updates.md) that Microsoft uses to describe software updates.
