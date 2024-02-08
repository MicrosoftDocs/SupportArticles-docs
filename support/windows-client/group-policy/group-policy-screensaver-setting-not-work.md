---
title: Group Policy Screensaver setting isn't working in Windows
description: Fixes an issue where the Screensaver doesn't start after a Group Policy is configured to enable it in Windows.
ms.date: 04/15/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:problems-applying-group-policy-objects-to-users-or-computers, csstroubleshoot
---
# Group Policy Screensaver setting isn't working in Windows

This article helps work around an issue where the Screensaver doesn't start after a Group Policy is configured to enable it in Windows.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2616727

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

- Configure the **Screen saver timeout** Group Policy under the following path to change the default ScreenSaver timeout:

    User Configuration\\Administrative Templates\\Control Panel\\Personalization\\

    

- Use Group Policy Preferences to configure a new default value for the following registry key in a Group Policy applying to users:

  - Registry subkey: `HKEY_CURRENT_USER\Control Panel\Desktop`
  - Type: Reg_SZ
  - Name: ScreenSaveTimeOut

    User Configuration > Preferences > Windows Settings > Registry

    New > Registry Item

  - Action: Create
  - Hive: `HKEY_CURRENT_USER`
  - Key Path: `Control Panel\Desktop`
  - Value Name: ScreenSaveTimeOut
  - Value Type: REG_SZ
  - Value Data: 600

    Using Item Level Targeting (Common Tab of setting) the appliance of this setting can be restricted to systems running Windows 7 or Windows Server 2008 R2.
