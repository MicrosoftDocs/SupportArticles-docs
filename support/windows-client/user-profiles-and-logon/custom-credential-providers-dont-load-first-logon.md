---
title: Custom credential providers don't load at first logon
description: Address an issue in which custom credential providers do not work when you first log on
ms.date: 09/14/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:user-logon-fails, csstroubleshoot
ms.subservice: user-profiles
---
# Custom credential providers don't load when you first log on

This article provides a workaround for an issue where custom credential providers do not work when you first log on.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 4073719

## Symptom

Consider the following scenario:

- You have a Windows 10-based computer that is not joined to a domain.
- Custom credential providers are installed on the computer.
- You log on to the computer for the first time after it starts.  

In this scenario, the custom credential providers are not called.

## Cause

This is by design. A Windows 10 update improves the **Use my sign in info to automatically finish setting up my device after an update** sign-in option. This feature is used for first logon. Therefore, custom credential providers do not take effects.

## Workaround

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

To work around this issue, disable automatic system logon of the last user by setting the following registry key:

- Location: `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System`  
- Value name: DisableAutomaticRestartSignOn
- Value type: dword
- Value data: 1
