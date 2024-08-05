---
title: Error 0x80131604 installing an OpsMgr management server
description: Fixes an issue in which you receive an exception error code 0x80131604 during the installation of a System Center 2012 Operations Manager server.
ms.date: 04/15/2024
---
# Installation of a System Center 2012 Operations Manager server fails with error 0x80131604

This article provides a solution to solve the **Ad hoc update to system catalogs is not supported** error that occurs when you install a System Center 2012 Operations Manager management server.

_Original product version:_ &nbsp; System Center 2012 Operations Manager  
_Original KB number:_ &nbsp; 2713047

## Symptoms

Installing a System Center 2012 Operations Manager management server fails with the following error:

> Error: :Exception running sql string  
> sp_configure 'show advanced options', 1  
> RECONFIGURE  
> : Threw Exception.Type: System.Data.SqlClient.SqlException, Exception Error Code: 0x80131904, Exception.Message: **Ad hoc update to system catalogs is not supported**.  
> Configuration option 'show advanced options' changed from 1 to 1. Run the RECONFIGURE statement to install.  
> [*DateTime*]: Error: :StackTrace:   at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection)  
> at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning()
>
> Error: :RunAdminScripts failed with the following exception: : Threw Exception.Type: System.Reflection.TargetInvocationException, Exception Error Code: 0x80131604, Exception.Message: Exception has been thrown by the target of an invocation.

> [!NOTE]
> Operations Manager log files are located at `%LocalAppData%\SCOM\Logs`.

## Cause

An **Ad hoc update to system catalogs is not supported** error is encountered during the Intelligent Queue installation. This error means that SQL Server would not allow a change to its catalogs. This can occur if the setting for **allow updates** has been changed and set to **1**. Starting with SQL Server 2005, direct updates to the system tables are not supported so we need to turn this setting off to make any further changes in the catalog and tables.

The SQL Server **allow updates** option is present in the `sp_configure` stored procedure.

To test if this is the cause of your issue, manually run the following query against the master database:

```sql
sp_configure 'show advanced options', 1
```

Then run,

```sql
RECONFIGURE
```

If you're experiencing the issue described in this article, the command will fail with the following message.

> Exception.Message: Ad hoc update to system catalogs is not supported.

## Resolution

To work around this issue, change the value to **0** with the following query. This setting allows the SQL Server database to receive any changes or updates to its catalog.

```sql
EXEC sp_configure 'allow updates', 0
```

Then run,

```sql
RECONFIGURE
```

This will run successfully.

Once completed, restart the installation of the management server.
