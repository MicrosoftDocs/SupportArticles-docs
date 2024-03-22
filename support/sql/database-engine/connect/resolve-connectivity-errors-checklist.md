---
title: Prerequisites and checklist for resolving connectivity errors
description: Provides prerequisites and a checklist for troubleshooting SQL Server connectivity issues.
ms.date: 05/25/2022
ms.custom: sap:Connection issues
author: HaiyingYu
ms.author: haiyingyu
---
# Recommended prerequisites and checklist for troubleshooting SQL Server connectivity issues

_Applies to:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 4009936

## Recommended prerequisites

To effectively troubleshoot connectivity issues, gather the following information:

- The text of the error message and the error codes. Check whether the error is intermittent (occurs only sometimes) or consistent (occurs all the time).
- Application and system event logs from SQL Server and client systems. These logs can help check if there are any system wide issues occurring on your SQL Server.
- If the connections are failing from an application, collect the connection strings from the application. These strings are typically found in *Web.config* files for ASP.NET applications. 
- Collect and review SQL Server error logs for other error messages and exceptions.
- If you have administrator access to the SQL Server computer, gather and review current computer settings and service accounts by using the following procedure:

  1. Download the latest version of [SQLCHECK](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/SQLCHECK).

  1. Unzip the downloaded file into a folder, for example, *C:\Temp*.

  1. Run the command prompt as an administrator to collect the data and save to a file. For example: `SQLCHECK > C:\Temp\server01.SQLCHECK.TXT`.

    > [!NOTE]
    > If you're troubleshooting connectivity issues from a remote client or troubleshooting linked server queries, run the SQLCHECK tool on all systems involved.

## Quick checklist for troubleshooting connectivity issues

> [!NOTE]
> The following sections help you to quickly check for connectivity issues. Review individual topics for detailed troubleshooting steps.

### Option 1

If you have access to the output of the SQLCHECK tool mentioned in the [Recommended prerequisites](#recommended-prerequisites) section and review information in various sections in the output file (Computer, Client Security, and SQL Server), use the information to address the issues contributing to your problem. See the following examples:

|Section in the file |Text to search for |Potential action |Can help troubleshoot (examples) |
|-|-|-|-|
|Computer Information |Warning: Network driver may be out of date |Check online for new drivers. |Various connectivity errors |
|Client Security and Driver Information |Diffie-Hellman cipher suites are enabled. Possible risk of intermittent TLS failures if the algorithm version is different between clients and servers |If you're having intermittent connectivity issues, see [Applications experience forcibly closed TLS connection errors when connecting to SQL Servers in Windows](../../../windows-server/identity/apps-forcibly-closed-tls-connection-errors.md).|[An existing connection was forcibly closed by the remote host](../connect/tls-exist-connection-closed.md)|
|Client Security and Driver Information |SQL Aliases |If present, ensure aliases are configured properly and pointing to the correct server and IP addresses. |[A network-related or instance-specific error occurred while establishing a connection to SQL Server](../connect/network-related-or-instance-specific-error-occurred-while-establishing-connection.md) |
|SQL Server Information |Services of Interest |If your SQL service isn't started, start it. If you're having issues connecting to a named instance, ensure SQL Server Browser service is started or try restarting the browser service. |[A network-related or instance-specific error occurred while establishing a connection to SQL Server](../connect/network-related-or-instance-specific-error-occurred-while-establishing-connection.md) |
|SQL Server Information |Domain Service Account Properties |If you configure linked servers from your SQL Server and the **Trust for Del** value is set to false, then you may run into authentication issues with your linked server queries. |[Troubleshooting "Login failed for user" errors](/sql/relational-databases/errors-events/mssqlserver-18456-database-engine-error?context=/troubleshoot/sql/context/context) |
|SQL Server Information |SPN does not exist |Check this table to see if SPNs for your SQL Server are properly configured and fix any issues identified. |[Cannot generate SSPI context](../connect/cannot-generate-sspi-context-error.md)|
|SQL Server Information |Details for SQL Server Instance |Check the values of TCP Enabled, TCP Ports, and so on. Review whether TCP/IP is enabled on the server side and if your SQL default instance is listening on 1433 or a different port.  |Various connectivity errors |

### Option 2

If you aren't able to run SQLCHECK on your SQL Server computer, you can check the following items before doing in-depth troubleshooting:

1. Make sure that SQL Server is started, and that you see the following message in the SQL Server error log:

    > SQL Server is now ready for client connections. This is an informational message; no user action is required.

   Use the following command in PowerShell to check the status of SQL Server services on the system:
  
    ```powershell
    Get-Service | Where {$_.status -eq 'running' -and $_.DisplayName -match "sql server*"}
    ```

   Use the following command to search the error log file for the specific string "SQL Server is now ready for client connections. This is an informational message; no user action is required.":
  
    ```powershell
    Get-ChildItem -Path "c:\program files\microsoft sql server\mssql*" -Recurse -Include Errorlog |select-string "SQL Server is now ready for client connections."
    ```

1. Verify basic connectivity over IP address and check for any abnormalities: `ping -a <SQL Server machine>, ping -a <SQL Server IP address>`. If you notice any issues, work with your network administrator. Alternatively, you can use `Test-NetConnection` in PowerShell:

   ```powershell
   $servername = "DestinationServer"
   Test-NetConnection -ComputerName $servername
   ```

1. Check whether SQL Server is listening on appropriate protocols by reviewing the error log:

   ```powershell
    Get-ChildItem -Path "c:\program files\microsoft sql server\mssql*" -Recurse -Include Errorlog |select-string "Server is listening on" , "ready to accept connection on" -AllMatches
   ```

1. Check whether you're able to connect to SQL Server by using a UDL file. If it works, then there may be an issue with the connection string. For instructions on the UDL test procedure, see [Test OLE DB connectivity to SQL Server by using a UDL file](test-oledb-connectivity-use-udl-file.md). Alternately, you can use the following script to create and launch a *UDL-Test.udl* file (stored in the *%TEMP%* folder):

    ```powershell
    clear
    
    $ServerName = "(local)"
    $UDL_String = "[oledb]`r`n; Everything after this line is an OLE DB initstring`r`nProvider=MSOLEDBSQL.1;Integrated Security=SSPI;Persist Security Info=False;User ID=`"`";Initial Catalog=`"`";Data Source=" + $ServerName + ";Initial File Name=`"`";Server SPN=`"`";Authentication=`"`";Access Token=`"`""
    
    Set-Content -Path ($env:temp + "\UDL-Test.udl") -Value $UDL_String -Encoding Unicode
    
    #open the UDL
    Invoke-Expression ($env:temp + "\UDL-Test.udl")
    ```

1. Check whether you're able to connect to SQL Server from other client systems and different user logins. If you're able to, the issue could be specific to the client or login that is experiencing the issue. Check the Windows event logs on the problematic client for more pointers. Also, check whether network drivers are up to date.

1. If you're experiencing login failures, make sure that a login (server principal) exists and it has `CONNECT SQL` permissions to SQL Server. In addition, make sure that the default database that's assigned to the login is correct, and that the mapped database principal has `CONNECT` permissions to the database. For more information about how to grant `CONNECT` permissions to the database principal, see [GRANT Database Permissions](/sql/t-sql/statements/grant-database-permissions-transact-sql#:~:text=CONTROL%20SERVER-,CONNECT,-CONNECT%20REPLICATION). For more information about how to grant `CONNECT SQL` permissions to the server principal, see [GRANT Server Permissions](/sql/t-sql/statements/grant-server-permissions-transact-sql#:~:text=CONTROL%20SERVER-,CONNECT%20SQL,-CONTROL%20SERVER). Use the following script to help you identify these permissions:

    ```powershell
    clear
    ## replace these variables with the login, user, database and server 
    $server_principal = "CONTOSO\JaneK"  
    $database_principal = "JaneK"
    $database_name = "mydb"
    $server_name = "myserver"
    
    Write-Host "`n******* Server Principal (login) permissions *******`n`n"
    sqlcmd -E -S $server_name -Q ("set nocount on; SELECT convert(varchar(32),pr.type_desc) as login_type, convert(varchar(32), pr.name) as login_name, is_disabled,
      convert(varchar(32), isnull (pe.state_desc, 'No permission statements')) AS state_desc, 
      convert(varchar(32), isnull (pe.permission_name, 'No permission statements')) AS permission_name,
      convert(varchar(32), default_database_name) as default_db_name
      FROM sys.server_principals AS pr
      LEFT OUTER JOIN sys.server_permissions AS pe
        ON pr.principal_id = pe.grantee_principal_id
      WHERE is_fixed_role = 0 -- Remove for SQL Server 2008
      and name = '" + $server_principal + "'")
    
    Write-Host "`n******* Database Principal (user) permissions *******`n`n"
    sqlcmd -E -S $server_name -d $database_name -Q ("set nocount on; SELECT convert(varchar(32),pr.type_desc) as user_type, convert(varchar(32),pr.name) as user_name, 
      convert(varchar(32), isnull (pe.state_desc, 'No permission statements')) AS state_desc, 
      convert(varchar(32), isnull (pe.permission_name, 'No permission statements')) AS permission_name 
      FROM sys.database_principals AS pr
      LEFT OUTER JOIN sys.database_permissions AS pe
        ON pr.principal_id = pe.grantee_principal_id
      WHERE pr.is_fixed_role = 0
      and name = '" + $database_principal + "'")
    
    Write-Host "`n******* Server to Database Principal mapping ********`n"
    sqlcmd -E -S $server_name -d $database_name -Q ("exec sp_helplogins '" + $server_principal + "'")
    ```

1. If you're troubleshooting Kerberos related issues, you can use the scripts at [Determine If I Am Connected to SQL Server using Kerberos Authentication](https://github.com/microsoft/CSS_SQL_Networking_Tools/wiki/Determine-If-I-Am-Connected-to-SQL-Server-using-Kerberos-Authentication) to determine if Kerberos is properly configured on your SQL Servers.

## Common connectivity issues

When you've gone through the prerequisites and checklist, see [common connectivity issues](resolve-connectivity-errors-overview.md#common-connectivity-issues) and select the corresponding error message for detailed troubleshooting steps.
