---
title: Event ID 10000 when Terminal Server is enabled
description: Describes a problem where event ID 10000 is logged in the Application log when you use a Terminal Server computer that is running Windows Server 2003. To resolve this problem, you must modify the registry, as described here.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:connecting-to-a-session-or-desktop, csstroubleshoot
---
# Event ID 10000 is logged in the Application log on a Windows Server 2003-based computer that has Terminal Server enabled

This article provides a solution to an issue where event ID 10000 is logged in the Application log when you use a Terminal Server computer that is running Windows Server 2003.

_Applies to:_ &nbsp; Windows Server 2003  
_Original KB number:_ &nbsp; 914052

> [!IMPORTANT]
> This article contains information about how to modify the registry. Make sure to back up the registry before you modify it. Make sure that you know how to restore the registry if a problem occurs. For more information about how to back up, restore, and modify the registry, click the following article number to view the article in the Microsoft Knowledge Base:  
[256986](https://support.microsoft.com/help/256986) Description of the Microsoft Windows registry  

## Symptoms

When you try to connect to a Microsoft Windows Server 2003-based computer that has Terminal Server enabled, an event that is similar to the following is logged in the Application log:

> Event Type:Error Event Source:DCOM Event Category:None Event ID:10000 Date:\<Date> Time:\<Time> User:N/A Computer: Computer_Name  
> Description: Unable to start a DCOM Server: {0002DF01-0000-0000-C000-000000000046} The error: "%%233" Happened while starting this command: \<command> -Embedding

> [!NOTE]
> **Computer_Name** is the name of the Terminal Server computer.

## Cause

This issue occurs when registry entries that are required for Winlogon notifications are missing from the registry of the Terminal Server computer.

## Resolution

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall your operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk. To resolve this issue, add the following registry entries to the registry of the Terminal Server computer. To do this, follow these steps:

1. Click **Start**, click **Run**, type regedit in the **Open** box, and then click
 **OK**.
2. Locate the following registry subkey:  
`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\Notify\termsrv`  

3. Under this subkey, add the following registry entries:

    |Name|Type|Value data|
    |---|---|---|
    |Logoff|REG_SZ|TSEventLogoff|
    |Logon|REG_SZ|TSEventLogon|

4. Restart the Terminal Server computer.
