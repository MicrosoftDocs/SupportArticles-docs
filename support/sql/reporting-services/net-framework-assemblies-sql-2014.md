---
title: .NET Framework 4.x assemblies aren't supported 
description: This article describes how .NET Framework 4.x assemblies aren't supported in SQL Server Reporting Services.
ms.date: 08/24/2022
ms.prod-support-area-path: Reporting Services
ms.reviewer: 
---

# The .NET Framework 4.x assemblies aren't supported in SQL Server Reporting Services

_Original product version:_ &nbsp; SQL Server 2012, SQL Server 2014  
_Original KB number:_ &nbsp; 2869522

## Summary

Microsoft SQL Server Reporting Services (SSRS) supports extensions by including custom extensions and custom code. However, SSRS doesn't support Microsoft .NET Framework 4.x-based assemblies. Therefore, you can't load a .NET Framework 4.x assembly.

> [!IMPORTANT]
> This issue is applicable only to SQL Server 2012 and SQL Server 2014 versions of SQL Server.

> [!NOTE]
>
> - You can load assemblies when Microsoft Reporting Server 2012 Service Pack 1 (SP1) in Microsoft SharePoint integration mode runs as a SharePoint shared service. This is because the service runs as a Microsoft .NET Framework 4.5 process, and the report server can load custom assemblies and extensions that are built for the .NET Framework 4.x.
>
> - SSRS is built against the Microsoft .NET Framework 2.0 and the Microsoft .NET Framework 3.5. We recommend that you use .NET Framework 2.0 or .NET Framework 3.5 only in SSRS.
>
> - SQL Server Data Tools (SSDT) is a Microsoft Visual Studio environment that's included in SQL Server 2012. Report Designer in SSDT uses PreviewProcessingService.exe to render reports. Because PreviewProcessingService.exe uses the .NET Framework 4.0, you may encounter differences in behavior between design time and deployment to a Report Server.

## More information

- [Developer's Guide: Tutorials (Reporting Services)](/previous-versions/sql/sql-server-2008-r2/aa337423(v=sql.105))
- [Using Custom Assemblies with Reports](/sql/reporting-services/custom-assemblies/using-custom-assemblies-with-reports)
