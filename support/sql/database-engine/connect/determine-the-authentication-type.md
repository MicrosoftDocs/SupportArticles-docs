---
title: Determine the authentication type
description: This article explains about how to determine the type of authentication that's used when you connect to SQL Server. 
ms.date: 02/02/2024
author: Malcolm-Stewart
ms.author: mastewa
ms.reviewer: jopilov, haiyingyu, prmadhes, v-jayaramanp
ms.custom: sap:Connection issues
---

# How to use Kerberos authentication to identify your connection type 

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
1. Run the following script ata a command prompt:

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

You should see the following output:

```output
C:\temp> .\get-sqlauthscheme sqlprod01
End time: 10/26/2020 18:00:24.753
Elapsed time was 0 ms.
Auth scheme for sqlprod01: NTLM
```
