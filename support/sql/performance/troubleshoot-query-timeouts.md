---
title: Troubleshoot query time-out errors
description: This article describes how to troubleshoot the time-out errors when you run slow-running queries.
ms.date: 09/22/2021
ms.prod-support-area-path: Performance
ms.topic: troubleshooting
ms.prod: sql
---

# Troubleshoot query time-out errors

## Symptoms

Assume that an application queries data from a SQL Server database. If the query doesn't return any data within the configured time-out value (typically 30 seconds), the application cancels the query, and you receive one of the following error messages:

- > Timeout expired. The timeout period elapsed prior to completion of the operation or the server is not responding. The statement has been terminated.

- > System.Data.SqlClient.SqlException: Timeout expired.  The timeout period elapsed prior to completion of the operation or the server is not responding.

> [!NOTE]
> These errors occur on the application side. On the SQL Server side, a query time-out causes an Attention event ([error 3617](/sql/relational-databases/errors-events/mssqlserver-3617-database-engine-error)). If the time-out value is set to *0* (no time limit), the Database Engine executes the query until it's completed. The time-out value is set on the [CommandTimeout](/dotnet/api/system.data.sqlclient.sqlcommand.commandtimeout) property in .NET Framework.
>
> - In ODBC API, it's set through the `SQL_ATTR_QUERY_TIMEOUT` attribute of the [SQLSetStmtAttr](/sql/odbc/reference/syntax/sqlsetstmtattr-function?view=sql-server-ver15) function.
> - In Java Database Connectivity (JDBC) API, it's set through the [setQueryTimeout](/sql/connect/jdbc/reference/setquerytimeout-method-sqlserverstatement) method.

## Cause

These errors are caused by slow-running queries or performance issues with the queries themselves.

## Resolution

Change the time-out value if it's smaller than the expected query duration. Alternatively, identify and fix the slow-running queries.

1. Use [Extended Events](/sql/relational-databases/extended-events/extended-events) and [SQL Trace](/sql/relational-databases/sql-trace/sql-trace) to identify the queries that cause the time-out errors.
2. Execute and test the queries in SQLCMD mode or in SQL Server Management Studio (SSMS).
    - If the queries are slow in SQLCMD and SSMS as well, troubleshoot and change the queries.  
    **Note:** In SQLCMD and SSMS, the time-out value is set to *0* (no time limit) and the queries can be tested.
    - If the queries are fast in SQLCMD and SSMS, change the queries to use the same set options that are used in SQLCMD and SSMS. Compare the set options by collecting an Extended Events trace (login and connecting events with `collect_options_text`) and check the `options_text` column. Here's an example:

        ```tsql
        ALTER EVENT SESSION [setOptions] ON SERVER 
        ADD EVENT sqlserver.existing_connection(SET collect_options_text=(1) 
            ACTION(package0.event_sequence,package0.last_error,sqlos.system_thread_id,sqlserver.context_info,sqlserver.session_id,sqlserver.sql_text)), 
        ADD EVENT sqlserver.login(SET collect_options_text=(1)
            ACTION(sqlos.system_thread_id,sqlserver.context_info,sqlserver.sql_text))
        ```

## More information

A query time-out isn't the same as a connection or login time-out. The connection or login timeout sets the time to wait for a successful connection or login. During this period, no query is submitted to the database server. If the initial connection to the database server exceeds the configured time-out value, you receive one of the following error messages:

- > Connection Timeout Expired. The timeout period elapsed while attempting to consume the pre-login handshake acknowledgment. This could be because the pre-login handshake failed or the server was unable to respond back in time. The duration spent while attempting to connect to this server was [Pre-Login] initialization=23; handshake=14979;

- > Timeout expired. The timeout period elapsed prior to completion of the operation or the server is not responding. System.ComponentModel.Win32Exception (0x80004005): The wait operation timed out.

For more information, see the steps to [troubleshoot connection timeout](/previous-versions/sql/sql-server-2008-r2/ms190181(v=sql.105)) and a video that [demonstrates query timeout troubleshooting](https://channel9.msdn.com/Series/SQL-Workshops/SQL-Server-Command-Timeout-Application-Timeout-Extended-Event-Attention).

Here's an ADO.NET code example with a time-out value set to *10* seconds:

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
