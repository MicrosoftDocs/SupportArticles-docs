---
title: Replay Markup Language Utilities for SQL Server
description: Learn about Replay Markup Language (RML) Utilities for SQL Server, including diagnostic tools, installation requirements, and workload replay examples.
ms.date: 11/17/2026
ms.custom: sap:SQL Server Management, Query and Data Tools
ms.reviewer: sureshka, jopilov, toddhayn, troymoen, v-shaywood
ai-usage: ai-assisted
---
# Replay Markup Language (RML) Utilities for SQL Server

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 944837

## Summary

Replay Markup Language (RML) Utilities for SQL Server are diagnostic tools that process Extended Events and SQL Trace files, report on query workload performance, and replay a captured workload for stress and regression testing. The suite includes ReadTrace, Reporter, and Ostress. Support engineers, database developers, and administrators use RML Utilities to find the applications, logins, and queries that consume the most resources, and to compare performance before and after a change, such as installing a cumulative update or creating an index.

## What are RML Utilities?

RML Utilities process and visualize the performance diagnostic data that you collect from SQL Server. SQL Server support engineers commonly use them to process diagnostic traces while troubleshooting a performance issue. Database developers and administrators also use them to analyze and improve the SQL Server query workload in test and production environments.

The suite includes three primary utilities, ReadTrace, Reporter, and Ostress. A fourth component, OStress Replay Control Agent (ORCA), works together with Ostress.

- **ReadTrace** takes in [Extended Event](/sql/relational-databases/extended-events/extended-events) traces or [SQL Trace](/sql/relational-databases/sql-trace/sql-trace) traces that a user creates to diagnose a SQL Server issue or analyze workload performance. ReadTrace imports the traces into tables in a SQL Server database specified by the user. Think of ReadTrace as a transformation tool: it takes binary `.XEL` or `.TRC` files and imports them into tables so they can be more easily analyzed via SQL queries. ReadTrace can also generate Replay Markup Language (.RML) files that can be used by Ostress for workload replay.
- **Reporter** is a report and visualization tool that connects to the user database that ReadTrace creates. Reporter runs SQL queries against the database and shows offline SSRS report summaries of the original Extended Events or Profiler traces. For example, a report might show which queries ran the longest in a particular captured workload, which used the most CPU, and which performed the most reads.
- **Ostress** is a stress-testing simulation tool. **Ostress.exe** uses Extended Event or SQL Profiler diagnostic traces as input. It can also accept user-supplied queries as inputs. Ostress then replays those traces or queries against a SQL Server instance that the user chooses. The goal is to simulate stress. For example, if you provide OStress a query like `select * from table1`, you can instruct it to run the query 100 times on 50 connections simultaneously. In addition to individual queries, Ostress can use special RML files that ReadTrace generates to perform the replay.
- **OStress Replay Control Agent (ORCA)** aids Ostress in simulating a stress test by replaying a workload from RML files. You don't interact with ORCA directly, but use Ostress.

For a complete description of every tool and sample usage, see the RML Help file that's included in RML Utilities for SQL Server.

> [!NOTE]
> RML Utilities are deprecated as of October 2025. This product is no longer in development and no future enhancements or fixes should be expected.

## How are RML Utilities useful?

Use RML Utilities for SQL Server to perform the following tasks:

- Determine which application, database, SQL Server login, or query uses the most resources.
- Determine whether the execution plan for a batch changes when you capture the trace for the batch. Also, use RML Utilities for SQL Server to understand how SQL Server runs these plans.
- Determine which queries run slowly.

After you capture a trace for an instance of SQL Server, use RML Utilities for SQL Server to replay the trace file against another instance of SQL Server. If you also capture the trace during the replay, you can use RML Utilities for SQL Server to compare the new trace file to the original trace file. Use this technique to test how SQL Server behaves after you apply changes. For example, use this technique to test how SQL Server behaves after you perform the following tasks:

- Install a SQL Server service pack.
- Install a SQL Server Cumulative Update.
- Update a stored procedure or a function.
- Update or create an index.

### Benefits of RML Utilities for SQL Server

RML Utilities for SQL Server is useful if you want to simulate application testing when it's impractical or impossible to test by using the real application. In a test environment, it might be difficult to generate the same user load that exists in the production environment. Use RML Utilities for SQL Server to replay a production workload in a test environment and assess the performance effect of any changes. For example, you can test an upgrade to SQL Server 2008 or the application of a SQL Server service pack. Also, use RML Utilities for SQL Server to analyze and compare various replay workloads. Performing this kind of regression analysis manually is difficult.

The Help file contains a Quick Start topic. This topic includes a brief exercise that familiarizes you with every RML tool. To open the Help file, select **Start** > **All Programs** > **RML Utilities for SQL Server** > **Help**> **RML Help**.

## Download location and version history

The following table lists the RML Utilities releases and download locations.

|Version number|Description|
|---|---|
|[09.04.0103](https://www.microsoft.com/download/details.aspx?id=106287)| The current and final web release that's available from the Microsoft Download Center. It supports all released versions of SQL Server (SQL Server 2022, SQL Server 2019, SQL Server 2017, SQL Server 2016, SQL Server 2014, SQL Server 2012, SQL Server 2008 R2, and SQL Server 2008).|
|[09.04.0102](https://www.microsoft.com/download/details.aspx?id=104868)| The previous web release that's available from the Microsoft Download Center. It supports all released versions of SQL Server (SQL Server 2022, SQL Server 2019, SQL Server 2017, SQL Server 2016, SQL Server 2014, SQL Server 2012, SQL Server 2008 R2, and SQL Server 2008).|
|[9.04.0100](https://www.microsoft.com/download/details.aspx?id=103126)| A previous web release that's available from the Microsoft Download Center. It supports all released versions of SQL Server (SQL Server 2019, SQL Server 2017, SQL Server 2016, SQL Server 2014, SQL Server 2012, SQL Server 2008 R2, SQL Server 2008, SQL Server 2005, and SQL Server 2000).|
|[9.04.0098](https://www.microsoft.com/download/details.aspx?id=54090)| A previous web release package that's included with the Database Experimentation Assistant tool. It supports all released versions of SQL Server.|
  
The current version of RML Utilities for SQL Server supersedes any earlier versions. You must uninstall any earlier version of RML Utilities for SQL Server before you install the current version. The current version of the tool suite contains important software updates, improved features (process *.trc* and *.xel* files) and reports, and performance and scalability improvements.

### Obtain the RML Utilities for SQL Server

You can obtain RML Utilities for SQL Server in either of the following ways:

- Download the current version (09.04.0103) from the [Microsoft Download Center](https://www.microsoft.com/download/details.aspx?id=106287).

- Install the [Database Experimentation Assistant](https://www.microsoft.com/download/details.aspx?id=54090). The RML tools (`ReadTrace` and `OStress`) are in the `C:\Program Files (x86)\Microsoft Corporation\Database Experimentation Assistant\Dependencies\X64\` folder. This package includes the older version 9.04.0098, not the current version.

> [!NOTE]  
> Microsoft provides RML Utilities for SQL Server as-is. Microsoft doesn't provide support for the suite. If you have a suggestion or you want to report a bug, use the e-mail address in the "Problems and Assistance" article in the Help file (**RML Help.docx**). The Help file is included with the RML Utilities for SQL Server.

## Dependencies for RML Utilities for SQL Server

The applications that are provided as part of the RML tool suite require that several other controls be made available.

Reporter requires the Report Viewer controls. ReadTrace and Ostress require an ODBC or OLE DB driver for SQL Server, and require the Visual C++ Redistributable to process Extended Event files. Expander, which is optional, requires compression libraries.

### Dependencies for Reporter

Ensure that the Report Viewer controls are available either in the same folder as *Reporter.exe* or in the Global Assembly Cache (GAC). The DLLs that *Reporter.exe* requires are:

   - *Microsoft.ReportViewer.Common.dll*
   - *Microsoft.ReportViewer.DataVisualization.dll*
   - *Microsoft.ReportViewer.ProcessingObjectModel.dll*
   - *Microsoft.ReportViewer.WinForms.dll*

1. The latest versions of RML Utilities include these DLLs in the application folder.
1. If the DLLs aren't available, use the following PowerShell script to download them:

   ```powershell
   Register-PackageSource -Name MyNuGet -Location https://www.nuget.org/api/v2 -ProviderName NuGet
   Get-PackageSource

   Find-Package Microsoft.ReportViewer.Common -AllVersions
   Install-Package Microsoft.ReportViewer.Common -RequiredVersion 10.0.40219.1

   Copy-Item -Path "C:\Program Files\PackageManagement\NuGet\Packages\Microsoft.ReportViewer.Common.10.0.40219.1\lib\Microsoft.ReportViewer.Common.dll" -Destination "C:\Program Files\Microsoft Corporation\RMLUtils"
   Copy-Item -Path "C:\Program Files\PackageManagement\NuGet\Packages\Microsoft.ReportViewer.Common.10.0.40219.1\lib\Microsoft.ReportViewer.DataVisualization.dll" -Destination "C:\Program Files\Microsoft Corporation\RMLUtils"
   Copy-Item -Path "C:\Program Files\PackageManagement\NuGet\Packages\Microsoft.ReportViewer.Common.10.0.40219.1\lib\Microsoft.ReportViewer.ProcessingObjectModel.dll" -Destination "C:\Program Files\Microsoft Corporation\RMLUtils"

   Find-Package Microsoft.ReportViewer.WinForms -AllVersions
   Install-Package Microsoft.ReportViewer.WinForms -RequiredVersion 10.0.40219.1

   Copy-Item -Path "C:\Program Files\PackageManagement\NuGet\Packages\Microsoft.ReportViewer.WinForms.10.0.40219.1\lib\Microsoft.ReportViewer.WinForms.dll" -Destination "C:\Program Files\Microsoft Corporation\RMLUtils"
   ```

1. To enable links within the ReadTrace reports to work properly, download and install a ReporterViewer fix. To download the ReporterViewer fix, go to [Microsoft Visual Studio 2010 Service Pack 1 Report Viewer (KB2549864)](https://www.microsoft.com/download/details.aspx?id=27231).

### Dependencies for Expander (optional)

In most cases, you don't need to use Expander, which ReadTrace uses to process CAB, ZIP, and RAR files. However, if you need to use this functionality for a particular compressed file type, ensure that the compression and decompression controls are available either in the same folder as **Expander.exe** or in the GAC. The following DLLs are required by **Expander.exe**:

- **BRICOLSOFTZipx64.dll**
- **UnRar64.dll**
- **XceedZipX64.dll**

You can obtain these DLLs from the respective software packages of the vendors:

- <https://www.rarlab.com/rar_add.htm> - find the *UnRAR.dll* dynamic library for Windows software developers

- <https://www.7-zip.org/a/7z1900-x64.exe>

- <https://www.nuget.org/packages/Xceed.Products.Zip.Full/>

### Dependencies for ReadTrace and Ostress

ReadTrace and Ostress use the ODBC and OLEDB drivers that ship as part of the [SQL Server Native Client](/sql/relational-databases/native-client/applications/installing-sql-server-native-client). Starting with version **09.04.0103**, the RML Utilities suite doesn't depend solely on SQL Server Native Client (SNAC). It can use the Microsoft ODBC or OLEDB drivers on the system where it's installed.

If you plan to analyze Extended Events files (_*.xel_), ensure that [Visual C++ 2010 Redistributable](/cpp/windows/latest-supported-vc-redist) is installed on the system.

## Known issues and fixes

|Issue|Resolution|
|------|---|
|ReadTrace encounters an error "Unable to connect to the specified server. Initial HRESULT: 0x80040154" on machines where SQL Server isn't installed or only SQL Server 2022 or later version is installed|Fixed in version 09.04.0103. As a workaround, install SQL Server Native Client or another version of SQL Server. HRESULT 0x80040154 REGDB_E_CLASSNOTREG Class not registered is a header file *winerror.h* that means a COM component isn't registered because it's likely not installed. This error occurs because SQL Server 2022 and later versions don't include the SQL Server Native Client.|
|ReadTrace encounters "ERROR: Event runtime check: Detected missing column [cached_text] in event [sp_cache_remove] at event sequence 209494"|Fixed in version 09.04.0102. As a workaround, add trace flags (`-T28 -T29`) to the ReadTrace command line.|
|Reporter encounters "Could not load file or assembly 'Reporter, Version=9.4.10000.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35' or one of its dependencies. Strong name validation failed. (Exception from HRESULT: 0x8013141A)"|Fixed in version 09.04.0102. As a workaround, create the following registry key to override the strong name verification: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\StrongName\Verification\Reporter,31BF3856AD364E35`.|
|ReadTrace fails with error "Unable to connect to the specified server. Initial HRESULT: 0x80040154". Ostress fails with error "Attempt to establish connection failed. SSL Security error.".|See instructions to [Install SQL Server Native Client](/sql/relational-databases/native-client/applications/installing-sql-server-native-client).|
|You encounter the exception from ReadTrace "Unhandled Exception: System.IO.FileNotFoundException: Could not load file or assembly 'Microsoft.SqlServer.XEvent.Linq.dll' or one of its dependencies. The specified module could not be found".|Install [Visual C++ 2010 Redistributable](/cpp/windows/latest-supported-vc-redist)|

## Examples of using RML tools

The following examples illustrate how to use some of the RML tools.

### Using ReadTrace.exe to import Extended Event (Xevent) data in a database

Use `ReadTrace.exe` to import a series of Extended Events files collected by using tools such as [SQLDiag.exe](/sql/tools/sqldiag-utility) or [SQL LogScout](https://github.com/microsoft/SQL_LogScout/releases). If multiple files are present, use the `-I` parameter to point to the earliest collected *.xel* file. For all command-line switches, use `ReadTrace.exe /?`.

```cmd
ReadTrace.exe -Iserver_instance_20220211T1319480819_xevent_LogScout_target_0_132890707717540000.xel -oc:\temp\output -f -dPerfAnalysisDb -S.
```

### Using Ostress.exe to stress test a query

Use OStress to submit a query against a server that's running SQL Server by running 30 simultaneous connections and running the query 10 times on each connection. For all command-line switches, use `Ostress.exe /?`:

```cmd
ostress.exe -E -dmaster -Q"select name from sys.databases" -n30 -r10
```

### Using ReadTrace and Ostress to generate and replay RML files

To generate **.RML** files, use a command like the following example:

```cmd
ReadTrace -I"D:\RMLReplayTest\ReplayTrace.trc" -o"D:\RMLReplayTest\RML" -S. -dReadTraceTestDb   
```

For more information about which events to capture to create a replay trace, see the **RML Help.docx**.

To replay an RML file by using Ostress, use a command like the following example:

```cmd
ostress.exe -S.\sql2022 -E -dAdventureWorks2022 -i"D:\RMLReplayTest\RML\SQL00069.rml" -o"D:\RMLReplayTest\RML\output"
```

You can replay all RML files by using `*.RML`. For example: `-i"D:\RMLReplayTest\RML\*.rml"`.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-contact-disclaimer.md)]

## Related content

- [Troubleshooting and diagnostic tools for SQL Server on-premises and hybrid scenarios](sql-support-troubleshooting-diagnostic-tools.md)
- [SQL Server Profiler](/sql/tools/sql-server-profiler/sql-server-profiler)
