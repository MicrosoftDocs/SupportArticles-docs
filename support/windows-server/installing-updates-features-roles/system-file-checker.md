---
title: Description of System File Checker (Sfc.exe)
description: Describes System File Checker (Sfc.exe), which is a command-line utility used with the Windows File Protection (WFP) feature.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, LARRYGA
ms.custom: sap:Installing Windows Updates, Features, or Roles\Failure to install Windows Updates, csstroubleshoot
---
# Description of System File Checker (Sfc.exe)

This article describes System File Checker (Sfc.exe), which is a command-line utility used with the Windows File Protection (WFP) feature.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 310747

## Summary

System File Checker gives an administrator the ability to scan all protected files to verify their versions. If System File Checker discovers that a protected file has been overwritten, it retrieves the correct version of the file from the cache folder (`%Systemroot%\System32\Dllcache`) or the Windows installation source files, and then replaces the incorrect file. System File Checker also checks and repopulates the cache folder. You must be logged on as an administrator or as a member of the Administrators group to run System File Checker. If the cache folder becomes damaged or unusable, you can use the `sfc /scannow`, the `sfc /scanonce`, or the `sfc /scanboot` commands to repair its contents.

## System File Checker tool syntax

Sfc [/Scannow] [/Scanonce] [/Scanboot] [/Revert] [/Purgecache] [/Cachesize=x]

- `/Scannow`: Scans all protected system files immediately and replaces incorrect versions with correct Microsoft versions. This command may require access to the Windows installation source files.

- `/Scanonce`: Scans all protected system files one time when you restart your computer. This command may require access to the Windows installation source files when you restart the computer. The **SfcScan** DWORD value is set to **2** in the following registry key when you run this command:

    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon`

- `/Scanboot`: Scans all protected system files every time you start your computer. This command may require access to the Windows installation source files every time you start your computer. The **SfcScan** DWORD value is set to **1** in the following registry key when you run this command:

    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon`

- `/Revert`: Returns scan to the default setting (do not scan protected files when you start the computer). The default cache size is not reset when you run this command. This command is equivalent to the `/Enable` switch in Windows 2000.

- `/Purgecache`: Purges the file cache and scans all protected system files immediately. This command may require access to the Windows installation source files.

- `/Cachesize=x`: Sets the file cache size to **x** megabytes (MB). The default size of the cache is 50 MB. This command requires you to restart the computer, and then run the `/purgecache` command to adjust the size of the on-disk cache. This command sets the **SfcQuota** DWORD value to **x** in the following registry key:

    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon`

For more information about the Windows File Protection feature, see [Description of the Windows File Protection feature](https://support.microsoft.com/help/222193).

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../../windows-client/windows-troubleshooters/gather-information-using-tss-deployment.md).
