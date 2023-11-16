---
title: Troubleshoot query time-out errors
description: This article describes how to troubleshoot the time-out errors when you run slow-running queries.
ms.date: 07/03/2023
ms.custom: sap:Performance
ms.topic: troubleshooting
author: pijocoder
ms.author: jopilov
---

# Troubleshoot query time-out errors

## Symptoms

Assume that an application queries data from a SQL Server database. If the query doesn't return any data within the configured time-out value (typically 30 seconds), the application cancels the query and generates one of these error messages:

- > Timeout expired. The timeout period elapsed prior to completion of the operation or the server is not responding. The statement has been terminated.

- > System.Data.SqlClient.SqlException: Timeout expired.  The timeout period elapsed prior to completion of the operation or the server is not responding.

## Explanation

These errors occur on the application side. The application sets a time-out value and if the time out is reached, it cancels the query. On the SQL Server side, a query cancellation from the client side causes an Attention event, error 3617 ([MSSQLSERVER_3617](/sql/relational-databases/errors-events/mssqlserver-3617-database-engine-error)). If the time-out value on the application side is set to *0* (no time limit), the Database Engine executes the query until it's completed.

- In .NET Framework [System.Data.SqlClient](/dotnet/api/system.data.sqlclient), the time-out value is set on the [CommandTimeout](/dotnet/api/system.data.sqlclient.sqlcommand.commandtimeout) property.
- In ODBC API, it's set through the `SQL_ATTR_QUERY_TIMEOUT` attribute in the [SQLSetStmtAttr](/sql/odbc/reference/syntax/sqlsetstmtattr-function) function.
- In Java Database Connectivity (JDBC) API, it's set through the [setQueryTimeout](/sql/connect/jdbc/reference/setquerytimeout-method-sqlserverstatement) method.
- In OLEDB, it's set through the `DBPROP_COMMANDTIMEOUT` property on the `DBPROP` structure.
- In VBA (Excel), it's set through the [ADODB.Command.CommandTimeout](/sql/ado/reference/ado-api/commandtimeout-property-ado) property.

Query time-out is different from a connection time-out property. The latter controls how long to wait for a successful connection and isn't involved in query execution. For more information, see [Query time-out is not the same as connection time-out](#query-time-out-is-not-the-same-as-connection-time-out).

## Troubleshooting steps

By far, the most common reason for query time-outs is underperforming queries. That means that the query runs longer than the predefined query time-out value. Making the query run faster is the recommended first target of your troubleshooting. Here's how to check queries:

1. Use [Extended Events](/sql/relational-databases/extended-events/extended-events) or [SQL Trace](/sql/relational-databases/sql-trace/sql-trace) to identify the queries that cause the time-out errors. You can trace the [attention](/sql/relational-databases/event-classes/attention-event-class) event together with the `sql_batch_completed` and `rpc_completed` extended events, and correlate them on the same `session_id`. If you observe that a completed event is immediately followed by an attention event, and the duration of the completed event corresponds approximately to the time-out setting, then you've identified the query. Here's an example:

   > [!NOTE]
   > In the example, the `SELECT` query ran for almost exactly 30 seconds and stopped. The attention event having the same session ID indicates that the query was canceled by the application.

   |     Name                   |     Session_id    |     Sql_text                                      |     Duration (microseconds)    |     Timestamp                   |
   |----------------------------|-------------------|---------------------------------------------------|--------------------------------|---------------------------------|
   |     sql_batch_started      |     54            |     Select … from Customers WHERE cid = 192937    |     NULL                       |     2021-09-30 09:50:25.0000    |
   |     sql_batch_completed    |     54            |     Select … from Customers WHERE cid = 192937    |     29999981                   |     2021-09-30 09:50:55.0000    |
   |     Attention              |     54            |     Select … from Customers WHERE cid = 192937    |     40000                      |     2021-09-30 09:50:55.0400    |

3. Execute and test the queries in SQLCMD or in SQL Server Management Studio (SSMS).

3. If the queries are also slow in SQLCMD and SSMS, troubleshoot and improve the performance of the queries. For detailed information, see [Troubleshoot slow-running queries in SQL Server](troubleshoot-slow-running-queries.md)

   > [!NOTE]
   > In SQLCMD and SSMS, the time-out value is set to *0* (no time limit) and the queries can be tested and investigated.

4. If the queries are fast in SQLCMD and SSMS, but slow on the application side, change the queries to use the same [SET options](/sql/t-sql/statements/set-statements-transact-sql) used in SQLCMD and SSMS. Compare the SET options by collecting an Extended Events trace (login and connecting events with `collect_options_text`) and check the `options_text` column. Here's an example:

    ```tsql
    ALTER EVENT SESSION [setOptions] ON SERVER 
    ADD EVENT sqlserver.existing_connection(SET collect_options_text=(1) 
        ACTION(package0.event_sequence,package0.last_error,sqlos.system_thread_id,sqlserver.context_info,sqlserver.session_id,sqlserver.sql_text)), 
    ADD EVENT sqlserver.login(SET collect_options_text=(1)
        ACTION(sqlos.system_thread_id,sqlserver.context_info,sqlserver.sql_text))
    ```

    For more information, see [Troubleshoot query performance difference between database application and SSMS](troubleshoot-application-slow-ssms-fast.md).

5. Check if the `CommandTimeout` setting is smaller than the expected query duration. If the user's setting is correct and time-outs still occur, it's because of a query performance issue. Here's an ADO.NET code example with a time-out value set to *10* seconds:

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
                string ConnectionString = "Data Source=.\sql2019;Integrated Security=SSPI;Initial Catalog=tempdb;";
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

## Query time-out is not the same as connection time-out

A query time-out is different from a connection time-out or login time-out. The connection or login timeout occurs when the initial connection to the database server reaches a predefined time-out period. At this stage, no query has been submitted to the server. These messages are examples of connection or login time-out error:

- > Connection Timeout Expired. The timeout period elapsed while attempting to consume the pre-login handshake acknowledgment. This could be because the pre-login handshake failed or the server was unable to respond back in time. The duration spent while attempting to connect to this server was [Pre-Login] initialization=23; handshake=14979;

- > Timeout expired. The timeout period elapsed prior to completion of the operation or the server is not responding. System.ComponentModel.Win32Exception (0x80004005): The wait operation timed out.

The connection time-out value is a client-side setting and is typically set to 15 seconds. For more information about how to troubleshoot connection time-out, see [troubleshoot connection timeout](/previous-versions/sql/sql-server-2008-r2/ms190181(v=sql.105)). For query timeout troubleshooting, watch this [video](https://channel9.msdn.com/Series/SQL-Workshops/SQL-Server-Command-Timeout-Application-Timeout-Extended-Event-Attention).
