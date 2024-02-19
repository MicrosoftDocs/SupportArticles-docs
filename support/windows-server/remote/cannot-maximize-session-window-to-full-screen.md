---
title: Can't maximize RDC session window to full-screen
description: Describes an issue where you can't maximize the Remote Desktop Connection session window to full-screen by using the Mstsc command together with the /v parameter. Provides a resolution to this issue.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:remote-desktop-sessions, csstroubleshoot
---
# You can't maximize a Remote Desktop Connection session window to full-screen when you use the /v parameter

This article provides a solution to an issue where you can't maximize a Remote Desktop Connection session window to full-screen when you use the [Mstsc](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc753907(v=ws.10)) `/v` command.

_Applies to:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 980876

## Symptoms

When you connect to a remote computer by using the Mstsc command-line tool together with the `/v` parameter in Windows 7, you can't maximize the window of the session to full-screen.

## Cause

This issue occurs if the display setting in Remote Desktop Connection was changed from the default setting (Full Screen) to a different setting. This setting change is saved in the Default.rdp file. When a connection starts by using the `/v` parameter, the display setting that is saved in the Default.rdp file is used.

## Resolution

To resolve this issue, change the display setting in Remote Desktop Connection to full-screen by following these steps:

1. Click **Start** > **All Programs** > **Accessories** > **Remote Desktop Connection**.
2. In the **Remote Desktop Connection** dialog box, click **Options**.
3. Click the **Display** tab.
4. Move the **Display configuration** slider to **Large** (Full Screen), and then connect to the remote computer.

When you now connect to a remote computer by using the `/v` parameter, you can maximize the window of the session to full-screen.
