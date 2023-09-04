---
title: No logon servers are available
description: Occurs when cloning failed, and the server starts in Directory Services Repair Mode (DSRM). There's no visual indication that the domain controller has started in DSRM.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika, nedpyle
ms.custom: sap:active-directory-backup-restore-or-disaster-recovery, csstroubleshoot
ms.technology: windows-server-active-directory
---
# No logon servers are available error after cloning domain controller

This article provides a solution to an error that occurs after you clone a new VDC, and try to sign in interactively.

_Applies to:_ &nbsp; Windows Server 2016, Windows Server 2019  
_Original KB number:_ &nbsp; 2742908

## Symptoms

You use the Virtualized Domain Controller (VDC) cloning feature introduced in Windows Server 2012. After you clone a new VDC, you try to sign in interactively. However, you receive the following error:
> There are currently no logon servers are available to service the logon request

## Cause

The cloning process failed, and the server has started in Directory Services Repair Mode (DSRM). There's no visual indication that the domain controller has started in DSRM on the Ctrl+Alt+Delete sign-in page of Windows Server.

## Resolution

1. Select the Left Arrow key, or press the Esc key.
2. Select **Other User**.
3. Type the user name as follows: .\administrator
4. Provide the DSRM user password that is currently set on the source domain controller and that was used to clone this computer. This password was specified during the original promotion. Notice that this password might have been changed later by using NTDSUTIL.EXE.
5. When you sign in, the server will display **SAFE MODE** in all four corners of the screen. Resolve the issues that prevented cloning, remove the DSRM boot flag, and then try to clone the domain controller again

## More information

This visual behavior and the error aren't specific to cloning. This behavior and error are specific only to DSRM. DSRM is intentionally invoked as part of the cloning process to safeguard the network and domain from duplicated domain controllers.

Directory Services Repair Mode was called Directory Services Restore Mode in previous Windows operating systems.

For more information about how to configure and troubleshoot VDC together with details and step-by-step guidance, see [Virtualized Domain Controller Technical Reference (Level 300)](/windows-server/identity/ad-ds/deploy/virtual-dc/virtualized-domain-controller-technical-reference--level-300-).
