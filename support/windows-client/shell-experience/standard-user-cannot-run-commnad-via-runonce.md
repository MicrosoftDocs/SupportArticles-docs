---
title: Can't execute commands with RunOnce and RunOnceEx
description: Fixes an issue where standard users can't execute a command set via RunOnce or RunOnceEx.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika, klausu
ms.prod-support-area-path: Desktop Shell
ms.technology: windows-client-shell-experience
---
# Standard user: RunOnce and RunOnceEx are not being executed

This article provides help to fix an issue where standard users can't execute a command set via RunOnce or RunOnceEx.

_Original product version:_ &nbsp;Windows 10 - all editions  
_Original KB number:_ &nbsp;2021405

## Symptoms

A command set to execute via RunOnce or RunOnceEx may not execute as expected.
The registry keys affected are:  

- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce`
- `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnceEx`
- `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Runonce`
- `HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RunonceEx`

## Cause

This will occur if you log on with a Standard User Account.
This is by design.

## Resolution

To execute commands from those registry keys, you must log in with an Administrator account. This issue effects only users with a Standard User account. If the user has an Administrator or Split Token, the execution proceeds.
