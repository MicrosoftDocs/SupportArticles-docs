---
title: Can't maximize RDC session window to full-screen
description: Describes an issue in which you cannot maximize the window of the session to full-screen when you start Remote Desktop Connection by using the Mstsc command together with the /v parameter. Provides a resolution to this issue.
ms.date: 09/22/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Remote desktop sessions
ms.technology: windows-server-rds 
---
# You cannot maximize a Remote Desktop Connection session window to full-screen when you use the /v parameter

This article provides a solution to an issue where you can't maximize a Remote Desktop Connection session window to full-screen when you use the [Mstsc](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc753907(v=ws.10)) `/v` command.

_Original product version:_ &nbsp; Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 980876

## Symptoms

When you connect to a remote computer by using the Mstsc command line tool together with the `/v` parameter in Windows 7, you cannot maximize the window of the session to full-screen.

## Cause

This issue occurs if the display setting in Remote Desktop Connection was changed from the default setting of Full Screen to a different setting. This setting change is saved in the Default.rdp file. When a connection starts by using the `/v` parameter, the display setting that is saved in the Default.rdp file is used.

## Resolution

To resolve this issue, change the display setting in Remote Desktop Connection to full-screen. To do this, follow these steps:

1. Click **Start**, click **All Programs**, click **Accessories**, and then click **Remote Desktop Connection**.
2. In the **Remote Desktop Connection** dialog box, click **Options**.
3. Click the **Display** tab.
4. Move the **Display configuration** slider to **Large** (Full Screen), and then connect to the remote computer.

When you now connect to a remote computer by using the `/v` parameter, you can maximize the window of the session to full-screen.
