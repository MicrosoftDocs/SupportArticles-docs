---
title: Determine the authentication type
description: This article explains about how to determine the type of authentication that's used when you connect to SQL Server.
ms.date: 04/03/2025
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
ms.custom: sap:Database Connectivity and Authentication
ms.topic: how-to
---

# How to determine if the authentication type is Kerberos

This article provides a query to help you determine the type of authentication that's used when you connect to Microsoft SQL Server. Make sure that you run the query on a client computer, not on the SQL Server that you're testing. Otherwise the query returns `auth_scheme` as **NTLM** even if Kerberos is configured correctly. This occurs because of a per-service SID security hardening feature that was added in Windows 2008. This feature forces all local connections to use NTLM regardless of whether Kerberos is available.

 ```sql
  SELECT auth_scheme FROM sys.dm_exec_connections WHERE session_id=@@SPID
 ```

## Use SQL Server Management Studio

Run the following query in SQL Server Management Studio:

```sql
SELECT c.session_id, c.net_transport, c.encrypt_option,
       c.auth_scheme, s.host_name, @@SERVERNAME as "remote_name",
       s.program_name, s.client_interface_name, s.login_name,
       s.nt_domain, s.nt_user_name, s.original_login_name,
       c.connect_time, s.login_time
FROM sys.dm_exec_connections AS c
JOIN sys.dm_exec_sessions AS s ON c.session_id = s.session_id
WHERE c.session_id=@@SPID
```

## Use the command line

Run the following query at a command prompt:

```sql
C:\Temp>sqlcmd -S SQLProd01 -E -Q "select auth_scheme from sys.dm_exec_connections where session_id=@@SPID"
auth_scheme
----------------------------------------
NTLM

(1 rows affected)
```

## Alternative method

If either of the previous options aren't available, consider using the following alternative procedure:

1. Copy the following script into a text editor, such as Notepad, and save it as *getAuthScheme.vbs*:

     ```vbscript
     ' Auth scheme VB script.
     ' Run on a client machine, not the server.
     ' If you run locally, you will always get NTLM even if Kerberos is properly enabled.
     '
     ' USAGE:  CSCRIPT getAuthScheme.vbs tcp:SQLProd01.contoso.com,1433   ' explicitly specify DNS suffix, protocol, and port # ('tcp' must be lower case)
     ' USAGE:  CSCRIPT getAuthScheme.vbs SQLProd01                        ' let the driver figure out the DNS suffix, protocol, and port #
     '
     Dim cn, rs, s
     s = WScript.Arguments.Item(0)              ' get the server name from the command-line
     Set cn = createobject("adodb.connection")
     '
     ' Various connection strings depending on the driver/Provider installed on your machine
     ' SQLOLEDB is selected as it is on all windows machines, but may have limitations, such as lack of TLS 1.2 support
     ' Choose a newer provider or driver if you have it installed.
     '
     cn.open "Provider=SQLOLEDB;Data Source=" & s & ";Initial Catalog=master;Integrated Security=SSPI"          ' On all Windows machines
     'cn.open "Provider=SQLNCLI11;Data Source=" & s & ";Initial Catalog=master;Integrated Security=SSPI"        ' Newer
     'cn.open "Provider=MSOLEDBSQL;Data Source=" & s & ";Initial Catalog=master;Integrated Security=SSPI"       ' Latest, good for SQL 2012 and newer
     'cn.open "Driver={ODBC Driver 17 for SQL Server};Server=" & s & ";Database=master;Trusted_Connection=Yes"  ' Latest
     '
     ' Run the query and display the results
     '
     set rs = cn.Execute("select auth_scheme from sys.dm_exec_connections where session_id=@@SPID")
     WScript.Echo "Auth scheme: " & rs(0)
     rs.close
     cn.close
     ```

1. Run the *getAuthScheme.vbs* PowerShell script at a command prompt:

    ```powershell
    C:\Temp>cscript getAuthScheme.vbs SQLProd01
    ```

    You should see the following output:

    ```output
    Microsoft (R) Windows Script Host Version 5.812
    Copyright (C) Microsoft Corporation. All rights reserved.
    Auth scheme: NTLM
    ```

## Use PowerShell

You can use PowerShell to test the SqlClient .NET provider to try to isolate the issue from your application:

1. Copy the following script into a text editor, such as Notepad, and save it as *get-SqlAuthScheme.ps1*.
1. Run the following script at a command prompt:

      ```powershell
     #-------------------------------
     #
     # get-SqlAuthScheme.ps1
     #
     # PowerShell script to test a System.Data.SqlClient database connection
     #
     # USAGE: 
     #   .\get-SqlAuthScheme tcp:SQLProd01.contoso.com,1433   # Explicitly specify DNS suffix, protocol, and port ('tcp' must be lowercase)
     #   .\get-SqlAuthScheme SQLProd01                        # Let the driver figure out the DNS suffix, protocol, and port
     #
     #-------------------------------
 
     # Define a parameter for the server name, defaulting to "localhost" if not provided
     param ([string]$server = "localhost")
 
     # Set the execution policy for the current user to Unrestricted
     Set-ExecutionPolicy Unrestricted -Scope CurrentUser
 
     # Build the connection string for the SQL Server connection
     $connstr = "Server=$server;Database=master;Integrated Security=SSPI"
 
     # Create a new SQL connection object
     [System.Data.SqlClient.SqlConnection] $conn = New-Object System.Data.SqlClient.SqlConnection
     $conn.ConnectionString = $connstr
 
     # Record the start time of the operation
     [System.DateTime] $start = Get-Date
 
     # Open the SQL connection
     $conn.Open()
 
     # Create a new SQL command object
     [System.Data.SqlClient.SqlCommand] $cmd = New-Object System.Data.SqlClient.SqlCommand
     $cmd.CommandText = "select auth_scheme from sys.dm_exec_connections where session_id=@@spid" # Query to get the authentication scheme
     $cmd.Connection = $conn
 
     # Execute the query and retrieve the result
     $dr = $cmd.ExecuteReader()
     $result = $dr.Read() # Read the first row of the result set
     $auth_scheme = $dr.GetString(0) # Get the authentication scheme from the first column
 
     # Close and dispose of the SQL connection
     $conn.Close()
     $conn.Dispose()
 
     # Record the end time of the operation
     [System.DateTime] $end = Get-Date
 
     # Calculate the elapsed time
     [System.Timespan] $span = ($end - $start)
 
     # Output the results
 
     "Elapsed time was " + $span.Milliseconds + " ms."    # Display the elapsed time in milliseconds
     "Auth scheme for " + $server + ": " + $auth_scheme   # Display the authentication scheme for the server
     ```

You should see the following output:

   ```output
   C:\temp> .\get-sqlauthscheme sqlprod01
   Elapsed time was 0 ms.
   Auth scheme for sqlprod01: NTLM
   ```

## More information

[Consistent authentication issues in SQL Server](consistent-authentication-connectivity-issues.md)
