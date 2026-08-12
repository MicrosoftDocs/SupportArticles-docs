---
title: Troubleshoot Timeout Expired Errors in SQL Server
description: Learn how to identify and resolve timeout expired errors in SQL Server, from blocked firewall ports and stopped services to protocol mismatches and DNS failures.
ms.date: 08/07/2026
ms.topic: troubleshooting
ms.custom: sap:Database Connectivity and Authentication
ms.reviewer: jopilov
---
# Troubleshoot connection timeout errors when connecting to SQL Server

_Applies to:_ &nbsp; SQL Server

## Summary

A "Timeout expired" error in SQL Server means that a connection or command operation didn't complete within the time-out interval that the client application allows, so the client canceled the operation instead of waiting indefinitely. This article helps you identify whether you're hitting a connection timeout or a query or command timeout. It covers the error messages you might encounter with a connection timeout and the typical service, port, firewall, and name resolution causes behind connection timeouts. Use this article when a client application intermittently or consistently fails to connect to a SQL Server instance with connection timeout errors.

To troubleshoot query or command timeout errors, see [Troubleshoot query time-out errors](../performance/troubleshoot-query-timeouts.md).

> [!NOTE]
> Before you start troubleshooting, check the [prerequisites](../connect/resolve-connectivity-errors-checklist.md) and go through the checklist.

## Timeout expired error messages when connecting to SQL Server

When you encounter "timeout expired" issues, you receive one or more of the following error messages:

- > Timeout expired. The timeout period elapsed prior to completion of the operation or the server is not responding.

- > System.Data.SqlClient.SqlException (0x80131904): Connection Timeout Expired.
The timeout period elapsed while attempting to consume the pre-login handshake acknowledgment.
This could be because the pre-login handshake failed or the server was unable to respond back in time.
The duration spent while attempting to connect to this server was [Pre-Login] initialization=23; handshake=14979;  
System.ComponentModel.Win32Exception (0x80004005): The wait operation timed out.

- > System.Data.SqlClient.SqlException (0x80131904): Timeout expired.
The timeout period elapsed prior to completion of the operation or the server is not responding.
System.ComponentModel.Win32Exception (0x80004005): The wait operation timed out.

- > Connection Timeout Expired.
The timeout period elapsed while attempting to consume the pre-login handshake acknowledgment.
This could be because the pre-login handshake failed or the server was unable to respond back in time.  
The duration spent while attempting to connect to this server was [Pre-Login] initialization=21036; handshake=0; (Microsoft SQL Server, Error: -2).

- > System.InvalidOperationException: Timeout expired. The timeout period elapsed prior to obtaining a connection from the pool.

  If connections aren't closed correctly, errors may occur. These errors occur because all pooled connections are in use, and max pool size is reached. You can avoid these errors if you follow the steps described in the [exhausted the connection pool](/archive/blogs/spike/timeout-expired-the-timeout-period-elapsed-prior-to-obtaining-a-connection-from-the-pool) article. For more information about how pooling works, see [SQL Server connection pooling (ADO.NET)](/dotnet/framework/data/adonet/sql-server-connection-pooling).

> [!NOTE]
> The second and the third errors occur when .NET Framework 4.5 or a later version is installed.

## Determine which type of timeout occurred

There are two types of timeout problems commonly observed with database applications:

- Connection timeout (15 seconds by default)
- Query or command timeout (30 seconds by default)

These two problems are very different in nature as they come from different sources and happen in separate independent phases of a database application interaction. A connection timeout occurs when an initial connection to the database engine fails. A query or command timeout, on the other hand, occurs much later in the life of an application interaction with a database server. The initial connection has gone through successfully but a query you submitted to the database server is taking a long time to complete. 

Before troubleshooting, view the complete call stack of the error messages to determine the error type.

- See the following example of a call stack of a connection timeout:

    ```output
    System.Data.SqlClient.SqlException: Timeout expired. The timeout period elapsed prior to completion of the operation or the server is not responding.
    at System.Data.SqlClient.SqlInternalConnection.OnError(SqlException exception, Boolean breakConnection)
    at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj)
    at System.Data.SqlClient.TdsParserStateObject.ReadSniError(TdsParserStateObject stateObj, UInt32 error)
    at System.Data.SqlClient.TdsParserStateObject.ReadSni(DbAsyncResult asyncResult, TdsParserStateObject stateObj)
    at System.Data.SqlClient.TdsParserStateObject.ReadNetworkPacket()
    at System.Data.SqlClient.TdsParser.ConsumePreLoginHandshake(Boolean encrypt,Boolean trustServerCert, Boolean& marsCapable)
    at System.Data.SqlClient.TdsParser.Connect(ServerInfo serverInfo, SqlInternalConnectionTds connHandler, Boolean ignoreSniOpenTimeout, Int64 timerExpire, Boolean encrypt, Boolean trustServerCert, Boolean integratedSecurity, SqlConnectionowningObject)
    at System.Data.SqlClient.SqlInternalConnectionTds.AttemptOneLogin(ServerInfoserverInfo, String newPassword, Boolean ignoreSniOpenTimeout, Int64 timerExpire, SqlConnection owningObject)
    at System.Data.SqlClient.SqlInternalConnectionTds.LoginNoFailover(String host, String newPassword, Boolean redirectedUserInstance, SqlConnection owningObject, SqlConnectionString connectionOptions, Int64 timerStart)
    at System.Data.SqlClient.SqlInternalConnectionTds.OpenLoginEnlist(SqlConnection owningObject, SqlConnectionString connectionOptions, String newPassword, Boolean redirectedUserInstance)
    at System.Data.SqlClient.SqlInternalConnectionTds..ctor(DbConnectionPoolIdentity identity, SqlConnectionString connectionOptions, Object providerInfo, String newPassword, SqlConnection owningObject, Boolean redirectedUserInstance)
    at System.Data.SqlClient.SqlConnectionFactory.CreateConnection(DbConnectionOptions options, Object poolGroupProviderInfo, DbConnectionPool pool, DbConnection owningConnection)
    at System.Data.ProviderBase.DbConnectionFactory.CreatePooledConnection(DbConnection owningConnection, DbConnectionPool pool, DbConnectionOptions options)  
    at System.Data.ProviderBase.DbConnectionPool.CreateObject(DbConnection owningObject) at System.Data.ProviderBase.DbConnectionPool.UserCreateRequest(DbConnection owningObject)
    at System.Data.ProviderBase.DbConnectionPool.GetConnection(DbConnection owningObject)
    at System.Data.ProviderBase.DbConnectionFactory.GetConnection(DbConnection owningConnection)
    at System.Data.ProviderBase.DbConnectionClosed.OpenConnection(DbConnection outerConnection, DbConnectionFactory connectionFactory)
    at System.Data.SqlClient.SqlConnection.Open()  
    ```

    `SqlConnection.Open` indicates that the client is trying to open a connection and therefore isn't related to a query.

- See the following example of a call stack of a query or command timeout:

    ```output
    System.Data.SqlClient.SqlException: Timeout expired. The timeout period elapsed prior to completion of the operation or the server is not responding.
    at System.Data.SqlClient.SqlConnection.OnError(SqlException exception, Boolean breakConnection)
    at System.Data.SqlClient.TdsParser.ThrowExceptionAndWarning(TdsParserStateObject stateObj)
    at System.Data.SqlClient.TdsParser.Run(RunBehavior runBehavior, SqlCommand cmdHandler, SqlDataReader dataStream, BulkCopySimpleResultSet bulkCopyHandler, TdsParserStateObject stateObj)
    at System.Data.SqlClient.SqlDataReader.ConsumeMetaData()
    at System.Data.SqlClient.SqlDataReader.get_MetaData()
    at System.Data.SqlClient.SqlCommand.FinishExecuteReader(SqlDataReader ds, RunBehavior runBehavior, String resetOptionsString) at System.Data.SqlClient.SqlCommand.RunExecuteReaderTds(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, Boolean async)
    at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method, DbAsyncResult result)
    at System.Data.SqlClient.SqlCommand.RunExecuteReader(CommandBehavior cmdBehavior, RunBehavior runBehavior, Boolean returnStream, String method)
    at System.Data.SqlClient.SqlCommand.ExecuteScalar()
    ```

    The `SqlCommand` class is used to work with a query, not a connection. The `ExecuteScalar` method is used to run a query. You can also see other items, such as an `ExecuteReader` or `ExecuteNonQuery`.

    If you encounter a query or command timeout error, see [Troubleshoot query time-out errors](../performance/troubleshoot-query-timeouts.md).

## Troubleshoot connection timeout errors in SQL Server

If you encounter a connection timeout error, follow these steps:

1. Increase the connection timeout parameter.

    - If you use an application to connect to SQL Server, increase the relevant connection-timeout parameter values and check whether the connection eventually succeeds. For example, if you use `System.Data.SqlClient`, set the [SqlConnection.ConnectionTimeout](/dotnet/api/system.data.sqlclient.sqlconnection.connectiontimeout) property to **30** or a higher value. If you use the current [Microsoft.Data.SqlClient](/sql/connect/ado-net/microsoft-ado-net-sql-server) driver, set the equivalent [SqlConnection.ConnectionTimeout](/dotnet/api/microsoft.data.sqlclient.sqlconnection.connectiontimeout) property.

        > [!NOTE]
        > If you use other providers, check [Homepage for SQL client programming](/sql/connect/homepage-sql-connection-programming).

    - If you use SQL Server Management Studio (SSMS), select the **Connection Properties** tab in the **Connect to Server** dialog box, and set **Connection time-out setting** to a higher value.

1. If the connection eventually succeeds, it's a network issue. Work with your network administrator to resolve the issue. After it's resolved, you can revert to default settings in your application.

    > [!NOTE]
    > Increasing the connection timeout in the application is a possible method, but it isn't a long-term resolution. This is because the connection occurs quickly (usually within a few milliseconds) when you try to connect to a data source.

## Service, port, and protocol causes of connection timeout errors

The following table lists SQL Server service, port, and network protocol causes of timeout expired errors, and how to resolve each one. For more tips and suggestions, see [Troubleshooting: Timeout Expired](/previous-versions/sql/sql-server-2008-r2/ms190181(v=sql.105)).

|Typical causes  |Resolutions  |
|---------|---------|
|The SQL Server service on the server isn't running.     | Start the instance of the SQL Server Database Engine.        |
|The TCP/IP port for the Database Engine instance is blocked by a firewall.     | Configure the firewall to permit access to the Database Engine.        |
|The Database Engine isn't listening on port 1433. This is because the port is changed, or it isn't the default instance and the SQL Server Browser service isn't running.     | Start the SQL Server Browser service or specify a TCP/IP port number to connect with the `Sqlcmd -S <ip_addres>,<port>` command. In the error log, find the port number that SQL Server is listening on. For more information, see [Configure a server to listen on a specific TCP port](/sql/database-engine/configure-windows/configure-a-server-to-listen-on-a-specific-tcp-port).    |
|The SQL Server Browser service is running but UDP port 1434 is blocked by a firewall.     | Configure the firewall to permit access to UPD port 1434 on the server or specify the TCP/IP port number to connect.        |
|The client and server aren't configured to use the same network protocol.     | Make sure that the server and client computers have at least one enabled protocol in common by using [SQL Server Configuration Manager](/sql/tools/configuration-manager/sql-server-configuration-manager). For example, if the client is connecting by using TCP/IP sockets but SQL Server is only listening on named pipes, no connectivity can be established.        |

## Network and name resolution causes of connection timeout errors

The following table lists network-level causes of timeout expired errors, such as DNS name resolution failures and TCP/IP routing problems, and how to resolve each one.

|Typical causes  |Resolutions  |
|---------|---------|
|Server name was typed incorrectly.     | Try again with the correct server name.        |
|The network can't resolve the server name to an IP address. Test this problem by using the ping or telnet programs.     | Fix the computer name resolution problem on your network or connect to the server by using the IP address. This problem isn't a SQL Server problem. For assistance, see your Windows documentation or contact your network administrator. Use the following command to test connectivity:<br/>`telnet <ServerName> [<Port>]`<br/> `telnet <IP_Address> <Port>` <br/> If using an IP address works, but the server name doesn't work, it's a name resolution issue.        |
|The network can't connect by using the IP address. Test this problem by using the ping, telnet, or [tracert](/windows-server/administration/windows-commands/tracert) program.     | Fix the TCP/IP problem on your network. This problem isn't a SQL Server problem. For assistance, see your Windows documentation or contact your network administrator.<br/> For more advanced network troubleshooting, see [0300 Intermittent or Periodic Network Issue](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/0300-Intermittent-or-Periodic-Network-Issue).         |

## Related content

- [Troubleshoot connectivity issues in SQL Server](../connect/resolve-connectivity-errors-overview.md)
- [Troubleshoot query time-out errors](../performance/troubleshoot-query-timeouts.md)
- [A network-related or instance-specific error occurred while establishing a connection to SQL Server](../connect/network-related-or-instance-specific-error-occurred-while-establishing-connection.md)
- [Collect data to troubleshoot SQL Server connectivity issues](../connect/collect-data-to-troubleshoot-sql-connectivity-issues.md)
- [Intermittent or periodic network issue](../connect/intermittent-periodic-network-issue.md)
- [Microsoft ADO.NET for SQL Server](/sql/connect/ado-net/microsoft-ado-net-sql-server)
