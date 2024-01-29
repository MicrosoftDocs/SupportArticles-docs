---
title: Remote Desktop session doesn't terminate
description: Resolve an issue where Remote Desktop that specifies a program to start on logon doesn't terminate when the specified program is exited.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:remote-desktop-sessions, csstroubleshoot
ms.subservice: rds
---
# Remote Desktop or RemoteApp session does not terminate due to spawned splwow64.exe process

This article provides a solution to solve an issue where Remote Desktop that specifies a program to start on logon doesn't terminate when the specified program is exited.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2513330

## Symptoms

A Remote Desktop session that specifies a program to start on logon may not terminate in a timely manner when the specified program is exited. The remote session may appear empty with only a blank background.

This program may be specified under "Start the following program on connection" in RDP client settings or "Start the following program at logon" in Active Directory user properties.

## Cause

The specified program may have spawned a new process. As part of the Remote Desktop session termination logic, if the specified program spawns a new process that new process is considered part of the program and the session will not terminate until that process also terminates.  

One scenario that meets this criteria is printing from a 32-bit application on a 64-bit Remote Desktop Session Host. This printing action will spawn splwow64.exe, the 32-bit to 64-bit thunking process for spooler. Splwow64.exe has a 3-minute timeout to prevent the process from being repeatedly respawned during heavy printing, so it does not immediately exit when printing is complete. This can cause the remote session to appear "hung" with a blank background.

## Resolution

You can add the splwow64.exe process to the following registry key to tell the operating system that the process may be safely terminated automatically:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\Sysprocs`

Value name: splwow64.exe  
Data type: REG_DWORD  
Base: Hex  
Value data: 0  

## More information

[Terminal Services RemoteApp Session Termination Logic](https://techcommunity.microsoft.com/t5/microsoft-security-and/terminal-services-remoteapp-8482-session-termination-logic/ba-p/246566)
