---
title: Install ASP.NET 4.5 in Windows 8
description: This article explains the problem that you can't install ASP.NET feature by using Aspnet_regiis.exe. It also provides a resolution to install/uninstall ASP.NET in Windows 8 and Windows Server 2012.
ms.date: 04/03/2020
ms.custom: sap:Configuration
ms.reviewer: pranavra
---
# Install ASP.NET 4.5 in Windows 8 and Windows Server 2012

This article explains why you can't install or uninstall ASP.NET 4.5 in Microsoft Windows 8 by using the Aspnet_regiis.exe utility, and helps you resolve this problem.

_Original product version:_ &nbsp; ASP.NET on .NET Framework 4.5.2, Windows 8, Windows Server 2012  
_Original KB number:_ &nbsp; 2736284

## Symptoms

In previous versions of Windows running Internet Information Services (IIS), the `aspnet_regiis -I` command could be used to install the ASP.NET feature. Starting in Windows 8, the following problems may occur when trying to install ASP.NET using the Aspnet_regiis.exe utility:

1. If you run `aspnet_regiis -I`  to install ASP.NET 4.5 on IIS 8, an error message like the following one will be displayed:

    > This option is not supported on this version of the operating system. Administrators should instead install/uninstall ASP.NET 4.5 with IIS8 using the Turn Windows Features On/Off dialog, the Server Manager management tool, or the `dism.exe` command line tool. For more details, please see https://go.microsoft.com/fwlink/?linkid=216771.

2. If you have an application that uses setup projects to install an application on IIS, the installation will fail to enable ASP.NET 4.5 and the application may fail to install.
3. If you install an application on Windows 8 that attempts to install ASP.NET 4.5 using `aspnet_regiis -I`, the application will fail to enable ASP.NET 4.5.

## Cause

The Aspnet_regiis.exe utility is no longer used for installing and uninstalling ASP.NET 4.5 in Windows 8. ASP.NET 4.5 is now a Windows component and can be installed and uninstalled just like any other Windows component.

## Resolution

To install or uninstall ASP.NET 4.5 in Windows 8 or Windows Server 2012, use one of the following options:

- Run the following command from an administrative command prompt:

    ```console
    dism /online /enable-feature /featurename:IIS-ASPNET45
    ```

- For Windows 8 client computers, turn on **IIS-ASPNET45** in **Turn Windows Features On/Off** under **Internet Information Services** > **World Wide Web Services** > **Application Development Features** > **ASP.NET 4.5**.
- For Windows Server 2012 computers, enable **IIS-ASPNET45** using Server Manager, under **Web Server (IIS)** > **Web Server** > **Application Development** > **ASP.NET 4.5**.
