---
title: Caps Lock status change isn't synced to client
description: The Caps Lock key status change that is triggered by an application in a remote desktop session will not be synced back to the client computer.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:redirection-not-printer, csstroubleshoot
ms.subservice: rds
---
# Caps Lock key unexpectedly inverts characters in a remote desktop session to a Windows Server 2012-based computer

This article provides a solution to an issue where the Caps Lock key status change triggered by an application in a remote computer isn't synchronized back to the client computer.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3120433

## Symptoms

Assume that you connect to a remote computer in a remote desktop session. If an application, such as winword.exe or osk.exe, changes the Caps Lock key status, this change will not be synchronized back to the client computer.

For example, in a remote desktop session, when you open Microsoft Word, type *h*, turn on Caps Lock by pressing the keyboard, and then type *ELLO*, the word is *hELLO*. Then, you press the Enter key. In this situation, the *hELLO* in Word will be corrected to *Hello* automatically, and Caps Lock is turned off in the remote desktop session. However, on the client's physical keyboard, the Caps Lock light is still on, and it is still in Caps Lock On status. It is not synced with the remote desktop session Caps Lock key status.

> [!NOTE]
> The Word feature that triggers this issue is named **correct accidental usage of cAPs LOCK key**in **AutoCorrect** options.

In a remote desktop session to a Windows Server 2008 R2-based computer, if we do the same steps, the Caps Lock key on the client's physical keyboard also turns to off status, which is synced with the remote desktop session.

## Cause

This issue occurs because Windows Server 2012 and Windows Server 2012 R2 use the Remote Desktop Keyboard Device to handle the keyboard inputs in remote desktop sessions.

## Resolution

To make the client and the remote desktop session Caps Lock key sync again, you need to minimize the remote desktop session window or click the mouse outside the remote desktop session window, and then click it again.

For Office applications, you can disable the **correct accidental usage of cAPs LOCK key** in **AutoCorrect** options to fix the issue. For example, follow these steps for Word 2016.

1. Start Word 2016, select **FILE**, and then select **Options**.
2. Select **Proofing**.
3. Select the **AutoCorrect Options** button.
4. Clear the **Correct accidental usage of cAPs LOCK key** check box.
5. Select **OK**.
