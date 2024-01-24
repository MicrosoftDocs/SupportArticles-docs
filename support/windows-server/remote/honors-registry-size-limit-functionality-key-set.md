---
title: Registry Size Limit (RSL) functionality is still be honored if the RegistrySizeLimit registry key is set
description: Helps to solve the issue that Registry Size Limit (RSL) functionality is still be honored if the RegistrySizeLimit registry key is set
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:connecting-to-a-session-or-desktop, csstroubleshoot
ms.subservice: rds
---
# Registry Size Limit (RSL) functionality is still be honored if the RegistrySizeLimit registry key is set

This article provides a resolution for the issue that Registry Size Limit (RSL) functionality is still be honored if the RegistrySizeLimit registry key is set.

_Applies to:_ &nbsp; Windows Server 2012 R2, Windows 10 - all editions, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 2567018

## Symptoms

Users may be unable to login to a Windows Server 2008 or Windows Server 2003 Terminal Server. When logging on to the server, you receive the following error:

> ERROR  
>
> ======  
Windows cannot log you on because your profile cannot be loaded.
Check that you are connected to the network, or that your network is functioning correctly.
If this problem persists, contact your network administrator.  
DETAIL - Insufficient system resources exist to complete the requested service.  
>
> ======

Additionally, a Windows Server 2008-based computer may log the following event in the Application Event Log:  

> Log Name: Application  
Source: Microsoft-Windows-User Profiles Service  
Date: DATE  
Event ID: 1508  
Task Category: None  
Level: Error  
Keywords: Classic  
User: SYSTEM  
Computer: computer name  
Description: Windows was unable to load the registry. This problem is often caused by insufficient memory or insufficient security rights.  
DETAIL - The process cannot access the file because it is being used by another process. for C:\Users\UserProfile\ntuser.dat

Windows Server 2003-based servers may log the following events in the System and Application Event Logs:  

> Event Type: Error  
Event Source: Application Popup  
Event Category: None  
Event ID: 333  
Date: date  
Time: time  
User: N/A  
Computer: computer name  
Description: An I/O operation initiated by the Registry failed unrecoverably. The Registry could not read in, or write out, or flush, one of the files that contain the system's image of the Registry.
>
> Event Type: Error  
Event Source: Userenv  
Event Category: None  
Event ID: 1508  
Date: Date  
Time: Time  
User: NT AUTHORITY\SYSTEM  
Computer: Computer Name  
Description: Windows was unable to load the registry. This is often caused by insufficient memory or insufficient security rights. DETAIL - Insufficient system resources exist to complete the requested service. for C:\Documents and Settings\user\ntuser.dat  
>
> Event Type: Error  
Event Source: Userenv  
Event Category: None  
Event ID: 1500  
Date: Date  
Time: Time  
User: NT AUTHORITY\SYSTEM  
Computer: Computer Name  
Description: Windows cannot log you on because your profile cannot be loaded. Check that you are connected to the network, or that your network is functioning correctly. If this problem persists, contact your network administrator. DETAIL - Insufficient system resources exist to complete the requested service.  
>
> Event Type: Information  
Event Source: Application Popup  
Event Category: None  
Event ID: 26  
Date: Date  
Time: Time  
User: NT AUTHORITY\SYSTEM  
Computer: Computer Name  
Description: Application popup: Windows - Low On Registry Space: The system has reached the maximum size allowed for the system part of the registry. Additional storage requests will be ignored.  
>
> Rebooting the server might resolve the issue temporarily.

## Cause

Windows Server 2003, 2008 and 2008 R2 still honor the Registry Size Limit (RSL) functionality if the RegistrySizeLimit registry key is set to a value other than 0.

## Resolution

If the RegistrySizeLimit key exists or is set to a value other than 0, delete the key or set it to 0. This will allow the operating system to automatically set the registry size as needed. It is recommended to delete this registry key unless it is specifically required for another reason. 

If RegistrySizeLimit is not present or is set to 0, the registry size limit will be automatically set to one third of the max paged pool size.

Important: This Information also applies to client operating systems like Windows XP, Windows Vista and Windows 7.
