---
title: Determine the authentication type
description: This article explains about how to determine the type of authentication. 
ms.date: 12/18/2023
author: Malcolm-Stewart
ms.author: mastewa
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
ms.custom: sap:Connection issues
---

# How to determine if you're connected to SQL Server using Kerberos authentication

This article helps you to determine the type of authentication by running a query. Following is a basic query to determine your authentication type. Make sure to run this on a client machine and not on the SQL Server that you're testing. Otherwise the query returns `auth_scheme` as NTLM even if Kerberos is properly configured. This is due to per-service SID security hardening feature added in Windows 2008, which makes all local connections use NTLM regardless of whether Kerberos is available.

 ```sql
  SELECT auth_scheme FROM sys.dm_exec_connections WHERE session_id=@@SPID
 ```

## Using SQL Server Management Studio

You can run the following query from the SSMS.

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

## Using command line

Run the following query using the command line.

```sql
C:\Temp>sqlcmd -S SQLProd01 -E -Q "select auth_scheme from sys.dm_exec_connections where session_id=@@SPID"
auth_scheme
----------------------------------------
NTLM

(1 rows affected)
```

If either of the previous two options aren't available, consider copying the following script into a Notepad and saving it as *getAuthScheme.vbs*.

```vbs
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

Now, run the following *getAuthScheme.vbs* PowerShell script from the command prompt:

```powershell
C:\Temp>cscript getAuthScheme.vbs SQLProd01
```

You can observe the following results:

```output
Microsoft (R) Windows Script Host Version 5.812
Copyright (C) Microsoft Corporation. All rights reserved.
Auth scheme: NTLM
```

## Using PowerShell to run the query

You can also use a PowerShell script to test the SqlClient .NET Provider and try to isolate the issue from your application.

```powershell
#-------------------------------
#
# get-SqlAuthScheme.ps1
#
# PowerShell script to test a System.Data.SqlClient database connection
#
# USAGE: .\get-SqlAuthScheme tcp:SQLProd01.contoso.com,1433   ' explicitly specify DNS suffix, protocol, and port # ('tcp' must be lower case)
# USAGE: .\get-SqlAuthScheme SQLProd01                        ' let the driver figure out the DNS suffix, protocol, and port #
#
#-------------------------------
param ([string]$server = "localhost")
Set-ExecutionPolicy Unrestricted-Scope CurrentUser
$connstr = "Server=$server;Database=master;Integrated Security=SSPI"
[System.Data.SqlClient.SqlConnection] $conn = New-Object System.Data.SqlClient.SqlConnection
$conn.ConnectionString = $connstr
[System.DateTime] $start = Get-Date
$conn.Open()
[System.Data.SqlClient.SqlCommand] $cmd = New-Object System.Data.SqlClient.SqlCommand
$cmd.CommandText = "select auth_scheme from sys.dm_exec_connections where session_id=@@spid"
$cmd.Connection = $conn
$dr = $cmd.ExecuteReader()
$result = $dr.Read()
$auth_scheme = $dr.GetString(0)
$conn.Close()
$conn.Dispose()
[System.DateTime] $end = Get-Date
[System.Timespan] $span = ($end - $start)
"End time: " + $end.ToString("M/d/yyyy HH:mm:ss.fff")
"Elapsed time was " + $span.Milliseconds + " ms."
"Auth scheme for " + $server + ": " + $auth_scheme
```

Now, run the PowerShell script from the command prompt:

```powershell
C:\temp> .\get-sqlauthscheme sqlprod01
End time: 10/26/2020 18:00:24.753
Elapsed time was 0 ms.
Auth scheme for sqlprod01: NTLM
```
