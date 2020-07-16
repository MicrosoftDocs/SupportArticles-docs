---
title: Issues for Visual Studio 2010 SP1 in Windows 8
description: This article lists known issues for Visual Studio 2010 Service Pack 1 in Windows 8.
ms.date: 04/22/2020
ms.prod-support-area-path:
ms.reviewer: meyoun
---
# Known issues for Visual Studio 2010 SP1 in Windows 8

This article lists known issues that you may experience, and provides workarounds after you install Microsoft Visual Studio 2010 Service Pack 1 (SP1) on a computer that is running Windows 8.

_Original product version:_ &nbsp; Visual Studio 2010  
_Original KB number:_ &nbsp; 2735834

## Issue 1: Can't publish a website/web application by IIS settings

When you try to publish a website or a web application to `http://localhost` by using Internet Information Services (IIS) settings in Visual Studio 2010 on a computer that is running Windows 8, you receive an error message that resembles the following:

> There was an error reading IIS configuration schema from "C:\Windows\system32\inetsrv\config\schema\"

This problem doesn't occur when you publish the website or the web application without using IIS settings.

### Two methods to work around this issue

To work around this issue, use one of the following methods:

- Use Microsoft Visual Studio 2012 to publish the website or the web application.
- Use the latest Microsoft Azure SDK for .NET (Visual Studio 2010 SP1) to publish the website or the web application. Microsoft Azure SDK for .NET provides an updated Web publish experience, and won't cause this problem. The following file is available for download from the Microsoft Download Center:  
    [Download the Microsoft Azure SDK for .NET (VS 2010 SP1) package now.](https://go.microsoft.com/fwlink/?linkid=254269)

    For more information about how to download Microsoft support files, see [How to obtain Microsoft support files from online services](https://support.microsoft.com/help/119591).

    Microsoft scanned this file for viruses. Microsoft used the most current virus-detection software that was available on the date that the file was posted. The file is stored on security-enhanced servers that help prevent any unauthorized changes to the file.

## Issue 2: Can't connect to a remote VSS database through an HTTPS connection

When you try to connect to a remote Visual SourceSafe (VSS) database through an HTTPS connection in Visual Studio 2010 SP1 on a computer that is running Windows 8, you may receive an error message that resembles the following:

> A certificate is required to complete client authentication

This problem occurs randomly.

## Issue 3: Can't install or uninstall .NET Framework 4.5 by Aspnet_regiis.exe

When you try to run the ASP.NET IIS Registration Tool (Aspnet_regiis.exe) together with the `-i` , the `-u` , or the `-r` command option in Windows Server 2012 or in Windows 8, you can't install or uninstall the Microsoft .NET Framework 4.5.

### Three methods to work around this issue

To work around this issue, use one of the following methods to install or uninstall the .NET Framework 4.5:

1. Use the **Turn Windows Features on or off** option in Control Panel in Windows 8.
2. Use the Server Manager management tool in Windows Server 2012.
3. Run the necessary commands in the Deployment Image Servicing and Management (DISM.exe) command-line tool.

For more information about how to enable the.NET Framework 4.5 to be used with IIS 8.0, see [How to use ASP.NET 3.5 and ASP.NET 4.5 in IIS 8.0](/iis/get-started/whats-new-in-iis-8/iis-80-using-aspnet-35-and-aspnet-45).

## Issue 4: Can't install SQL Server 2008 SP1 together with VS2010 SP1

You can't install Microsoft SQL Server 2008 SP1 on a Windows 8-based or Windows Server 2012-based computer that has Visual Studio 2010 SP1 installed.

### Workaround

To work around this issue, apply SQL Server 2008 Service Pack 3 (SP3) or a later version of SQL Server 2008.

For more information about how to obtain the latest service pack for SQL Server 2008, see [How to obtain the latest service pack for SQL Server 2008](https://support.microsoft.com/help/968382).

## Issue 5: VS 2010 SP1 Profiling Tools can't start or data collected by Concurrency Visualizer can't be displayed

- **Symptoms 1**

  Assume that you try to use one of following methods in Visual Studio 2010 SP1 Profiling Tools on a Windows 8-based computer to analyze the performance of an application:

  - CPU sampling
  - .NET memory allocation (sampling)
  - Resource contention data (concurrency)

  In this situation, the profiling tool can't start. Additionally, you receive an error message that resembles the following:

  > Unable to start VSPerfDrv100. The service cannot be started, either because it is disabled or because it has no enabled devices associated with it.

  This issue occurs because there's an incompatibility between the Visual Studio 2010 SP1 driver and Windows 8.

- **Symptoms 2**

  When you use Concurrency Visualizer to collect data, the collected data can't be displayed in the report view.

  This issue occurs because the Windows event schema is changed in Windows 8.

  To work around these problems, use Visual Studio 2012 Profiling Tools on a Windows 8-based computer.
