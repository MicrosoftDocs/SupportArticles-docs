---
title: How to enable diagnostic logging for the Windows Security app
description: Describes how to enable diagnostic logging for Windows Security
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:Network Connectivity and File Sharing\Windows Firewall with Advanced Security (WFAS), csstroubleshoot
---
# How to enable diagnostic logging for the Windows Security app

This article describes how to enable diagnostic logging for the Windows Security app.

_Applies to:_ &nbsp; Windows Server 2016, Windows 10, version 1809  
_Original KB number:_ &nbsp; 3155606

## Summary

This article describes how to enable diagnostic logging for the Windows Security app in Windows 10.

## More information

> [!IMPORTANT]
>Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur. 

To enable diagnostic logging for the Windows Security app, save the following content as a *.reg file, and then import the key:
```
Windows Registry Editor Version 5.00
[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WscLogger]
"GUID"="{FFFAC41B-9B97-4DCA-98CE-611471DF0F85}"
"FileName"="%SystemRoot%\\System32\\LogFiles\\WMI\\WscTrace.etl"
"ClockType"=dword:00000002
"Start"=dword:00000001
"Status"=dword:00000000
"MaxFileSize"=dword:00000000
"FlushTimer"=dword:00000001
"LogFileMode"=dword:10000004

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WscLogger\{1B0AC240-CBB8-4d55-8539-9230A44081A5}]
"Enabled"=dword:00000001
"EnableFlags"=dword:0000ffff
"EnableLevel"=dword:0000000f
"MatchAnyKeyword"=hex(b):ff,ff,ff,ff,00,00,00,00
```

For information about how to import registry data, see [Import some or all of the registry](https://technet.microsoft.com/library/cc778054%28v=ws.10%29.aspx).

The resulting log files are designed to be consumed by internal Microsoft teams, and they cannot be converted for use by using public tools. 

After you create these keys, you have to restart the computer, and then data capture will start immediately. The data capture will occur across reboots and operating system upgrades.

To stop logging, change the Enabled value under the following key:

**HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\WMI\Autologger\WscLogger\{1B0AC240-CBB8-4d55-8539-9230A44081A5}**
