---
title: Replay Markup Language Utilities
description: This article discusses a group of tools that are used by support professionals to troubleshoot SQL Server.
ms.date: 06/11/2023
ms.custom: sap:Tools
ms.reviewer: sureshka, jopilov, toddhayn, troymoen, v-jayaramanp
ms.topic: article
---
# Replay Markup Language (RML) Utilities for SQL Server

This article discusses a group of tools that are used by support professionals to troubleshoot Microsoft SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 944837

## Introduction

The SQL Server support team uses several internally written tools to help process typical customer support cases. Replay Markup Language (RML) Utilities for SQL Server is one particular tool suite that database developers and system administrators can use.

## More information

You can use RML Utilities for SQL Server to do the following tasks:

- Determine which application, database, SQL Server login, or query is using the maximum resources.
- Determine whether the execution plan for a batch is changed when you capture the trace for the batch. Additionally, you can use RML Utilities for SQL Server to determine how SQL Server runs these plans.
- Determine which queries are running slowly.

After you capture a trace for an instance of SQL Server, you can use RML Utilities for SQL Server to replay the trace file against another instance of SQL Server. If you also capture the trace during the replay, you can use RML Utilities for SQL Server to compare the new trace file to the original trace file. You can use this technique to test how SQL Server behaves after you apply changes. For example, you can use this technique to test how SQL Server behaves after you do the following tasks:

- Install a SQL Server service pack
- Install a SQL Server hotfix
- Update a stored procedure or a function
- Update an index or create an index

## Version history

|Version number|Description|
|---|---|
|[09.04.0102](https://www.microsoft.com/download/details.aspx?id=104868)| Indicates the current web release that's available from the Microsoft Download Center. It supports all released versions of SQL Server (SQL Server 2022, SQL Server 2019, SQL Server 2017, SQL Server 2016, SQL Server 2014, SQL Server 2012, SQL Server 2008 R2, and SQL Server 2008).|
|[9.04.0100](https://www.microsoft.com/download/details.aspx?id=103126)| Is the previous web release that's available from the Microsoft Download Center. It supports all released versions of SQL Server (SQL Server 2019, SQL Server 2017, SQL Server 2016, SQL Server 2014, SQL Server 2012, SQL Server 2008 R2, SQL Server 2008, SQL Server 2005, and SQL Server 2000).|
|[9.04.0098](https://www.microsoft.com/download/details.aspx?id=54090)| Indicates the current release package that is included with the Database Experimentation Assistant tool. It supports all released versions of SQL Server.|
|9.04.0097| Indicates current release available from the SQL Nexus site that supports all released versions of SQL Server.|
|9.04.0051| Is the previous web release that's available from the Microsoft Download Center that supports SQL Server 2014, SQL Server 2012, SQL Server 2008 R2, SQL Server 2008, SQL Server 2005, and SQL Server 2000.|
|9.04.0004| Is the previous web release that supports SQL Server 2014, SQL Server 2012, SQL Server 2008 R2, SQL Server 2008, SQL Server 2005, and SQL Server 2000.|
|9.01.0109| Is the previous web release that supports SQL Server 2008 R2, SQL Server 2008, SQL Server 2005, and SQL Server 2000.|
|9.00.0023| Is the previous web release that supports SQL Server 2005 and SQL Server 2000.|
|8.10.0010| Is the initial web release that supports SQL Server 2000 and SQL Server 7.0.|
  
The current version of RML Utilities for SQL Server supersedes any earlier versions. You must uninstall any earlier version of RML Utilities for SQL Server before you install the current version. The current version of the tool suite contains important software updates, improved features (process *.trc* and *.xel* files) and reports, and performance and scalability improvements.

## Obtain the RML Utilities for SQL Server

- RML Utilities for SQL Server is available for download from the [Microsoft Download Center](https://download.microsoft.com/download/a/a/d/aad67239-30df-403b-a7f1-976a4ac46403/RMLSetup.msi).

- After you install the [Database Experimentation Assistant](https://www.microsoft.com/download/details.aspx?id=54090), you will find the RML tools (`ReadTrace` and `OStress`) in the `C:\Program Files (x86)\Microsoft Corporation\Database Experimentation Assistant\Dependencies\X64\` folder.

> [!NOTE]  
> Microsoft provides RML Utilities for SQL Server as is. Microsoft Customer Support Services (CSS) doesn't provide support or updates for the suite. If you have a suggestion or you want to report a bug, you can use the e-mail address in the "Problems and Assistance" topic in the Help file (_RML Help.pdf_). The Help file is included with the RML Utilities for SQL Server.

## Benefits of RML Utilities for SQL Server

RML Utilities for SQL Server is useful if you want to simulate application testing when it's impractical or impossible to test by using the real application. In a test environment, it may be difficult to generate the same user load that exists in the production environment. You could use RML Utilities for SQL Server to replay a production workload in a test environment and assess the performance effect of any changes. For example, you could test an upgrade to SQL Server 2008 or the application of a SQL Server service pack. Additionally, you can use RML Utilities for SQL Server to analyze and compare various replay workloads. This kind of regression analysis would otherwise be a difficult process that you would have to do manually.

The Help file contains a Quick Start topic. This topic includes a brief exercise that will familiarize you with every RML tool. To open the Help file, select **Start**, point to **All Programs**, point to **RML Utilities for SQL Server**, point to **Help**, and then select **RML Help**.

## Tools in RML Utilities for SQL Server

RML Utilities for SQL Server contains the following tools:

- ReadTrace
- Reporter
- OStress
- OStress Replay Control Agent (ORCA)

For a complete description of every tool and sample usage, see the RML Help file that's included in RML Utilities for SQL Server.

## Dependencies for RML Utilities for SQL Server

> [!IMPORTANT]  
> The applications that are provided as part of the RML tool suite require that several additional controls be made available.

### Dependencies for Reporter

1. You have to make sure that the Report Viewer controls are available either in the same folder as *Reporter.exe* or in the Global Assembly Cache (GAC). The DLLs that *Reporter.exe* requires are:

   - *Microsoft.ReportViewer.Common.dll*
   - *Microsoft.ReportViewer.DataVisualization.dll*
   - *Microsoft.ReportViewer.ProcessingObjectModel.dll*
   - *Microsoft.ReportViewer.WinForms.dll*

   You can download these DLLs by using the following PowerShell script:

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

1. You must download and install a ReporterViewer fix to allow links within the ReadTrace reports to work properly. To download the ReporterViewer fix, go to [Microsoft Visual Studio 2010 Service Pack 1 Report Viewer (KB2549864)](https://www.microsoft.com/en-us/download/details.aspx?id=27231).

### Dependencies for Expander

Make sure that the compression and decompression controls are available either in the same folder as *Expander.exe* or in the GAC. The DLLs that *Expander.exe* requires are as follows:

- *BRICOLSOFTZipx64.dll*
- *UnRar64.dll*
- *XceedZipX64.dll*

You can obtain these DLLs from the respective software packages of the vendors:

- <https://www.rarlab.com/rar_add.htm> - find the *UnRAR.dll* dynamic library for Windows software developers

- <https://www.7-zip.org/a/7z1900-x64.exe>

- <https://www.nuget.org/packages/Xceed.Products.Zip.Full/>

### Dependencies for ReadTrace and Ostress

ReadTrace and Ostress use the ODBC and OLEDB drivers shipped as part of the [SQL Server Native Client](/sql/relational-databases/native-client/applications/installing-sql-server-native-client).
If you plan to analyze Extended Event files (_*.xel_), make sure that [Visual C++ 2010 Redistributable](/cpp/windows/latest-supported-vc-redist) is installed on the system.

## Known issues and fixes

|Issue|Resolution|
|------|---|
|ReadTrace encounters "ERROR: Event runtime check: Detected missing column [cached_text] in event [sp_cache_remove] at event sequence 209494"|Fixed in version 09.04.0102. As a workaround, you can add trace flags (`-T28 -T29`) to the ReadTrace command line.|
|Reporter encounters "Could not load file or assembly 'Reporter, Version=9.4.10000.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35' or one of its dependencies. Strong name validation failed. (Exception from HRESULT: 0x8013141A)"|Fixed in version 09.04.0102. As a workaround, you can create the following registry key to override the strong name verification: `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\StrongName\Verification\Reporter,31BF3856AD364E35`.|
|ReadTrace fails with error "Unable to connect to the specified server. Initial HRESULT: 0x80040154". Ostress fails with error "Attempt to establish connection failed. SSL Security error.".|See instructions to [Install SQL Server Native Client](/sql/relational-databases/native-client/applications/installing-sql-server-native-client).|
|You encounter the exception from ReadTrace "Unhandled Exception: System.IO.FileNotFoundException: Could not load file or assembly 'Microsoft.SqlServer.XEvent.Linq.dll' or one of its dependencies. The specified module could not be found".|Install [Visual C++ 2010 Redistributable](/cpp/windows/latest-supported-vc-redist)|

## Examples

The following examples illustrate how to use some of the RML tools.

### Using ReadTrace.exe to import Xevent data in a database

Use *ReadTrace.exe* to import a series of Xevent files that are collected by using tools such as PSSDIAG/[SQLDiag.exe](/sql/tools/sqldiag-utility) or [SQL LogScout](https://github.com/microsoft/SQL_LogScout/releases). Use the `-I` parameter to point to the first *.xel* file that was collected in time, if multiple files are present. For all command-line switches, use `ReadTrace.exe /?`:

```console
ReadTrace.exe -Iserver_instance_20220211T1319480819_xevent_LogScout_target_0_132890707717540000.xel -oc:\temp\output -f -dPerfAnalysisDb -S.
```

### Using Ostress.exe to stress test a query

Use OStress to submit a query against a server that's running SQL Server by running 30 simultaneous connections and running the query 10 times on each connection. For all command-line switches, use `Ostress.exe /?`:

```console
ostress.exe -E -dmaster -Q"select name from sys.databases" -n30 -r10
```

[!INCLUDE [Third-party disclaimer](../../includes/third-party-contact-disclaimer.md)]
