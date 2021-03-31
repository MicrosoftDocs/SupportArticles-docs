---
title: HotStart buttons don't work
description: Provides a solution to an issue where HotStart buttons doesn't work when Autoplay is disabled.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.prod-support-area-path: Desktop Shell
ms.technology: windows-client-shell-experience
---
# Disabling Autoplay through Group Policy or the registry will cause HotStart buttons to not function

This article provides a solution to an issue where HotStart buttons doesn't work when Autoplay is disabled.

_Original product version:_ &nbsp;Windows 7 Service Pack 1  
_Original KB number:_ &nbsp;2328787

## Symptoms

Consider the following scenario:

- You have a Windows 7 system running on a laptop with Hotstart buttons

- There is a policy set in Group Policy to disable Autoplay on all drives

In this scenario, the HotStart buttons do not function

## Cause

When changing the Group Policy setting to disable Autoplay, the Autoplay registry value gets set to 0xFF (disable Autoplay on all drives). When the registry value is set to 0xFF, HotStart does not function.

## Resolution

You can change the settings by using Group Policy settings.

There are three options: "Not Configured", "Enabled", and "Disabled" in the "Turn off Autoplay".

When selecting "Enabled", you need to select "CD-ROM and removable media drives" to allow HotStart to function.

By selecting this option, the Autoplay registry value is set to "0xB5", and fixed and RAM drives are the only ones still enabled. Any other drives: unknown types, removable drives, network drives, and CD-ROM drives are disabled.

How to open Group Policy settings as follows:

1. Click Start, type Gpedit.msc in the Start Search box, and then press ENTER.

    If you are prompted for an administrator password or for confirmation, type the password, or click Allow.

2. Under Computer Configuration, expand Administrative Templates, expand Windows Components, and then click Autoplay Policies.

3. In the Details pane, double-click Turn off Autoplay.

    If you are experiencing this on a system that has been joined to a domain, you will need to contact the domain administrator for assistance. Your system settings synchronize to the domain server.  

    For operating systems that do not include Gpedit.msc and for an optional resolution, you can directly check and change the NoDriveTypeAutoRun entry value in the following registry key other than 0xFF.

    `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Polic []() es\Explorer\
    HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\policies\Explorer\`
