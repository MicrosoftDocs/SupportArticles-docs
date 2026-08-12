---
title: Troubleshoot Query Timeout Errors in SQL Server
description: Troubleshoot query timeout errors in SQL Server by tracing attention events, correlating completed events, and tuning the slow query behind them.
ms.date: 08/07/2026
ms.custom: sap:SQL resource usage and configuration (CPU, Memory, Storage)
ms.reviewer: jopilov
---

# Troubleshoot query timeout errors

## Summary

A query timeout error in SQL Server occurs when a query doesn't return data before the client application's command timeout expires. The client application then cancels the query and reports "Timeout expired." This article explains how to confirm that a query timeout (not a connection timeout) occurred, how to identify the specific query by correlating the `attention` event with `sql_batch_completed` and `rpc_completed` extended events, and how to set the command timeout in ADO.NET, ODBC, JDBC, OLE DB, and ADO. The most common cause is a slow query, so the recommended fix is to tune the query rather than only raise the timeout value. Use this article when an application reports timeout errors while SQL Server records Attention events (error 3617) with a duration that closely matches the configured timeout.

## Symptoms of a query timeout error

Assume that an application queries data from a SQL Server database. If the query doesn't return any data within the configured timeout value (typically 30 seconds), the application cancels the query and generates one of these error messages:

- > Timeout expired. The timeout period elapsed prior to completion of the operation or the server is not responding. The statement has been terminated.

- > System.Data.SqlClient.SqlException: Timeout expired.  The timeout period elapsed prior to completion of the operation or the server is not responding.

## Why query timeout errors occur

These errors occur on the application side. The application sets a timeout value and if the timeout is reached, it cancels the query. On the SQL Server side, a query cancellation from the client side causes an Attention event, error 3617 ([MSSQLSERVER_3617](/sql/relational-databases/errors-events/mssqlserver-3617-database-engine-error)). If the timeout value on the application side is set to *0* (no time limit), the Database Engine executes the query until it's completed, regardless of how long that is, milliseconds or days.

The timeout value is set differently for each data access driver or API:

- In .NET Framework [System.Data.SqlClient](/dotnet/api/system.data.sqlclient), the time-out value is set on the [CommandTimeout](/dotnet/api/system.data.sqlclient.sqlcommand.commandtimeout) property.
- In [Microsoft.Data.SqlClient](/sql/connect/ado-net/microsoft-ado-net-sql-server), the current ADO.NET driver for SQL Server, it's set on the [SqlCommand.CommandTimeout](/dotnet/api/microsoft.data.sqlclient.sqlcommand.commandtimeout) property.
- In ODBC API, it's set through the `SQL_ATTR_QUERY_TIMEOUT` attribute in the [SQLSetStmtAttr](/sql/odbc/reference/syntax/sqlsetstmtattr-function) function.
- In Java Database Connectivity (JDBC) API, it's set through the [setQueryTimeout](/sql/connect/jdbc/reference/setquerytimeout-method-sqlserverstatement) method.
- In OLEDB, it's set through the `DBPROP_COMMANDTIMEOUT` property on the `DBPROP` structure.
- In VBA (Excel), it's set through the [ADODB.Command.CommandTimeout](/sql/ado/reference/ado-api/commandtimeout-property-ado) property.

Query timeout is different from a connection timeout property. The latter controls how long to wait for a successful connection and isn't involved in query execution. For more information, see [Query timeout isn't the same as connection timeout](#query-timeout-isnt-the-same-as-connection-timeout).

## Steps to identify and resolve the query that times out

The most common reason for query timeouts is underperforming queries. This means that the query runs longer than the predefined query timeout value. Make the query run faster to resolve this issue. Here's how to check queries:

1. Use [Extended Events](/sql/relational-databases/extended-events/extended-events) or [SQL Trace](/sql/relational-databases/sql-trace/sql-trace) to identify the queries that cause the timeout errors. You can trace the [attention](/sql/relational-databases/event-classes/attention-event-class) event together with the `sql_batch_completed` and `rpc_completed` extended events, and correlate them on the same `session_id`. If you observe that a completed event is immediately followed by an attention event, and the duration of the completed event approximately corresponds to the timeout setting, then you identified the query. Here's an example:

   > [!NOTE]
   > In the example, the `SELECT` query runs for almost exactly 30 seconds and stops. The attention event with the same session ID indicates that the application canceled the query.

   |     Name                   |     Session_id    |     Sql_text                                      |     Duration (microseconds)    |     Timestamp                   |
   |----------------------------|-------------------|---------------------------------------------------|--------------------------------|---------------------------------|
   |     sql_batch_started      |     54            |     Select … from Customers WHERE cid = 192937    |     NULL                       |     2021-09-30 09:50:25.0000    |
   |     sql_batch_completed    |     54            |     Select … from Customers WHERE cid = 192937    |     29999981                   |     2021-09-30 09:50:55.0000    |
   |     Attention              |     54            |     Select … from Customers WHERE cid = 192937    |     40000                      |     2021-09-30 09:50:55.0400    |

1. Execute and test the queries in [sqlcmd](/sql/tools/sqlcmd/sqlcmd-utility) or in SQL Server Management Studio (SSMS).

1. If the queries are also slow in sqlcmd and SSMS, troubleshoot and improve the performance of the queries. For detailed information, see [Troubleshoot slow-running queries in SQL Server](troubleshoot-slow-running-queries.md).

   > [!NOTE]
   > In sqlcmd and SSMS, the timeout value is set to *0* (no time limit) and you can test and investigate the queries.

1. If the queries are fast in sqlcmd and SSMS, but slow on the application side, change the queries to use the same [SET options](/sql/t-sql/statements/set-statements-transact-sql) used in sqlcmd and SSMS. Compare the SET options by collecting an Extended Events trace (login and connecting events with `collect_options_text`) and check the `options_text` column. Here's an example:

    ```sql
    ALTER EVENT SESSION [setOptions] ON SERVER 
    ADD EVENT sqlserver.existing_connection(SET collect_options_text=(1) 
        ACTION(package0.event_sequence,package0.last_error,sqlos.system_thread_id,sqlserver.context_info,sqlserver.session_id,sqlserver.sql_text)), 
    ADD EVENT sqlserver.login(SET collect_options_text=(1)
        ACTION(sqlos.system_thread_id,sqlserver.context_info,sqlserver.sql_text))
    ```

    For more information, see [Troubleshoot query performance difference between database application and SSMS](troubleshoot-application-slow-ssms-fast.md).

1. Check if the `CommandTimeout` setting is smaller than the expected query duration. If the user's setting is correct and timeouts still occur, it's because of a query performance issue. Here's an ADO.NET code example with a timeout value set to *10* seconds:

    ```csharp
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Threading.Tasks;
    using System.Data.SqlClient;
    using System.Data;
    
    namespace ConsoleApplication6
    {
        class Program
        {
            static void Main()
            {
                string ConnectionString = @"Data Source=.\sql2019;Integrated Security=SSPI;Initial Catalog=tempdb;";
                string queryString = "exec test";
        
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    connection.Open();
                    SqlCommand command = new SqlCommand(queryString, connection);
                    
                    // Setting command timeout to 10 seconds
                    command.CommandTimeout = 10;
                    //command.ExecuteNonQuery();
                    try {
                        command.ExecuteNonQuery();
                    }
                    catch (SqlException e) {
                        Console.WriteLine("Got expected SqlException due to command timeout ");
                        Console.WriteLine(e);
                    }
                }
            }
        }
    }
    ```

## Query timeout isn't the same as connection timeout

A query timeout is different from a connection timeout or login timeout. The connection or login timeout occurs when the initial connection to the database server reaches a predefined timeout period. At this point, the client hasn't sent any query to the server. These messages are examples of connection timeout or login timeout errors:

- > Connection Timeout Expired. The timeout period elapsed while attempting to consume the pre-login handshake acknowledgment. This could be because the pre-login handshake failed or the server was unable to respond back in time. The duration spent while attempting to connect to this server was [Pre-Login] initialization=23; handshake=14979;

- > Timeout expired. The timeout period elapsed prior to completion of the operation or the server is not responding. System.ComponentModel.Win32Exception (0x80004005): The wait operation timed out.

The connection time-out value is a client-side setting and is typically set to 15 seconds. For more information about how to troubleshoot connection time-out, see [Troubleshoot connection timeout errors](../connect/timeout-expired-error.md).

## Related content

- [Video - SQL Server command timeout](/shows/sql-workshops/sql-server-command-timeout-application-timeout-extended-event-attention)
- [Timeout expired messages when connecting to SQL Server](../connect/timeout-expired-error.md)
- [Troubleshoot slow-running queries in SQL Server](troubleshoot-slow-running-queries.md)
- [Troubleshoot query performance difference between database application and SSMS](troubleshoot-application-slow-ssms-fast.md)
- [Understand and resolve blocking problems in SQL Server](understand-resolve-blocking.md)
- [Troubleshoot a query that never ends in SQL Server](troubleshoot-never-ending-query.md)
- [Configure the remote query timeout server configuration option](/sql/database-engine/configure-windows/configure-the-remote-query-timeout-server-configuration-option)
