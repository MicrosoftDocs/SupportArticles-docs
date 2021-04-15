---
title: Visual Studio 2015 stops working
description: Provides a solution to an error that occurs when you start SQL Server Data Tools for Visual Studio.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
---
# Visual Studio 2015 stops working after installing the Microsoft Dynamics 365 Report Authoring Extension

This article provides a solution to an error that occurs when you start SQL Server Data Tools for Visual Studio.

_Applies to:_ &nbsp; Microsoft Dynamics CRM  
_Original KB number:_ &nbsp; 4032777

## Symptoms

> [!NOTE]
> The issue described here has been resolved with version 8.2.2.248 of the Microsoft Dynamics 365 Report Authoring Extension.

In the following scenario:

- You've Visual Studio 2015 with SQL Server Data Tools installed.
- You install the Microsoft Dynamics 365 Report Authoring Extension (version 8.2.2.0171)

When you start SQL Server Data Tools for Visual Studio, Visual Studio closes with the message:

> "Microsoft Visual Studio 2015 has stopped working."  

The error in the Windows Event Viewer may look like this:

> Application: devenv.exe  
Description: The process was terminated due to an unhandled exception.  
Exception Info: System.IO.FileNotFoundException  
at Microsoft.VisualStudio.Services.Client.AccountManagement.AccountManager.GetAccountProviderCore(System.Guid)  
at Microsoft.VisualStudio.Services.Client.AccountManagement.AccountManager+<>c__DisplayClass32_0.\<GetAccountProviderAsync>b__0()  
at System.Threading.Tasks.Task\`1[[System.__Canon, mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089]].InnerInvoke()  
at System.Threading.Tasks.Task.Execute()  
at System.Runtime.CompilerServices.TaskAwaiter.ThrowForNonSuccess(System.Threading.Tasks.Task)

Uninstalling the Report Authoring Extension doesn't resolve the problem.

## Cause

This issue occurs because of an issue in the Report Authoring Extension setup process. When the Report Authoring Extension is installed using the default installation path, the following assemblies are placed into `C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE`, replacing any older versions of the files already in that location.

- Microsoft.IdentityModel.Clients.ActiveDirectory.dll - File Version: 2.22.x.x
- Microsoft.IdentityModel.Clients.ActiveDirectory.WindowsForms.dll - File Version: 2.22.x.x

Visual Studio attempts to load older versions of the files that don't exist, because the devenv.exe.config file contains a binding redirect entry that still points to version 2.16.0.0. The Report Authoring Extension setup process didn't update the binding redirect to point to version 2.22.0.0 when the files were replaced.

## Resolution

To resolve this issue, follow these steps to change the binding redirects in the devenv.exe.config file to point to version 2.22.0.0:

- Edit these two files to change the value of the versions for the bindingRedirect entry to the correct version, 2.22.0.0:
  - `C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE` - devenv.exe.config
  - `C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\PrivateAssemblies` - PreviewProcessingService.exe.config

  > [!NOTE]
  > If you used a different installation location than the default, you'll need to modify the path to these files to the location where you installed Visual Studio.  
  > If the PreviewProcessingService.exe.config file doesn't already contain the bindingRedirect, you don't need to add it.

- Find the following sections in both of the files:

    ```xml
    <dependentAssembly>
        <assemblyIdentity name="Microsoft.IdentityModel.Clients.ActiveDirectory" publicKeyToken="31bf3856ad364e35" culture="neutral" />
        <bindingRedirect oldVersion="2.0.0.0-2.16.0.0" newVersion="2.16.0.0" />
    </dependentAssembly>
    <dependentAssembly>
        <assemblyIdentity name="Microsoft.IdentityModel.Clients.ActiveDirectory.WindowsForms" publicKeyToken="31bf3856ad364e35" culture="neutral" />
        <bindingRedirect oldVersion="2.0.0.0-2.16.0.0" newVersion="2.16.0.0" />
    </dependentAssembly>
    ```

- Change the following line from:  

    `<bindingRedirect oldVersion="2.0.0.0-2.16.0.0" newVersion="2.16.0.0" />`  
    To:  
    `<bindingRedirect oldVersion="2.0.0.0- **2.22.0.0**" newVersion="**2.22.0.0**" />`

- Save the file and restart Visual Studio.
