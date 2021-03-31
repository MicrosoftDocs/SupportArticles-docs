---
title: The import of a solution is unsuccessful
description: Provides a solution to an error that occurs when you try to import a solution in Microsoft Dynamics CRM 2011.
ms.reviewer: chanson
ms.topic: troubleshooting
ms.date: 
---
# The import of a solution may be unsuccessful in Microsoft Dynamics CRM 2011

This article provides a solution to an error that occurs when you try to import a solution in Microsoft Dynamics CRM 2011.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2491352

## Symptoms

When you try to import a solution in Microsoft Dynamics CRM 2011, the import may not be successful. Additionally, you may receive the following error message:

> 0x80048298 - System.Web.Services.Protocols.SoapException: The report definition is not valid. Details: The report definition has an invalid target namespace `https://schemas.microsoft.com/sqlserver/reporting/2010/01/reportdefinition` which cannot be upgraded.
>
> at Microsoft.ReportingServices.WebServer.ReportingService2005Impl.CreateReport(String Report, String Parent, Boolean Overwrite, Byte[] Definition, Property[] Properties, Warning[]& Warnings)
>
> at Microsoft.ReportingServices.WebServer.ReportingService2005.CreateReport(String Report, String Parent, Boolean Overwrite, Byte[] Definition, Property[] Properties, Warning[]& Warnings)

## Cause

This problem occurs because one of the solution's custom reports is created within SQL Reporting Services 2008 R2. The first section of the error message means that the report was created in SQL Reporting Services 2008 R2. If you try to import the solution into a CRM environment that was configured by using SQL Reporting Services 2008, you receive the error message because the namespace of this version doesn't support the SQL Reporting Services 2008 R2 schema.

## Resolution

To resolve this problem, use one of the following methods.

### Method 1

Import the solution into an environment that was configured by using SQL Reporting Services 2008 R2.

### Method 2

Create the same report against a SQL Reporting Services 2008 environment. Then, upload the new report into Microsoft Dynamics CRM, and include the new report in your solution.
