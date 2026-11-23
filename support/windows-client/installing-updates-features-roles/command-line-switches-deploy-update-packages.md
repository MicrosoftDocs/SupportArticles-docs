---
title: Command-line switches for Windows Update Standalone Installer
description: Describes the consistent set of command-line switches that Microsoft is adopting for deploying packages that contain software updates.
ms.date: 10/26/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: eriprice, kaushika, v-appelgatet
ms.custom:
- sap:Windows Servicing, Updates and Features on Demand\Windows Update - Configuring and managing client settings
- pcy:WinComm Devices Deploy
ai-usage: ai-assisted
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Command-line switches for Windows Update Standalone Installer

_Original KB number:_ &nbsp; 824687

## Summary

You can use the Windows Update Standalone Installer (wusa.exe) to manually install or uninstall update packages from the command line on Windows Client or Windows Server systems. Update packages might include any of the update types that are described in [Description of the standard terminology that is used to describe Microsoft software updates](standard-terminology-software-updates.md).

This article lists the switches that you can use together with wusa.exe.

For more information about how to use wusa.exe, see [Description of the Windows Update Standalone Installer in Windows](https://support.microsoft.com/servicing/os/windows/2017/03/description-of-the-windows-update-standalone-installer-in-windows#bkmk_wusa_switches).

## More information

The following commands provide examples of the syntax of wusa.exe.

- `wusa <update> [/quiet] [/norestart | /warnrestart:<seconds> | /promptrestart | /forcerestart] [/log:<file name>]`
- `wusa /uninstall <update> [/quiet] [/norestart | /warnrestart:<seconds> | /promptrestart | /forcerestart] [/log:<file name>]`
- `wusa /uninstall /kb:<KB number> [/norestart | /warnrestart:<seconds> | /promptrestart | /forcerestart] [/log:<file name>]`

Wusa.exe supports the following switches:

> [!IMPORTANT]  
> Some switches might not be available in all versions of Windows. To see a list of switches that a particular computer supports, open a command prompt window, and then run `wusa.exe /?`.

- `/extract`: Wusa.exe extracts the update package contents to a destination folder.

- `/help`, `/h` or `/?`: Displays a dialog box that shows how to use wusa.exe, including a list of all its command-line switches and their behaviors.

- `/log:<file name>`: Turns on logging and designates a destination file for the log.

- `/quiet`: Run Wusa.exe in quiet mode without user interaction. The Microsoft Software License Terms don't appear. If the update requires that the computer restart, it restarts automatically without prompting the user.

  For example, if the Windows6.0-KB934307-x86.msu file is in the D:\934307 folder, type the following command at a command prompt to install the update package without user interaction:

  `wusa.exe d:\934307\Windows6.0-KB934307-x86.msu /quiet`

  You can use one of the following switches together with the `/quiet` switch:

  - `/norestart`: The computer doesn't restart after the update installs or uninstalls, even if the update requires a restart to take effect.
  - `/promptrestart`: If the update requires the computer to restart (after install or uninstall), wusa.exe prompts the user to restart the computer.
  - `/forcerestart:<seconds>`: After the update installs or uninstalls, wusa.exe forcefully closes applications and restarts the computer. The restart occurs even if the update doesn't require a restart for the changes to take effect.
  - `/warnrestart`: If the update requires the computer to restart (after install or uninstall), wusa.exe warns the user before it restarts the computer.

- `/uninstall <update>` or `/uninstall /kb:<KB number>`: Removes the specified update. You can specify the update by file name or (by using the `/kb` switch) by KB number.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
