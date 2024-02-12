---
title: An App-V v5 virtualized application fails to start with error 0xc0000142
description: Provides a solution to the issue a Microsoft Application Virtualization version 5 (App-V) virtualized application fails to start with an application error 0xc0000142.
ms.date: 12/04/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, gautama
ms.custom: sap:application-does-not-load-or-run, csstroubleshoot
---
# An App-V v5 virtualized application fails to start with error 0xc0000142

This article provides a solution to the issue a Microsoft Application Virtualization version 5 (App-V) virtualized application fails to start with an application error 0xc0000142.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2777003

## Symptoms

The error appears as a popup message stating:
> The application was unable to start correctly (0xc0000142). Click OK to close the application.

You also see a related App-V Event for this application launch failure:
> Log Name: Microsoft-AppV-Client/Virtual Applications  
Source: Microsoft-AppV-Client  
Date:  
Event ID: 18005  
Task Category: Application Launch  
Level: Error  
Keywords: Virtual Application Launch  
User: contoso\\user1  
Computer: TEST-PC  
Description:  
The virtual application 'path to virtualized executable' could not be started because the App-V Subsystem 'Virtual Filesystem' could not be initialized. {error: 0x74300C0A-0x20006}

## Cause

This can occur if an NTFS setting called 8.3 Short name creation is disabled on the machine. This setting is governed by the value data of this registry key: `KEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem\NtfsDisable8dot3NameCreation`.

## Resolution

You need to enable NTFS 8.3 Short name functionality on the client. To do this set the value of `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem\NtfsDisable8dot3NameCreation` to 2 and reboot the machine. For more information on enabling and disabling NTFS 8.3 Short names, see [How to disable 8.3 file name creation on NTFS partitions](https://support.microsoft.com/help/121007)

> [!Note]
> If the package was added to the client when Short names were disabled, you might need to remove the package using the PowerShell command Remove-AppvClientPackage and re-add the package using the method it was added initially. In addition to this, you might also need to remove the user specific information about the package. To do this, delete %LOCALAPPDATA%\\Microsoft\\AppV\\Client\\VFS\\\<PackageID>.
>
> If Short names were disabled on the Sequencer, but enabled on the clients, the Package should be unpublished, re-sequenced after enabling Short names on the Sequencer, and then re-published to the clients.

## More Information

For more information about NtfsDisable8dot3NameCreation, see [NtfsDisable8dot3NameCreation](/previous-versions/windows/it-pro/windows-server-2003/cc778996(v=ws.10)).
