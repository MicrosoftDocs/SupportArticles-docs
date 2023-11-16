---
title: Numerous "Event ID 1216"
description: Provides a resolution for the issue that numerous "Event ID 1216" Events occur in Directory Services Event Log.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:active-directory-lightweight-directory-services-ad-lds-and-active-directory-application-mode-adam, csstroubleshoot
ms.technology: windows-server-active-directory
---
# Numerous "Event ID 1216" Events in Directory Services Event Log

This article provides a resolution for the issue that numerous "Event ID 1216" Events occur in Directory Services Event Log.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 246717

> [!NOTE]
> This article contains information about modifying the registry. Before you modify the registry, make sure to back it up and make sure that you understand how to restore the registry if a problem occurs. For information about how to back up, restore, and edit the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
 [256986](https://support.microsoft.com/help/256986) Description of the Microsoft Windows Registry  

## Symptoms

You may find multiple instances of the following entry in the Directory Services event log:

>Event Type:Warning  
Event Source:NTDS LDAP  
Event Category:LDAP Interface  
Event ID:1216  
Date:*\<DateTime>*  
Time:*\<DateTime>*  
User:N/A  
Computer:Computer  
Description:  
The LDAP server closed a socket to a client because of an error condition, 1234. (Internal ID c01028c::4294967295).  

>[!NOTE]
The Internal ID value varies with each instance.

## Cause

This event log message occurs when a Lightweight Directory Access Protocol (LDAP) client sends a request to the computer by using User Datagram Protocol (UDP), but does not keep its socket open to listen for the response from the server. When the server tries to send the answer back, the error message is logged to the event log. It is a harmless error that can occur frequently under normal operating conditions. It occurs only if the diagnostic logging level is increased by modifying the level of LDAP logging to 2 or more in the registry.

## Resolution

> [!WARNING]
> If you use Registry Editor incorrectly, you may cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that you can solve problems that result from using Registry Editor incorrectly. Use Registry Editor at your own risk.  

To resolve this issue:

1. Start Registry Editor (Regedt32.exe).
2. Locate the LDAP Interface Events value in the following registry key:  HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Diagnostics
3. Set the data value of the LDAP Interface Events value to a lower setting, and then click OK.
4. Quit Registry Editor.  

The default value for this registry value is 0.
