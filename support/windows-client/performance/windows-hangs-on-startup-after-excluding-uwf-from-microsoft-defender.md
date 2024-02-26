---
title: Windows startup hangs after you exclude UWF from Microsoft Defender
description: Discusses how to work around an issue in which Windows doesn't start after you exclude the UWF feature from Microsoft Defender.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: koaiiot, kaushika
ms.custom: sap:no-boot-not-bugchecks, csstroubleshoot
---
# Windows doesn't start after you exclude UWF from Microsoft Defender

This article discusses how to work around an issue in which Windows doesn't start after you exclude Unified Write Filter (UWF) from Microsoft Defender.

_Applies to:_ &nbsp; Windows 10 Enterprise, Windows 10 IoT Enterprise or Windows 11 Enterprise

## Issue

Consider the following scenario:

- You enable the UWF feature on a Windows 11 Enterprise-based, Windows 10 Enterprise-based, or Windows 10 IoT Enterprise-based computer.
- You configure a UWF registry exclusion for Windows Defender. Specifically, the following registry key is excluded from the write filter:  
  `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\WdFilter`

In this scenario, the computer stops responding during Windows startup.

> [!NOTE]
>
> - If you disable the UWF feature by using the `uwfmgr.exe filter disable` command, the issue doesn't occur.
> - The computer might start up after several retries.

This behavior is by design. To work around this issue, use an alternative menthod to exclude UWF.

## Supported method to exclude UWF

To work around this issue, you can use the `Registry Commit` option for Uwfmgr.exe to exclude UWF. This option can commit changes to specify a value.

The following command can commit changes of a specified registry value:

```console
uwfmgr.exe registry commit "HKLM\SYSTEM\CurrentControlSet\Services\WdFilter" Start
```

> [!NOTE]
> Because the command can specify only a single registry value, you must specify the whole registry value for the registry keys where you want to commit changes.

For example, you find registry values that resemble the values in the following screenshot.

:::image type="content" source="media/windows-hangs-on-startup-after-excluding-uwf-from-microsoft-defender/registry-editor-wdfilter-values.png" alt-text="Screenshot of Registry Editor." border="true":::

To commit all the changes that are made under the `WDFilter` registry subkeys, you have to run the `Registry Commit` option, as follows:

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
> The Registry Commit option is a one-shot operation. It doesn't continue to bypass the write filter by running a single command. To make value changes commit whenever your computer shuts down, you must add this command set to the shutdown script.

For more inform about the shutdown script, see [Working with startup, shutdown, logon, and logoff scripts using the Local Group Policy Editor](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn789190(v=ws.11)#how-to-assign-computer-shutdown-scripts).

## More information

To check whether WDFilter registry keys are excluded from the UWF registry filter, open a Command Prompt window as an administrator, and then run `uwfmgr.exe get-config` at the prompt.
