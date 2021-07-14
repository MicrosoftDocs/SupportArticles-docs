# Troubleshooting Query Timeouts

## Error

`Timeout expired. The timeout period elapsed prior to completion of the operation or the server is not responding. The statement has been terminated.`

-or-

`System.Data.SqlClient.SqlException: Timeout expired.  The timeout period elapsed prior to completion of the operation or the server is not responding.`

## Explanation

This error is raised because the application-configured timeout setting was reached and the application aborts the query.  If a query/commmand timeout value is set to say 30 seconds and the query does not return a single packet of data back to the client application within 30 sec, then the application would cancel the query. It's the application's decision to cancel the running query, not the Database Engine and therefore this is an error that comes from the application side. If the timeout value is set to 0 zero (no timeout limit), then the Database engine would execute the query as long as it needs to until completion.
The timeout value is set on the Command object in .NET Framework ([CommandTimeout](/dotnet/api/system.data.sqlclient.sqlcommand.commandtimeout)). In JDBC it is set using [setQueryTimeout](/sql/connect/jdbc/reference/setquerytimeout-method-sqlserverstatement).

A query timeout will cause an Attention event ([error 3617](/sql/relational-databases/errors-events/mssqlserver-3617-database-engine-error)) on the SQL Server side.

Query timeout is different from a Connection timeout property. The latter controls how long it takes to wait for a successful connection and has nothing to do with query execution (see Query Timeout is not the same as Connection Timeout)

## Troubleshooting Steps

1. Please check if the CommandTimeout setting is smaller than the expected query duration. By default, in most drivers and frameworks it's set to 30 seconds. If there is still a query timeout after the user agreed that their setting is acceptable, then this becomes a SQL Server performance issue.

Here is a ADO.NET coding with commandTimeout 1 second

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
            // Setting command timeout to 1 second

            command.CommandTimeout = 1;
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

1. Try to run the query in SSMS/SQLCMD directly, if it takes more than 30 seconds to complete, then you need to take steps to troubleshoot the slow query.
1. If it's fast in SSMS/SQLCMD, but only slow from application. Please refer Scenario: Query is Slow from Application but Fast from SSMS/SQLCMD. The goal is make the settings in SSMS/SQLCMD as same as the settings in application, then reproduce the issue in SSMS/SQLCMD and investigate. 


https://channel9.msdn.com/Series/SQL-Workshops/SQL-Server-Command-Timeout-Application-Timeout-Extended-Event-Attention

## Query Timeout is not the same as Connection Timeout

Query timeout is different from Connection/Login timeout. These occur when the initial connection to the database server takes a long time and reaches a pre-defined time out period. At this stage no query has been submitted to the server.
These are examples of a connection or login timeout errors:

`Connection Timeout Expired. The timeout period elapsed while attempting to consume the pre-login handshake acknowledgment. This could be because the pre-login handshake failed or the server was unable to respond back in time.The duration spent while attempting to connect to this server was [Pre-Login] initialization=23; handshake=14979;`

`Timeout expired.  The timeout period elapsed prior to completion of the operation or the server is not responding. System.ComponentModel.Win32Exception (0x80004005): The wait operation timed out.`
