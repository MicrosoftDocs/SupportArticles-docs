---
title: Management server can't contact the data warehouse database
description: Describes an issue that occurs when the System Center Operations Manager 2012 management server tries to communicate with the instance of SQL Server that used to host the data warehouse database.
ms.date: 04/15/2024
---
# Events 31551 and 31565 when Operations Manager management server contacts the data warehouse database

This article helps you fix an issue where you receive event ID 31551 and 31565 when the Operations Manager management server tries to communicate with the instance of Microsoft SQL Server that used to host the Operations Manager data warehouse database.

_Original product version:_ &nbsp; System Center 2012 R2 Operations Manager, Microsoft System Center 2012 Operations Manager  
_Original KB number:_ &nbsp; 3058923

## Symptoms

Consider the following scenario:

- You had an instance of SQL Server that no longer exists.
- The Operations Manager data warehouse database is moved to new instance of SQL Server.
- The System Center 2012 Operations Manager management server tries to communicate with the instance of SQL Server that used to host the data warehouse database.

In this scenario, you receive event ID 31551 and 31565 as follows:

> Log Name: Operations Manager  
> Source: Health Service Modules  
> Date: 4/16/2015 3:27:18 PM  
> Event ID: 31551  
> Task Category: Data Warehouse  
> Level: Error  
> Keywords: Classic  
> User: N/A  
> Computer: ServerMGMT1.Contoso.MSFT  
> Description:  
> Failed to store data in the Data Warehouse. The operation will be retried.  
> Exception 'SqlException': A network-related or instance-specific error occurred while establishing a connection to SQL Server. The server was not found or was not accessible. Verify that the instance name is correct and that SQL Server is configured to allow remote connections. (provider: Named Pipes Provider, error: 40 - Could not open a connection to SQL Server)
>
> One or more workflows were affected by this.  
>
> Workflow name: Microsoft.SystemCenter.DataWarehouse.CollectAlertData  
> Instance name: Data Warehouse Synchronization Service  
> Instance ID: {26BC200F-C4C9-F25C-8D8E-5AE8603C3782}  
> Management group: ManagementGroup1

> Log Name: Operations Manager  
> Source: Health Service Modules  
> Date: 4/16/2015 3:27:18 PM  
> Event ID: 31565  
> Task Category: Data Warehouse  
> Level: Error  
> Keywords: Classic  
> User: N/A  
> Computer: ServerMGMT1.Contoso.MSFT  
> Description:  
> Failed to deploy Data Warehouse component. The operation will be retried.  
> Exception 'DeploymentException': Failed to perform Data Warehouse component deployment operation: Install; Component: Script, Id: 'ffdaf07a-73e1-892f-b687-89385b3744cf', Management Pack Version-dependent Id: 'de2dc89e-3efa-9865-fd1c-b0cf297cd8fd'; Target: Database, Server name: 'OLDSQLSERVERNAME', Database name: 'OperationsManagerDW'. Batch ordinal: 0; Exception: A network-related or instance-specific error occurred while establishing a connection to SQL Server. The server was not found or was not accessible. Verify that the instance name is correct and that SQL Server is configured to allow remote connections. (provider: Named Pipes Provider, error: 40 - Could not open a connection to SQL Server)
>
> One or more workflows were affected by this.
>
> Workflow name: Microsoft.SystemCenter.DataWarehouse.Deployment.Component  
> Instance name: Data Warehouse Synchronization Service  
> Instance ID: {26BC200F-C4C9-F25C-8D8E-5AE8603C3782}  
> Management group: ManagementGroup1

## Cause

The management server may have some outdated values in configuration files or in the registry. Or, in rare cases, there may also be some old database tables in the current Operations Manager data warehouse database.

## Resolution

To resolve this issue, follow these steps:

1. Under `HKEY_LOCAL_MACHINE\Software\Microsoft\Microsoft Operations Manager\3.0\Setup`, double-click the `DatabaseServerName` value, and then change the value to the hostname of the SQL Server-based computer that's now hosting the Operations Manager database. If you are using a named instance of SQL Server, make sure that you use the *ServerName\Instance name* format.

2. Check the Configservice.config file in your installation location for any trace of the name of the old instance of SQL Server, and replace that with the hostname of the SQL Server-based computer that is now hosting the Operations Manager database.

   For example, the Configservice.config file may be in the `C:\Program Files\Microsoft System Center 2012 R2\Operations Manager\Server` folder.

3. You may want to check your current Operations Manager data warehouse `MemberDatabase` database table. If you find an entry that includes the name of the old instance of SQL Server in this table, contact Microsoft Customer Support Services for additional investigation.

## More information

We don't recommend that you change the Operations Manager databases unless a Microsoft Customer Support engineer is available to assist in analyzing the issue. Direct changes to the Operations Manager databases may cause the management group to enter an unrecoverable state.
