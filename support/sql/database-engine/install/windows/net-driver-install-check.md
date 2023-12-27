---
title: .NET driver installation check
description: This article provides an overview of the essential aspects of .NET providers, their default search paths, and troubleshooting guidelines.
ms.date: 12/15/2023
ms.custom: sap:Installation, Patching and Upgrade
ms.reviewer: mastewa, jopilov , prmadhes, v-sidong
---
# .NET driver installation check

When using .NET providers in Microsoft .NET, it's crucial to understand the various components and their dependencies for seamless integration into your applications. This article outlines the essential aspects of .NET providers, their default search paths, and troubleshooting guidelines.

> [!NOTE]
> This article doesn't cover .NET core installations.

## Microsoft .NET providers

Microsoft .NET includes four data providers that are shipped with the .NET Framework:

- *System.Data.SqlClient*
- *System.Data.Odbc*
- *System.Data.OleDb*
- *System.Data.OracleClient*

The first three are contained in *System.Data.DLL* and the last one is contained in *System.Data.OracleClient.DLL*. When building an application, you only need to add a reference to the appropriate DLL (also known as "assembly") to your project, and then you can use the provider.

*System.Data.SqlClient* contains implementation code similar to SQL Native Client and doesn't rely on [OLE DB](/cpp/data/oledb/ole-db-programming-overview) or [ODBC](/sql/odbc/reference/syntax/odbc-api-reference) APIs at all.

*System.Data.Odbc* and *System.Data.OleDb* don't provide any inherent database functionality. Instead, they load ODBC drivers and OLE DB providers, respectively.

*System.Data.OracleClient* also contains implementation code, but like Oracle ODBC drivers and OLE DB providers, it also relies on the Oracle Client Software or the Oracle Data Access Components (ODAC) software to be installed.

> [!NOTE]
> In general, it's recommended that you use an Oracle-supplied drivers rather than Microsoft implementations as the former drivers are likely to be more up-to-date. If an issue can be resolved by switching to an Oracle provider from a Microsoft driver implementation, it's a preferred solution.

## Default .NET search path

Unlike loading ODBC drivers and OLE DB providers, the .NET data providers don’t rely on the registry. Instead, the .NET loader uses a search heuristic that’s described as follows:

1. The `DEVPATH` environment variable is checked for a shared folder. You should only use this when developing shared assemblies. Once the development is completed, the assembly should be installed in the Global Assembly Cache (GAC).
1. The GAC is checked to see if the assembly is shared between applications. If the assembly isn't in the GAC, it's a private assembly.
1. If the application or web configuration file has an item, the `href` attribute gives the name and absolute path of the file containing the assembly's manifest.
1. The folder where the application is installed is checked.
1. A subfolder in the application folder with the same name as the file containing the assembly's manifest is checked.
1. If the configuration file has an item, the `privatePath` attribute gives the name of one or more subfolders to be searched under the application folder.

The above is a general DLL load algorithm. Using built-in .NET providers, the DLL is almost always in one of the following folders:

- *C:\windows\microsoft.net\Framework (32-bit assemblies)*
- *C:\windows\microsoft.net\Framework64 (64-bit assemblies)*

Under these folders, there will be a folder for the various .NET versions. Typically, we're only concerned with:

- v2.0.50727 (.NET 2.0, 3.0, 3.5)
- v4.0.30319 (.NET 4.x)

You may notice the .NET 1.0 and 1.1 folders. These are out of support and don't contain any assemblies. You may also notice the .NET 3.0 and 3.5 folders. While these may contain certain files specific to these versions of .NET, they're all extensions to version 2.0, and *System.Data.DLL* is located in the 2.0 folder since it's not an extension DLL. The folders above are the locations of the built-in Framework DLLs. In addition, these DLLs and third-party DLLs appear in the GAC, which is where the search algorithm looks. It's located in this folder: *C:\windows\assembly (.NET 2.0, 3.0, 3.1, 4.x)*.

Some .NET 4.0 assemblies are also located under *C:\windows\microsoft.net\assembly*.

For more complete guidelines, see [How the Runtime Locates Assemblies](/dotnet/framework/deployment/how-the-runtime-locates-assemblies). The use of PROCMON may also reveal the search path.

## Third-party providers

Many Microsoft-installed providers like Analysis Services don't come with the .NET Framework. In addition, there are third-party .NET providers, such as Oracle's ODP Provider which are installed independently.


For third-party providers, make sure the assembly is located in one of the folders above and that it's 64-bit or 32-bit depending on the application.

The following table shows the DLL and assembly names of some common providers:

|Friendly name|Assembly name|DLL|
|-|-|-|
|.NET Data Provider for SQL Server|*System.Data.SqlClient*|*System.Data.DLL*|
|OLE DB Provider|*System.Data.OleDb*|*System.Data.DLL*|
|ODBC Provider|*System.Data.Odbc*|*System.Data.DLL*|
|Analysis Services Provider|*Analysis Services Provider*|*Microsoft.AnalysisServices.AdomdClient*	*Microsoft.AnalysisServices.AdomdClient.DLL*|
|SQL CE Provider|*System.Data.SqlServerCe*|*System.Data.SqlServerCe.DLL*|
|Microsoft's Oracle Provider|*System.Data.OracleClient*|*System.Data.OracleClient.DLL*|
|Oracle's ODP Provider|*Oracle.DataAccess.Client*|*Oracle.DataAccess.DLL*|

When troubleshooting .NET providers, there's no built-in or generalized tool, like the ODBC Administrator or a UDL file, to test the application independently. In such cases, you can write a quick test application in a language of your choice. Here's a sample application written in PowerShell:

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
Set-ExecutionPolicy Unrestricted -Scope CurrentUser
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

If your script is located in `C:\temp` and you want to retrieve the authentication scheme for a server named `sqlprod01`, run the following command from Windows PowerShell as an administrator:

```powershell
.\get-sqlauthscheme.ps1 sqlprod01
```


In general, loading .NET providers won't be an issue if the assembly/DLL exists. The most common problem is authentication issues, which you can [test using an equivalent OLE DB provider via a UDL file](/sql/database-engine/connect/test-oledb-connectivity-use-udl-file).

For help with connection strings for unfamiliar drivers, see [The Connection Strings Reference](https://www.connectionstrings.com/).

## More information

- [ODBC driver installation check](odbc-driver-install-checking.md)
- [OLE DB driver installation check](oledb-driver-install-check.md)
- [Driver installation check](driver-install-checking.md)
