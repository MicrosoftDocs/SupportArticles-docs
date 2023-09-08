---
title: Windows Installer reconfigured all applications
description: Fixes an error that indicates the Windows Installer reconfigured all installed applications.
ms.date: 09/23/2022
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:windows-management-instrumentation-wmi, csstroubleshoot
ms.technology: windows-server-administration-management-development
---
# Event log message indicates that the Windows Installer reconfigured all installed applications

This article helps fix slow system startup or slow login issues that occur when a group policy with a WMIFilter or installed application queries the `Win32_Product` class.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 974524

## Symptom

You may experience slow system startup or slow login issues. Additionally, you may see the following event in the Application Event log:

> Log Name: Application  
Source: MsiInstaller  
Date: mmddyyy hh:mm:ss  
Event ID: 1035  
Task Category: None  
Level: Information  
Keywords: Classic  
User: SYSTEM  
Computer:  
Description:  
Windows Installer reconfigured the product. Product Name: \<ProductName>. Product Version: \<VersionNumber>. Product Language: \<languageID>. Reconfiguration success or error status: 0.

You'll see this event for each of the installed application on the computer.

The system Event log will show that the Windows Installer Service is starting and stopping automatically.

> Event Type: Information  
Event Source: Service Control Manager  
Event Category: None  
Event ID: 7035  
Date: mmddyyyy  
Time: hh:mm:ss  
User: NT AUTHORITY\SYSTEM  
Computer: \<ComputerName>  
Description:  
The Windows Installer service was successfully sent a start control.
For more information, see Help and Support Center at <`http://go.microsoft.com/fwlink/events.asp`>.

> Event Type: Information  
Event Source: Service Control Manager  
Event Category: None  
Event ID: 7036  
Date: mmddyyyy  
Time: hh:mm:ss  
User: N/A  
Computer: \<ComputerName>  
Description:  
The Windows Installer service entered the stopped state.  
For more information, see Help and Support Center at <`http://go.microsoft.com/fwlink/events.asp`>.

## Cause

This problem can happen if one of the following conditions is true:

- You have a group policy with a WMIFilter that queries `Win32_Product` class.
- You have an application installed on the machine that queries `Win32_Product` class.

## Resolution

If you're using a group policy with the WMIFilter that queries `Win32_Product`, modify the filter to use `Win32reg_AddRemovePrograms`.

If you have an application that uses the previous class, contact the vendor to get an updated version that doesn't use this class.

To narrow down the application that causes the problem, you can follow the *Clean boot* troubleshooting method.

> [!NOTE]
> Using `Win32Reg_AddRemovePrograms` requires System Center Configuration Manager (SCCM) client to be installed. If SCCM is not installed, use the [StdRegProv](/previous-versions/windows/desktop/regprov/stdregprov) class instead.

## More information

`Win32_product` class isn't query optimized. Queries such as `select * from Win32_Product where (name like 'Sniffer%')` require WMI to use the MSI provider to enumerate all of the installed products and then parse the full list sequentially to handle the `where` clause. This process also starts a consistency check of packages installed, verifying, and repairing the install. An account with only user privileges may cause delay in application launch and an event 11708 stating an installation failure, as the user account may not have access to quite a few locations.

`Win32reg_AddRemovePrograms` is a much lighter and effective way to do so, which avoids the calls to do a resiliency check, especially in a locked down environment. So when using `Win32reg_AddRemovePrograms`, we won't be calling on msiprov.dll and won't be initiating a resiliency check.
