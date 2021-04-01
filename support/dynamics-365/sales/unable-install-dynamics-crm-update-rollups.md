---
title: Unable to Install Microsoft Dynamics CRM Update Rollups
description: This article provides a resolution for the problem that occurs when you install Update Rollups for Microsoft Dynamics CRM.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 
---
# Unable to Install Microsoft Dynamics CRM Update Rollups

This article provides a resolution for the problem that occurs when you install Update Rollups for Microsoft Dynamics CRM.

_Applies to:_ &nbsp; Microsoft Dynamics CRM 2011  
_Original KB number:_ &nbsp; 2877080

## Symptoms

When attempting to install an Update Rollup on a Microsoft Dynamics CRM Server, users may encounter errors such as the following:

> "Could not load type 'Microsoft.Crm.OrganizationFeatureControlChecks' from assembly 'Microsoft.Crm, Version=5.0.0.0, Culture=neutral, PublicKeyToken=\<Token>'."

## Cause

Non-standard assemblies from a previous version of the Microsoft Dynamics CRM application had been copied into the server's global assembly cache

## Resolution

By default, the only assemblies that the Microsoft Dynamics CRM application has in the global assembly cache are the Microsoft.Crm.SdkTypeProxy.dll and Microsoft.Crm.SdkTypeProxy.XmlSerializers.dll. All other Microsoft Dynamics CRM assemblies should be removed from the global assembly cache.

## More information

To view the Global Assembly Cache, please see the link below:

[Gacutil.exe (Global Assembly Cache Tool)](/dotnet/framework/tools/gacutil-exe-gac-tool)
