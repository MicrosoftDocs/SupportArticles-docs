---
title: Warning message when you add a Reporting Services
description: This article  helps you understand the warning messages that occur when adding a reference to reporting services assemblies when developing custom report project using SQL Server Business Intelligence Development Studio.
ms.date: 07/22/2020
ms.custom: sap:Reporting Services
ms.reviewer: ralfks
---
# You receive a warning message when you add a Reporting Services assembly as references to a custom report item project in SQL Server 2012 Reporting Services

This article  helps you understand the warning messages that occur when adding a reference to reporting services assemblies when developing custom report project using SQL Server Business Intelligence Development Studio.

_Original product version:_ &nbsp; SQL Server 2012  
_Original KB number:_ &nbsp; 2722683

## Symptoms

Consider the following scenario:

- In Microsoft SQL Server 2012 Reporting Services, you develop a custom report item project by using SQL Server Business Intelligence Development Studio.
- You set the target .NET Framework for the project to .NET Framework 3.5.
- You add one of the following assemblies as references to the custom report item project:
  - `Microsoft.ReportingServices.Interfaces.dll`  
  - `Microsoft.ReportingServices.ProcessingCore.dll`

When you add the assembly, you receive the following warning message:

> 'Microsoft.ReportingServices.ProcessingCore.dll', or one of its dependencies, requires a later version of the .NET Framework than the one specified in the project.  
>
> You can change the .NET Framework target by clicking Properties on the Project menu and then selecting a new target in the '.NET Framework' dropdown box. (In Visual Basic, this is located on the Compile tab by clicking the "Advanced Compiler Options..." button.)  
>
> Do you still want to add a reference to 'Microsoft.ReportingServices.ProcessingCore.dll' in the project?

After you change the target .NET Framework to .NET Framework 4.0, the project can be compiled successfully. However, the SQL Server Reporting Services (SSRS) service cannot load the custom report item. The custom report item does not display in any report in SQL Server 2012 Reporting Services.

## Resolution

To resolve this problem, you can safely ignore the warning message. The project will be compiled and can be deployed successfully to the report server.
