---
title: Can't connect remotely using TCP/IP
description: This article provides resolutions for the problem where users are not able to connect remotely to SQL Server using TCP/IP protocol.
ms.date: 09/25/2020
ms.custom: sap:Connection issues
---

# Users may not be able to connect remotely to SQL Server using TCP/IP protocol

This article helps you resolve the problem where you are not be able to connect remotely to SQL Server using TCP/IP protocol.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 2018930

## Symptoms

When using Microsoft SQL Server, you may see one or more of the following symptoms:

- Only the users that have [CONTROL SERVER](/sql/relational-databases/security/permissions-database-engine) permission (for example, members of **syadmin** fixed server role) are able to connect via TCP/IP. Users who don't have this permission can't connect remotely via TCP/IP protocol either using Windows or SQL Server authentication.

  > [!NOTE]
  > You will notice that the elevated user connections only show up in [sys.dm_exec_sessions (Transact-SQL)](/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-sessions-transact-sql) Dynamic Management View (DMV) but not in [sys.dm_exec_connections (Transact-SQL)](/sql/relational-databases/system-dynamic-management-views/sys-dm-exec-connections-transact-sql) view.

- Both local and remote connections using Named Pipes protocol as well as local connections using shared memory protocol continue to work fine.

Additionally, the following messages are logged in the SQL Server Errorlog file:

- At SQL Server start up:

  > Error: 26023, Severity: 16, State: 1.  
  Server TCP provider failed to listen on ['any'\<ipv6> 1963]. Tcp port is already in use.  
  Error: 9692, Severity: 16, State: 1.  
  The Service Broker protocol transport cannot listen on port 1963 because it is in use by another process.

- For failed logins:

  SQL Server 2008 and later versions:

  > Error: 18456, Severity: 14, State: 11.  
  Login failed for user 'MyDomain\TestAcc'. Reason: Token-based server access validation failed with an infrastructure error. Check for previous errors.

## Cause

The error occurs when you configure a [TCP endpoint](/sql/t-sql/statements/create-endpoint-transact-sql) for Service Broker using the same port that the SQL Server instance is configured to use. You can obtain the list of endpoints by executing the following query:

```sql
SELECT * FROM sys.tcp_endpoints
```

> [!NOTE]
> As explained in Books Online topic on [sys.tcp_endpoints (Transact-SQL)](/sql/relational-databases/system-catalog-views/sys-tcp-endpoints-transact-sql), this view doesn't contain information on the ports and protocols that SQL Server instance is currently configured to use. To find that information, see [SQL Server Configuration Manager](/sql/relational-databases/sql-server-configuration-manager).

## Resolution

- **Method 1**: Drop the endpoint that's causing the problem using the [DROP ENDPOINT (Transact-SQL)](/sql/t-sql/statements/drop-endpoint-transact-sql) command.

  For example, to drop an endpoint named `TestEP` you can use the following command:

    ```sql
    DROP ENDPOINT TestEP
    ```

- **Method 2**: Alter the endpoint to use a different port using the [ALTER ENDPOINT (Transact-SQL)](/sql/t-sql/statements/alter-endpoint-transact-sql) command.

  For example, to alter an endpoint named `TestEP` to use a different port you can use the following command:

    ```sql
    ALTER ENDPOINT TestEP as tcp (listener_port=1980)
    ```

## More information

Similar issues may also occur with other TCP endpoints like those created for Database mirroring, and the error messages at SQL Server startup will change accordingly.
