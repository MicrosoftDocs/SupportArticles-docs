---
title: Can't use Custom Report Items in SSDT
description: This article provides a workaround to resolve a problem that prevents you from using Custom Report Items in SQL Server Data Tools for Visual Studio 2015 and Visual Studio 2017.
ms.date: 04/27/2020
ms.custom: sap:SQL Server Data Tools (SSDT)\Reporting Services Project
ms.reviewer: bradsy, daleche, aartigoyle
---
# Can't use Custom Report Items in SQL Server Data Tools for Visual Studio 2015 and Visual Studio 2017

This article helps you resolve the problem that prevents you from using Custom Report Items in SQL Server Data Tools for Microsoft Visual Studio 2015 and Visual Studio 2017.

_Original product version:_ &nbsp; Visual Studio 2015, Visual Studio 2017  
_Original KB number:_ &nbsp; 4013914

## Symptoms

When you use SQL Server Data Tools for Visual Studio 2015 17.x release and Visual Studio 2017, you are blocked from using Custom Report Items that are older than current release. The affected component is the Reporting Services Report Designer.  

## Workaround

To work around this issue, modify the *Devenv.exe.config* file by adding or editing the following entries. This file is located in `programInstallDir\common7\ide`.  

```xml
<dependentAssembly>
    <assemblyIdentity name="Microsoft.ReportingServices.Interfaces" publicKeyToken="89845dcd8080cc91" culture="neutral" />
    <bindingRedirect oldVersion="9.0.242.0-13.0.0.0" newVersion="14.0.0.0"/>
</dependentAssembly>
<dependentAssembly>
    <assemblyIdentity name="Microsoft.ReportingServices.Designer" publicKeyToken="89845dcd8080cc91" culture="neutral" />
    <bindingRedirect oldVersion="9.0.242.0-13.0.0.0" newVersion="14.0.0.0"/>
</dependentAssembly>
<dependentAssembly>
    <assemblyIdentity name="Microsoft.ReportingServices.QueryDesigners" publicKeyToken="89845dcd8080cc91" culture="neutral" />
    <bindingRedirect oldVersion="9.0.242.0-13.0.0.0" newVersion="14.0.0.0"/>
</dependentAssembly>
```

## More information

The *Devenv.exe.config* file is included with Visual Studio. For Visual Studio 2015, there are no more updates. For Visual Studio 2017, Microsoft will make a change. However, the change will not be released until Visual Studio 2017 Update 2. In the RTM version, you will still experience this issue.  

## Applies to

Microsoft has confirmed that this is a problem in the products that are listed as following items:

- Visual Studio Enterprise 2015
- Visual Studio Professional 2015
- Visual Studio Express 2015 for Web
- Visual Studio Enterprise 2017
