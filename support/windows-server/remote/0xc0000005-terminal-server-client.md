---
title: Error when you log on to Terminal Server client
description: Provides a solution to an issue that occurs when you log on to a computer running Terminal Server Edition.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:connecting-to-a-session-or-desktop, csstroubleshoot
ms.technology: windows-server-rds
---
# Error message: an application error has occurred and an application error log is being generated

This article provides help to solve an issue that occurs when you log on to a computer running Terminal Server Edition.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 240992

> [!IMPORTANT]
> This article contains information about modifying the registry. Before you modify the registry, make sure to back it up and make sure that you understand how to restore the registry if a problem occurs. For information about how to back up, restore, and edit the registry, click the following article number to view the article in the Microsoft Knowledge Base:
 [256986](https://support.microsoft.com/help/256986) Description of the Microsoft Windows Registry  

## Symptoms

When you log on to a computer running Terminal Server Edition, you may receive the following error message:

> An application error has occurred and an application error log is being generated.
Userinit.exe  
Exception: access violation (0xc0000005), Address: 0x77f901b3

> [!NOTE]
> The address value may be different, depending on your computer configuration.

The Terminal Server client is disconnected after you click OK or Cancel.

## Cause

This behavior occurs because an invalid value exists in the registry.

## Resolution

To resolve this problem, obtain the latest service pack for Windows NT Server 4.0, Terminal Server Edition.

## Workaround

> [!WARNING]
> If you use Registry Editor incorrectly, you may cause serious problems that may require you to reinstall your operating system. Microsoft cannot guarantee that you can solve problems that result from using Registry Editor incorrectly. Use Registry Editor at your own risk.  

To work around this issue, delete the invalid registry value:

1. Start **Registry Editor** (Regedt32.exe).
2. Locate the following registry key: `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Terminal Server\Install\IniFile Times`
3. Locate the invalid value (this is usually a value with no name).
4. Click the invalid value.
5. On the **Edit** menu, click **Delete**, and then click **Yes**.
6. Quit **Registry Editor**.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed at the beginning of this article. This problem was first corrected in Windows NT 4.0 Server, Terminal Server Edition, Service Pack 5.
