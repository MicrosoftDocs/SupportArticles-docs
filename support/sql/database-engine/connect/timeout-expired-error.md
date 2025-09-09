---
title: Timeout expired messages when connecting to SQL Server
description: Fixes timeout expired errors when you connect to SQL Server and helps you verify and troubleshoot the errors.
ms.date: 01/10/2025
ms.custom: sap:Database Connectivity and Authentication
author: aartig13
ms.author: aartigoyle
ms.reviewer: jopilov
---
# Timeout expired messages when connecting to SQL Server

_Applies to:_ &nbsp; SQL Server

> [!NOTE]
> Before you start troubleshooting, check the [prerequisites](../connect/resolve-connectivity-errors-checklist.md) and go through the checklist.

A timeout error means that a certain operation takes longer than needed. The client application stops the operation (instead of waiting indefinitely), which may block other operations and suspend an application. This article provides resolutions for "command-timeout" and "connection-timeout" errors you receive when you connect to SQL Server.

## Verify timeout expired errors

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

  If connections aren't closed correctly, errors may occur. These errors occur because all pooled connections are in use, and max pool size is reached. You can avoid these errors if you follow the steps described in the [exhausted the connection pool](/archive/blogs/spike/timeout-expired-the-timeout-period-elapsed-prior-to-obtaining-a-connection-from-the-pool) article.

> [!NOTE]
> The second and the third error occur when .NET Framework 4.5 or a later version is installed.

## Determine the type of timeout expired errors

From a connectivity perspective, you encounter the following timeout issues:

- Connection timeout (15 seconds by default)
- Query or command timeout (30 seconds by default)

> [!NOTE]
> The default values can be set through code, connecting string, or other methods.

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

## Troubleshoot timeout expired errors

- If you encounter a query or command-timeout error, see [Troubleshoot query time-out errors](../performance/troubleshoot-query-timeouts.md).

- If you encounter a connection-timeout error, follow the steps:

    1. Increase the connection-timeout parameter.

        - If you use an application to connect to SQL Server, increase the relevant connection-timeout parameter values and check whether the connection eventually succeeds. For example, if you use `System.Data.SqlClient`, set the [SqlConnection.ConnectionTimeout](/dotnet/api/system.data.sqlclient.sqlconnection.connectiontimeout) property to **30** or a higher value.

            > [!NOTE]
            > If you use other providers, check [Homepage for SQL client programming](/sql/connect/homepage-sql-connection-programming).

        - If you use SQL Server Management Studio (SSMS), select the **Connection Properties** tab in the **Connect to Server** dialog box, and set **Connection time-out setting** to a higher value.

    1. If the connection eventually succeeds, it's a network issue. You need to work with your network administrator to resolve the issue. After it's resolved, you can revert to default settings in your application.

        > [!NOTE]
        > Increasing the connection timeout in the application is a possible method, but it isn't a long-term resolution. This is because the connection occurs quickly (usually within a few milliseconds) when you try to connect to a data source.

## Typical causes and resolutions for the error

The following table lists typical causes and resolutions for timeout expired errors. For more tips and suggestions, see [Troubleshooting: Timeout Expired](/previous-versions/sql/sql-server-2008-r2/ms190181(v=sql.105)).

|Typical causes  |Resolutions  |
|---------|---------|
|Server name was typed incorrectly.     | Try again with the correct server name.        |
|The SQL Server service on the server isn't running.     | Start the instance of the SQL Server Database Engine.        |
|The TCP/IP port for the Database Engine instance is blocked by a firewall.     | Configure the firewall to permit access to the Database Engine.        |
|The Database Engine isn't listening on port 1433. This is because the port is changed, or it isn't the default instance and the SQL Server Browser service isn't running.     | Start the SQL Server Browser service or specify a TCP/IP port number to connect with the `Sqlcmd -S <ip_addres>,<port>` command. In the error log, find the port number that SQL Server is listening on.    |
|The SQL Server Browser service is running but UDP port 1434 is blocked by a firewall.     | Configure the firewall to permit access to UPD port 1434 on the server or specify the TCP/IP port number to connect.        |
|The client and server aren't configured to use the same network protocol.     | Make sure that the server and client computers have at least one enabled protocol in common by using SQL Server Configuration Manager. For example, if the client is connecting by using TCP/IP sockets but SQL Server is only listening on named pipes, no connectivity can be established.        |
|The network can't resolve the server name to an IP address—this can be tested by using the ping or telnet programs.     | Fix the computer name resolution problem on your network or connect to the server by using the IP address—this isn't a SQL Server problem. For assistance, see your Windows documentation or contact your network administrator. Use the following command to test connectivity:<br/>`telnet <ServerName> [<Port>]`<br/> `telnet <IP_Address> <Port>` <br/> If using an IP address works, but the server name doesn't work, it's a name resolution issue.        |
|The network can't connect by using the IP address—this can be tested by using the ping, telnet, or [tracert](/windows-server/administration/windows-commands/tracert) program.     | Fix the TCP/IP problem on your network—this isn't a SQL Server problem. For assistance, see your Windows documentation or contact your network administrator.<br/> For more advanced network troubleshooting, see [0300 Intermittent or Periodic Network Issue](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/0300-Intermittent-or-Periodic-Network-Issue).         |

## See also

- [Troubleshoot connectivity issues in SQL Server](../connect/resolve-connectivity-errors-overview.md)

