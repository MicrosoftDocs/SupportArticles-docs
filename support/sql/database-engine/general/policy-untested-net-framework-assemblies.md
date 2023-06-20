---
title: Policy for untested .NET Framework assemblies
description: This article describes the support policy for untested Microsoft .NET Framework assemblies in the .NET Framework common language runtime (CLR)-hosted environment in SQL Server.
ms.date: 09/25/2020
ms.custom: sap:Database Design and Development
ms.reviewer: SureshKa
---

# Support policy for untested .NET Framework assemblies in the SQL Server CLR-hosted environment

This article describes the support policy for untested Microsoft .NET Framework assemblies in the .NET Framework common language runtime (CLR)-hosted environment in SQL Server.

_Original product version:_ &nbsp; SQL Server  
_Original KB number:_ &nbsp; 922672

## Assembly testing and support

When you register an assembly that references an untested .NET Framework assembly in SQL Server, you may receive the following warning message:

> .Net frameworks assembly AssemblyName you are registering is not fully tested in SQL Server hosted environment.

The message means that the .NET Framework assembly hasn't been tested in the SQL Server CLR-hosted environment. Therefore, the assembly isn't supported in the SQL Server CLR-hosted environment.

An untested .NET Framework assembly may exit its host process when a critical condition such as low-memory condition occurs. You can use the assembly in the SQL Server CLR-hosted environment at your own risk. However, SQL Server Customer Support Services (CSS) won't help you to use and troubleshoot issues that are associated with an unsupported .NET Framework assembly. If CSS determines that a particular unsupported assembly causes SQL Server issues, you may be asked to stop using the assembly. Additionally, you may be asked to stop using the assembly temporarily when CSS troubleshoots a particular SQL Server issue if it's necessary.

## Assembly registration

There are two kinds of .NET assemblies: pure and mixed. Pure .NET assemblies contain only MSIL instructions. Mixed assemblies contain both unmanaged machine instructions and MSIL instructions. Mixed assemblies in general are compiled in a C++ compiler by using the "clr" switch, and also contain machine instructions built from native C++ code.

When you use a .NET Framework assembly that isn't in the supported list, you are required to use the `CREATE ASSEMBLY` statement to register the assembly and the referenced assemblies within SQL Server database. The SQL Server `CREATE ASSEMBLY` statement lets only pure .NET Framework assemblies be registered. If the assembly or any referenced assembly isn't a pure .NET Framework assembly (and, therefore, is a mixed assembly), you receive the following error message:

> Msg 6544, Level 16, State 1, Line 2  
CREATE ASSEMBLY for assembly '\<assembly name\>' failed because assembly '\<assembly name\>' is malformed or not a pure .NET assembly.  
Unverifiable PE Header/native stub.

In this case, you can't use the .NET Framework assembly together with SQL CLR unless the assembly is in the supported list that's documented in this article. Additionally, a .NET Framework assembly can change from a pure assembly to a mixed assembly between versions. If you use an assembly that's not in the supported list, you might have a situation in which the assembly works in one version of the .NET Framework but not in another. This restriction doesn't apply to the assemblies in the supported list because these assemblies are not required to be registered by using the `CREATE ASSEMBLY` statement.

Additionally, you must maintain these assemblies after you upgrade the .NET Framework. The following error message is shown when you execute a CLR routine or use an assembly in SQL Server:

> Assembly in host store has a different signature than assembly in GAC. (Exception from HRESULT: 0x80131050)

## Assemblies that are supported in a SQL Server CLR-hosted environment

The following .NET Framework assemblies are supported in a SQL Server CLR-hosted environment:

- *Microsoft.VisualBasic.dll*

- *Mscorlib.dll*

- *System.Data.dll*

- *System.dll*

- *System.Xml.dll*

- *Microsoft.VisualC.dll*

- *CustomMarshalers.dll*

- *System.Security.dll*

- *System.Web.Services.dll*

- *System.Data.SqlXml.dll*

- *System.Transactions.dll*

- *System.Data.OracleClient.dll*

- *System.Configuration.dll*
