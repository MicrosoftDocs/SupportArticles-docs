---
title: Frame rate is limited to 30 FPS in remote sessions
description: Provides guidance for remote desktop protocols to change the frame rate limit in a remote session.
ms.date: 11/07/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, shenry, yuqinwu
ms.custom: sap:performance-audio-and-video-and-remotefx, csstroubleshoot
ms.subservice: rds
---
# Frame rate is limited to 30 FPS in Windows-based remote sessions

This article provides a solution for remote desktop protocols to change the frame rate limit in a remote session.

_Original KB number:_ &nbsp; 2885213

## Summary

Some remote display protocols, including Remote Desktop Protocol (RDP), don't support a frame rate that is greater than 30 frames per second (FPS).  

## Setting frame rates

To work around the issue, create a `DWMFRAMEINTERVAL` entry in registry subkey `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations` to change the maximum frame rate limit on the remote session host.

> [!NOTE]
> The registry entry that's described in the following procedure sets the maximum frame rate limit that the remote display protocol can deliver to the remote session client. This setting does not set the actual frame rate for the remote session client. The actual frame rate in the remote session depends on other factors such as application and computer hardware resources. Please contact the remote display protocol providers for more information.

[!INCLUDE [Registry important alert](../../includes/registry-important-alert.md)]

To do configure the registry entry, follow these steps:

1. Start Registry Editor.
2. Go to the following registry subkey:  
 `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations`
3. On the **Edit** menu, select **New**, and then select **DWORD(32-bit) Value**.
4. Type *DWMFRAMEINTERVAL*, and then press <kbd>Enter</kbd>.
5. Right-click **DWMFRAMEINTERVAL**, and select **Modify**.
6. Select **Decimal**, type *15* in the **Value data** box, and then select **OK**. This sets the maximum frame rate to 60 FPS.
7. Exit Registry Editor, and then restart the computer.

## Frame rate mapping

- 15 decimal = 60 frames
- 10 decimal = 40 frames
- 5 decimal  = 20 frames
- 1 decimal  =  4 frames
