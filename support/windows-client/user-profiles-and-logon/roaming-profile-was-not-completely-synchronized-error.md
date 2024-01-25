---
title: Error (Roaming profile was not completely synchronized) and logon, logoff delays in Windows 10, version 1803
description: Fixes a problem in which you receive errors or experience logon/logoff delays when you use roaming user profiles.
ms.date: 12/07/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:user-profiles, csstroubleshoot
ms.subservice: user-profiles
---
# Error (Roaming profile was not completely synchronized) and logon, logoff delays in Windows 10, version 1803

This article provides help to fix errors, and logon/logoff delays that occur when you use roaming user profiles in Windows 10, version 1803.

_Applies to:_ &nbsp; Windows 10, version 1803  
_Original KB number:_ &nbsp; 4340390

## Symptoms

On a computer that's running Windows 10, version 1803, you experience logon or logoff delays when you use roaming user profiles. You also receive the following error messages:

> Your roaming profile was not completely synchronized. See the event log for details or contact administrator"

Additionally, the system may log the following entries in the event log.

- Event 1509 (source: User Profile General)

    ```output
    Windows cannot copy file \\?\C:\Users\%username%\AppData\Local\Microsoft\Windows\<Path to a file> to location \\?\UNC Path\%username%.V6\AppData\Local\Microsoft\Windows\<path to a file>. This error may be caused by network problems or insufficient security rights.  
    DETAIL - Access is denied.
    ```

- Event 509 (source: User Profile General)

    ```output
    Windows cannot copy file \\?\C:\Users\UserName\AppData\Local\Microsoft\Windows\UPPS\UPPS.bin to location \\?\UNC Path\UserName.V6\AppData\Local\Microsoft\Windows\UPPS\UPPS.bin. This error may be caused by network problems or insufficient security rights.  
    DETAIL - Access is denied.

    Windows cannot copy file \\?\C:\Users\UserName\AppData\Local\Microsoft\WindowsApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\MicrosoftEdge.exe to location \\?\UNC\WS2016DC1\rup\UserName.V6\AppData\Local\Microsoft\WindowsApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\MicrosoftEdge.exe. This error may be caused by network problems or insufficient security rights.  
    DETAIL - The file cannot be accessed by the system.

    Windows cannot copy file \\?\C:\Users\UserName\AppData\Local\Microsoft\WindowsApps\MicrosoftEdge.exe to location \\?\UNC\WS2016DC1\rup\UserName.V6\AppData\Local\Microsoft\WindowsApps\MicrosoftEdge.exe. This error may be caused by network problems or insufficient security rights.  
    DETAIL - The file cannot be accessed by the system.
    ```

- Event 1504 (source: User Profile General)

     ```output
     Windows cannot update your roaming profile completely. Check previous events for more details.
     ```

## Cause

This problem occurs because of a change that was made in Windows 10, version 1803. This change inadvertently caused folders that are usually excluded from roaming to be synchronized by roaming user profiles when you log on or log off.

## Resolution

This problem is fixed in the following update for Windows 10, version 1803:

[July 24, 2018-KB4340917 (OS Build 17134.191)](https://support.microsoft.com/help/4340917)

## Workaround

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To work around this problem, you can copy the ExcludeProfileDirs registry key from a Windows 10, version 1709-based computer to the version 1803-based computers that are experiencing the problem. Full path to the registry key:

`HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon\ExcludeProfileDirs`

For information about how to export and import registry keys by using the reg.exe tool, see the following Windows IT Pro Center article:

[reg export](/windows-server/administration/windows-commands/reg-export)
