---
title: Frame rate is limited to 30 FPS in remote sessions
description: Provides a workaround for independent software vendors (ISVs) of remote display protocols to change the frame rate limit in a remote session.
ms.date: 10/20/2020
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
# Frame rate is limited to 30 FPS in Windows 8 and Windows Server 2012 remote sessions

This article describes a workaround for independent software vendors (ISVs) of remote display protocols to change the frame rate limit in a remote session.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2885213

## Workaround

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To work around the issue, create a **DWMFRAMEINTERVAL** entry in registry subkey `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations` to change the maximum frame rate limit on the remote session host. To do this, follow these steps:

1. Start Registry Editor.
2. Locate and then click the following registry subkey:  
 `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations`
3. On the **Edit** menu, click **New**, and then click **DWORD(32-bit) Value**.
4. Type *DWMFRAMEINTERVAL*, and then press Enter.
5. Right-click **DWMFRAMEINTERVAL**, click **Modify**.
6. Click **Decimal**, type 15 in the **Value data** box, and then click **OK**. This sets the maximum frame rate to 60 frames per second (FPS).

    > [!NOTE]
    > This registry entry sets the maximum frame rate limit that the remote display protocol can deliver to the remote session client. This setting does not set the actual frame rate for the remote session client. The actual frame rate in the remote session depends on other factors such as application and computer hardware resources. Additionally, not all remote display protocols support a frame rate that is greater than 30 FPS. For example, Remote Desktop Protocol (RDP) limits the frame rate to 30 FPS. Please contact the remote display protocol providers for more information.
7. Exit Registry Editor, and then restart the computer.
