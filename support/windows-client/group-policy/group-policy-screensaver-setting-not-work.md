---
title: Windows 7/Windows Server 2008 R2 Group Policy Screensaver setting isn't working
description: Fixes an issue where the Screensaver doesn't start after a Group Policy is configured to enable it in Windows 7 and Windows Server 2008 R2.
ms.date: 09/14/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Problems applying Group Policy objects to users or computers
ms.technology: GroupPolicy
---
# Windows 7/Windows Server 2008 R2 Group Policy Screensaver setting isn't working

This article helps work around an issue where the Screensaver doesn't start after a Group Policy is configured to enable it in Windows 7 and Windows Server 2008 R2.

_Original product version:_ &nbsp;Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp;2616727

## Symptoms

A Group Policy is configured to enable Screensaver:

User Configuration\\Administrative Templates\\Control Panel\\Personalization\\Enable screen saver

But there's no setting defining a ScreenSaverTimeout configured in Screen saver timeout.

The Screensaver won't start in such a configuration by default.

## Cause

The default ScreenSaver Timeout is configured in the registry at this location:

- Registry subkey: `HKEY_CURRENT_USER\Control Panel\Desktop`  
- Type: Reg_SZ
- Name: ScreenSaveTimeOut

Since Windows 7/Windows Server 2008 R2, this key doesn't exist by default.

Without configuring a default timeout via Group Policy, the system doesn't have a timeout and therefore doesn't start the screensaver.

## Workaround

There are two workarounds to solve this issue.

- Configure a Default ScreenSaver Timeout using Group Policy:

    User Configuration\\Administrative Templates\\Control Panel\\Personalization\\

    Screen saver timeout

- Use Group Policy Preferences to configure a new default value for the following registry key in a Group Policy applying to users:

  - Registry subkey: HKEY_CURRENT_USER\\Control Panel\\Desktop
  - Type: Reg_SZ
  - Name: ScreenSaveTimeOut

    User Configuration > Preferences > Windows Settings > Registry

    New > Registry Item

  - Action: Create
  - Hive: HKEY_CURRENT_USER
  - Key Path: Control Panel\\Desktop
  - Value Name: ScreenSaveTimeOut
  - Value Type: REG_SZ
  - Value Data: 600

    Using Item Level Targeting (Common Tab of setting) the appliance of this setting can be restricted to systems running Windows 7 or Windows Server 2008 R2.
