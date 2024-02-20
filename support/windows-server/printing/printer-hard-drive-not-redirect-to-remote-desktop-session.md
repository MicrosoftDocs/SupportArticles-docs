---
title: Printer redirection and drive redirection don't work
description: Fixes the printer redirection failure issues and hard drive redirection failure issues because of incorrect registry settings.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:errors-and-troubleshooting-general-issues, csstroubleshoot
---
# Printer redirection and drive redirection don't work in a Terminal Server session

This article helps fixes the printer redirection failures and hard drive redirection failures because of incorrect registry settings.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2492632

## Symptoms

Consider the following scenario:

1. You install the Terminal Services or Remote Desktop Services role on a Windows Server computer.
2. You enable printer redirection and\or hard drive redirection on the computer.
3. You connect to the server by using the Remote Desktop Connection (mstsc.exe) utility from a client machine.

In this scenario, printers and hard drives on the client machine aren't redirected into the Terminal Server session or Remote desktop session.

## Cause

The issue is caused if the values of both registry entries below are set to **0**:

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\Wds\rdpwd\fEnablePrintRDR`

`HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\Wds\rdpwd\fEnableRDR`

## Resolution

Set these values to **1**.
