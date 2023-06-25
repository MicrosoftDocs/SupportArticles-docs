---
title: Use server name parameter in a connection string
description: This article describes how to programmatically specify the client network library in the connection string when you connect to a SQL Server database.
ms.date: 09/25/2020
ms.custom: sap:MDAC and ADO
ms.reviewer: VIKRAMV
ms.topic: how-to
---
# Use the server name parameter in a connection string to specify the client network library

## Summary

This article describes how to programmatically specify the client network library in the connection string when you connect to a SQL Server database.

In Microsoft Data Access Components (MDAC) 2.6 and later, you can specify the client access library by using the **server name** parameter in connection string. Therefore, you can specify a specific client access library when you are prompted by an application for a server name to which to connect. This behavior can be useful when you are testing and troubleshooting connectivity issues for SQL Server.

For example, you can use the Osql command-line utility to connect to SQL Server and to force it to use the TCP/IP network library:

```console
osql -Stcp:myServer,portNumber -E
```

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 313295

## Code Sample

The following Microsoft Visual C# .NET code sample demonstrates how to set the connection string. The connection string has the same format irrespective of the language that you use:

```csharp
using System;
using System.Data;
using System.Data.SqlClient;

namespace getCurrentProtocol
{
    /// <summary>
    /// Main Application Driver Class
    /// </summary>
    class Driver
    {
        static void Main(string[] args)
        {
            string sCxn = "server=myServer;Integrated Security=SSPI; database=master";
            //string sCxn = "server=np:myServer;Integrated Security=SSPI; database=master";
            //string sCxn = "server=tcp:myServer;Integrated Security=SSPI; database=master";
            //string sCxn = "server=rpc:myServer;Integrated Security=SSPI; database=master";
            //string sCxn = "server=lpc:myServer;Integrated Security=SSPI; database=master";
            string sCmd = "SELECT net_library from sysprocesses where spid=@@spid";
            SqlConnection cxn = new SqlConnection(sCxn);
            SqlCommand sqlCmd = new SqlCommand(sCmd, cxn);
            SqlDataAdapter sqlDa = new SqlDataAdapter(sCmd, cxn);
            DataTable dt = new DataTable();
            try 
            {
                sqlDa.Fill(dt);
                Console.WriteLine("Hit ENTER to continue ...");
                Console.ReadLine();
                foreach (DataRow dr in dt.Rows)
                Console.WriteLine(dr["net_library"]);
            } 
            catch (SqlException e)
            {
                Console.WriteLine(e.StackTrace);
                Console.WriteLine("SQL Error Number: " + e.Number);
                Console.WriteLine("SQL Error Message: " + e.Message);
            }
        }
    }
}
```

> [!NOTE]
> The connection string and particularly the value of the server parameter:

```csharp
string sCxn = "server=myServer;Integrated Security=SSPI; database=northwind"
```

### Use the Code Sample with Various Network Libraries

The following code samples demonstrate how to use the value of the server parameter to specify various network libraries:

- TCP/IP:

    ```csharp
    server=tcp:hostname
    ```
  
    You can optionally specify a specific port number. By default, the port is 1433.
  
    ```csharp
    server=tcp:hostname, portNumber
    ```

- Named Pipes:

    ```csharp
    server=np:hostname
    ```
  
    You can optionally specify a specific named pipe.
  
    ```csharp
    server=np:\\hostname\pipe\pipeName
    ```
  
    By default, the pipe name is sql\query. If you connect to a named instance, the pipe name is typically in the following format:
  
    `MSSQL$instnaceName\sql\query`

- The default value of the underlying protocol is determined by the operating system settings where a protocol can have any one of the following values:

    |Value|Underlying Protocol|
    |---|---|
    |ncacn_np|Named Pipes|
    |ncacn_ip_tcp|Transmission Control Protocol/Internet Protocol (TCP/IP)|
    |ncalrpc|Local procedure call|

- Shared Memory:

    ```csharp
    server=lpc:hostname
    ```

## References

For more information, see [Appendix A: Registry Entries](/previous-versions/aa470051(v=msdn.10)).
