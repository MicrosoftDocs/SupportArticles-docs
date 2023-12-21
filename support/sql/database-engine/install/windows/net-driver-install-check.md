---
title: .NET Driver Install Checking
description: This article provides an overview of the essential aspects related to .NET Providers, their default search paths, and troubleshooting guidelines.
ms.date: 12/13/2023
ms.custom: sap:Installation, Patching and Upgrade
ms.reviewer:  
---

When working with .NET Providers in Microsoft .NET, it's crucial to understand the various components and their dependencies for a seamless integration into your applications. Here's in this article there is overview of the essential aspects related to .NET Providers, their default search paths, and troubleshooting guidelines.

Note: This article does not cover .Net core installations.

Microsoft .NET Providers
Microsoft .NET comes with four Providers that ship with the .NET Framework:

•	System.Data.SqlClient
•	System.Data.Odbc
•	System.Data.OleDb
•	System.Data.OracleClient

The first three are contained in System.Data.DLL and the last is contained in System.Data.OracleClient.DLL. When building an application, you just add a reference to the appropriate DLL (aka “assembly”) to your project and you can use the Provider.

System.Data.Odbc and System.Data.OleDb do not provide any inherent database functionality. Instead, they load ODBC drivers and OLE DB Providers respectively and the same load behaviors as discussed in the prior sections apply.

For System.Data.SqlClient, this Provider does contain the implementation code similar to SQL Native Client and does not rely on OLE DB or ODBC at all.

System.Data.OracleClient also contains implementation code, but as with Oracle ODBC drivers and OLE DB Providers, it does rely on the Oracle Client Software or the Oracle Data Access Components (ODAC) software to be installed as well.

Note: In general, we recommend using Oracle drivers rather than Microsoft implementations as these are likely to be more up-to-date. If an issue can be resolved by switching to an Oracle Provider from a Microsoft implementation, then that is the preferred solution.

Default .NET Search Path
Unlike when loading ODBC drivers and OLE DB Providers, when loading .NET Providers, the .NET loader does not rely on the registry but has a search heuristic that is described below:
1.	The DEVPATH environment variable is checked for a shared folder. You should only use this when developing shared assemblies. Once the development is completed the assembly should be installed in the Global Assembly Cache (GAC).
2.	The GAC is checked to see if the assembly is shared between applications. If the assembly is not in the GAC, it is a private assembly.
3.	If the application or web configuration file has a item, the href attribute gives the name and absolute path of the file containing the assembly's manifest.
4.	Next, the folder where the application was installed is checked.
5.	A subfolder in the application folder with the same name as the file containing the assembly's manifest is checked.
6.	If the configuration file has a item, the privatePath attribute gives the name of one or more subfolders under the application folder to search.

The above is a general DLL load algorithm. With built-in .NET Providers, the DLL will almost always be in one of these folders:

•	C:\windows\microsoft.net\Framework (32 bit assemblies)
•	C:\windows\microsoft.net\Framework64 (64-bit assemblies)

Under these folders, there will be a folder for the various .NET versions. Typically, we are only concerned with:

•	v2.0.50727 (.NET 2.0, 3.0, 3.5)
•	v4.0.30319 (.NET 4.x)

You may notice .NET 1.0 and 1.1 folders. These are out of support and do not contain any assemblies. You may also notice .NET 3.0 and 3.5 folders. While these may contain certain files specific to these versions of .NET, they are all extensions to version 2.0 and the System.Data.DLL is located in the 2.0 folder since it is not an extension DLL.   The folders above are the locations of built-in Framework DLLs. In addition, these DLLs and 3rd-party DLLs appear in the Global Assembly Cache, which is where the search algorithm looks. It is located in this folder:

•	C:\windows\assembly (.NET 2.0, 3.0, 3.1, 4.x)

Some .NET 4.0 assemblies are also located under:
•	C:\windows\microsoft.net\assembly

A more complete guide is: How the Runtime Locates Assemblies - .NET Framework | Microsoft Learn. Use of PROCMON may also reveal the search path.

3rd-Party Providers

There are a number of Microsoft-installed Providers, such as Analysis Services, that do not come with the .NET Framework. In addition, there are a number of 3rd-party .NET Providers, such as Oracle’s ODP Provider.

With the Microsoft Providers, engage the appropriate team to validate the Provider is installed.

With 3rd-party Providers, make sure the assembly is located in one of the folders above and that it is 64-bit or 32-bit depending on the application.

The table below shows the DLL and assembly names for some common providers:

Friendly Name	Assembly Name	DLL
SQL Provider	System.Data.SqlClient	System.Data.DLL
OLE DB Provider	System.Data.OleDb	System.Data.DLL
ODBC Provider	System.Data.Odbc	System.Data.DLL
Analysis Services Provider	Microsoft.AnalysisServices.AdomdClient	Microsoft.AnalysisServices.AdomdClient.DLL
SQL CE Provider	System.Data.SqlServerCe	System.Data.SqlServerCe.DLL
Microsoft's Oracle Provider	System.Data.OracleClient	System.Data.OracleClient.DLL
Oracle's ODP Provider	Oracle.DataAccess.Client	Oracle.DataAccess.DLL

When troubleshooting .NET Providers, there is no generalized tool, such as the ODBC Administrator or a UDL file for testing independently of the application. In this case, you could write one in PowerShell. The following topic contains a PowerShell script that tests the SqlClient Provider. It can readily be modified for others:

Determine If I Am Connected to SQL Server using Kerberos Authentication

In general, loading .NET Providers will not be an issue if the assembly/DLL exists. The most common problem is authentication issues, which you can test using an equivalent OLE DB Provider via a UDL file.
For help with connection strings for unfamiliar drivers, visit: www.connectionstrings.com.