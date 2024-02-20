---
title: Local computer behaves as if the Windows logo key is pressed after you switch from a Remote Desktop session
description: Fixes an issue in which the Windows logo key is displayed as pressed after you use an RDP session in Windows.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, yaimairi
ms.custom: sap:connecting-to-a-session-or-desktop, csstroubleshoot
---
# Local computer behaves as if the Windows logo key is pressed after you switch from a Remote Desktop session

This article provides a workaround for an issue where your local computer behaves as if you are always pressing and holding the Windows logo key after you start a Remote Desktop Protocol (RDP) session to a remote computer.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows 10 - all editions, Windows 7 Service Pack 1  
_Original KB number:_ &nbsp; 4467266

## Symptoms

After you start a RDP session to a remote computer, your local computer behaves as if you are always pressing and holding the Windows logo key. For example, when you press the R key, the **Run** box opens. When you press the E key, File Explorer starts.

## Cause

This issue occurs if you use particular settings for your Remote Desktop connection and you take the following steps:

1. Before you connect to the remote computer, open the **Local Resources** tab of the **Remote Desktop Connection** dialog box, and set **Apply Windows key combinations** to either **On the remote computer** or **Only when using the full screen**.

    :::image type="content" source="media/local-computer-behaves-as-if-windows-logo-key-pressed/set-apply-windows-key-combinations.png" alt-text="Screenshot of the Apply Windows key combinations option on the Local Resources tab of the Remote Desktop connection dialog box." border="false":::

2. To start the Remote Desktop session, select **Connect**.
3. If you selected **Only when using the full screen** in step 1, expand the Remote Desktop session window to full screen. If you selected **On the remote computer**, go to step 4.
4. Do the following key sequence:
    1. Press and hold the L key.
    2. Press and hold the Windows logo key.
    3. Release the L key.
    4. Release the Windows logo key.
5. Disconnect the Remote Desktop session, or switch from the Remote Desktop session window to a window on the local computer.

## Workaround

To work around this issue, press and release the Windows logo key again after you return to the local computer.
