---
title: Frame rate is limited to 30 FPS in remote sessions
description: Provides a workaround for independent software vendors (ISVs) of remote display protocols to change the frame rate limit in a remote session.
ms.date: 01/06/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, shenry, yuqinwu
ms.custom: sap:performance-audio-and-video-and-remotefx, csstroubleshoot
ms.technology: windows-server-rds
---
# Frame rate is limited to 30 FPS in Windows-based remote sessions

This article describes a workaround for independent software vendors (ISVs) of remote display protocols to change the frame rate limit in a remote session.

_Original KB number:_ &nbsp; 2885213

[!INCLUDE [Registry important alert](../../includes/registry-important-alert.md)]

To work around the issue, create a `DWMFRAMEINTERVAL` entry in registry subkey `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations` to change the maximum frame rate limit on the remote session host. To do this, follow these steps:

1. Start Registry Editor.
2. Go to the following registry subkey:  
 `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations`
3. On the **Edit** menu, select **New**, and then select **DWORD(32-bit) Value**.
4. Type *DWMFRAMEINTERVAL*, and then press <kbd>Enter</kbd>.
5. Right-click **DWMFRAMEINTERVAL**, and select **Modify**.
6. Select **Decimal**, type *15* in the **Value data** box, and then select **OK**. This sets the maximum frame rate to 60 frames per second (FPS).

    > [!NOTE]
    > This registry entry sets the maximum frame rate limit that the remote display protocol can deliver to the remote session client. This setting does not set the actual frame rate for the remote session client. The actual frame rate in the remote session depends on other factors such as application and computer hardware resources. Additionally, not all remote display protocols support a frame rate that is greater than 30 FPS. For example, Remote Desktop Protocol (RDP) limits the frame rate to 30 FPS. Please contact the remote display protocol providers for more information.
7. Exit Registry Editor, and then restart the computer.
