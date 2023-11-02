---
title: Always On availability groups check failed after changing the hostname
description: This article provides workarounds for the issue that occurs after you change the hostname.
ms.date: 10/13/2021
ms.custom: sap:Availability Groups
ms.reviewer: ramakoni, ericbu
---
# Always On availability groups and replication issues after changing the hostname

_Applies to:_ &nbsp; SQL Server 2019, SQL Server 2017

## Symptoms

After changing the hostname of a server hosting Microsoft SQL Server 2019 or SQL Server 2017, you experience issues with Always On availability groups or replication. These issues occur after installing the [SQL Server 2019 cumulative update (CU) 9](https://support.microsoft.com/topic/kb5000642-cumulative-update-9-for-sql-server-2019-97ad5c3e-e002-4b6d-b566-698bf70ca44a), [SQL Server 2017 CU23](https://support.microsoft.com/topic/kb5000685-cumulative-update-23-for-sql-server-2017-22b653c7-8487-4564-9db2-b5c1bd465145), or a later CU.

Here are error examples:

- > Error: 19435, Severity: 16, State: 1.  
Always On: AG integrity check failed for AG 'AGPRD' with error 41041, severity 16, state 0.  
Always On: Availability group 'AGPRD' was removed while the availability replica on this instance of SQL Server was offline.  The local replica will be removed now.
- > SQL Server replication requires the actual server name to make a connection to the server. Specify the actual server name.

## Cause

By default, the new hostname is reported in the `ServerName` property of the `SERVERPROPERTY` function and the SQL Server error log. After installing [SQL Server 2019 CU9](https://support.microsoft.com/topic/kb5000642-cumulative-update-9-for-sql-server-2019-97ad5c3e-e002-4b6d-b566-698bf70ca44a), [SQL Server 2017 CU23](https://support.microsoft.com/topic/kb5000685-cumulative-update-23-for-sql-server-2017-22b653c7-8487-4564-9db2-b5c1bd465145) or a later CU, the new server name isn't derived from the hostname but from `sys.servers` view. These issues occur if the hostname doesn't match `sys.servers`.

## Workaround

1. After changing the hostname, remove the old name from the list of known remote and linked servers on the local instance of SQL Server. Run the `sp_dropserver` procedure:

    ```tsql
    EXEC sp_dropserver '<old_name>';  
    GO
    ```

2. Provide the new name to the SQL Server Database Engine instance. Run the `sp_addserver` procedure:

    ```tsql
    EXEC sp_addserver '<new_name>', local;
    GO
    ```

For more information, see [rename a computer that hosts a stand-alone instance of SQL Server](/sql/database-engine/install-windows/rename-a-computer-that-hosts-a-stand-alone-instance-of-sql-server).

## Status

- For SQL Server on Linux, a comprehensive solution has been scheduled for the next version of SQL Server.
- For SQL Server on Windows, this issue has been fixed in [SQL Server 2017 CU27](https://support.microsoft.com/topic/kb5006944-cumulative-update-27-for-sql-server-2017-79117c8f-9d54-42f8-9727-5870fe475187) and [SQL Server 2019 CU13](https://support.microsoft.com/topic/kb5005679-cumulative-update-13-for-sql-server-2019-5c1be850-460a-4be4-a569-fe11f0adc535).
