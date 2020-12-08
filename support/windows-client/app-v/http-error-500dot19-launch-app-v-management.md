---
title: HTTP Error 500.19 - Internal Server Error when launching the App-V Management Console
description: 
ms.date: 12/07/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: 
---
# HTTP Error 500.19 - Internal Server Error when launching the App-V Management Console

_Original product version:_ &nbsp; App-V 5.0 for Remote Desktop Services, App-V 5.0 for Windows Desktops, Microsoft Application Virtualization Hosting 5.0 for Windows Desktops  
_Original KB number:_ &nbsp; 2800730

## Symptoms

When the App-V 5.0 Management console is installed on a drive other than the C: drive, launching the console may fail and generate the following error message:

*HTTP Error 500.19 - Internal Server Error*  
** *Module IIS Web Core*  
** *Notification Unknown*  
** *Handler Not yet determined*  
** *Error Code 0x80070005*  
** *Config Error Cannot read configuration file due to insufficient permissions*  
** *Config File* *\\?\E:\Program* *Files\Microsoft Application Virtualization Server\ManagementService\web.config*  

## Cause

This occurs due to invalid NTFS permissions on the drive hosting the App-V 5.0 Management Service INSTALLDIR directory.

## Resolution

To resolve this issue, give the local computers Users group Read & execute, List folder contents and Read permissions to the root of the drive the hosts the App-V Management consoles INSTALLDIR directory. The INSTALLDIR parameter can be found referencing the following registry key:

HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\AppV\Server\ManagementService 

The local computer User group contains the following users by default:

Local Administrator Account
NT AUTHORITY\Authenticated users (S-1-5-11)
NT AUTHORITY\INTERACTIVE (S-1-5-4)
Domain\Domain users

After updating the permissions on the drive that hosts the INSTALLDIR directory, either stop and start the Microsoft App-V Management Service website in IIS or issue an IISRESET.

## More Information

Process Monitor can be used to troubleshoot these types of issues.

Process Monitor v3.03: [https://technet.microsoft.com/sysinternals/bb896645.aspx](https://technet.microsoft.com/sysinternals/bb896645.aspx)
