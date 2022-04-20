---
title: Windows startup hangs after you exclude UWF from Microsoft Defender
description: Introduces how to work around an issue in which Windows startup hangs after you exclude UWF from Microsoft Defender.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-client
localization_priority: medium
ms.reviewer: koaiiot
ms.technology: windows-client-performance
ms.custom: sap:no-boot-not-bugchecks, csstroubleshoot
---
# Windows may hang during startup after you exclude UWF from Microsoft Defender

This article introduce how to work around the issue in which Windows startup hangs after you exclude Unified Write Filter (UWF) from Microsoft Defender.

_Applies to:_ &nbsp; Windows 10 Enterprise, Windows 10 IoT Enterprise or Windows 11 Enterprise

## Issue symptoms

Consider the following scenario:

- You enable the UWF feature in Windows 10 Enterprise, Windows 10 IoT Enterprise or Windows 11 Enterprise.
- You configure UWF registry exclusion for Windows Defender. Especially, the following registry key is excluded from write filter:

  `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdFilter`

In this scenario, the computer hangs during Windows startup.

> [!NOTE]
> If you disable the UWF feature by using the `uwfmgr.exe filter disable` command, the problem does not occur.

## Alternative way to exclude UWF

To work around this issue, you can use the **Registry Commit** option of uwfmgr.exe. The option can commit changes to specify a value.

The following command can commit changes of specified registry value.

```console
uwfmgr.exe registry commit "HKLM\SYSTEM\CurrentControlSet\Services\WdFilter" Start
```

> [!NOTE]
> Since the command can only specify single registry value, you will need to specify whole registry value under registry keys where you want commit changes.

:::image type="content" source="media/windows-hangs-on-startup-after-excluding-uwf-from-microsoft-defender/registry-editor-screenshot.png" alt-text="Screenshot of the registry editor." border="false":::

If you find registry values reassemble the following screenshot, and you want to commit all changes under WDFilter registry subkeys, you need to run Registry Commit option as follows:

```console
uwfmgr.exe registry commit "HKLM\SYSTEM\CurrentControlSet\Services\WdFilter" DependOnService
uwfmgr.exe registry commit "HKLM\SYSTEM\CurrentControlSet\Services\WdFilter" Description
uwfmgr.exe registry commit "HKLM\SYSTEM\CurrentControlSet\Services\WdFilter" DisplayName
uwfmgr.exe registry commit "HKLM\SYSTEM\CurrentControlSet\Services\WdFilter" ErrorControl
uwfmgr.exe registry commit "HKLM\SYSTEM\CurrentControlSet\Services\WdFilter" Group
uwfmgr.exe registry commit "HKLM\SYSTEM\CurrentControlSet\Services\WdFilter" ImagePath
uwfmgr.exe registry commit "HKLM\SYSTEM\CurrentControlSet\Services\WdFilter" Start
uwfmgr.exe registry commit "HKLM\SYSTEM\CurrentControlSet\Services\WdFilter" SupportedFeatures
uwfmgr.exe registry commit "HKLM\SYSTEM\CurrentControlSet\Services\WdFilter" Type
uwfmgr.exe registry commit "HKLM\SYSTEM\CurrentControlSet\Services\WdFilter\Instances" DefaultInstance
uwfmgr.exe registry commit "HKLM\SYSTEM\CurrentControlSet\Services\WdFilter\Instances\WdFilter Instance" Altitude
uwfmgr.exe registry commit "HKLM\SYSTEM\CurrentControlSet\Services\WdFilter\Instances\WdFilter Instance" Flags
uwfmgr.exe registry commit "HKLM\SYSTEM\CurrentControlSet\Services\WdFilter\Security" Security
```

> [!NOTE]
> The Registry Commit option is a one-shot operation. It does not continue to bypass write filter by executing single command. To make value changes commit whenever your machine is going to be shutting down, you will need to add the above command set to the shutdown script.

For more inform about shutdown script, see [Working with startup, shutdown, logon, and logoff scripts using the Local Group Policy Editor](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn789190(v=ws.11)#how-to-assign-computer-shutdown-scripts).

## Check whether WDFilter registry keys are excluded

To check whether WDFilter registry keys are excluded from UWF registry filter, run command prompt with as an administrator, and then run `uwfmgr.exe get-config`.
