---
title: Variable %username% is unavailable
description: Resolves an issue in which username is unavailable in Windows that has OneDrive for Business installed.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, winciccore, Philip.Demaree
ms.custom: sap:uev-2.1, csstroubleshoot
---
# %username% is unavailable in Windows that has OneDrive for Business installed

This article provides a solution to an issue where %username% is unavailable in Windows that has OneDrive for Business installed.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 4551435

## Symptoms

In a Windows installation that has OneDrive for Business installed, the **%username%** variable is intermittently unavailable. This causes applications that rely on this variable, such as User Experience Virtualization (UE-V), to work incorrectly.

## Cause

In some cases, OneDrive for Business restarts the Windows Explorer process shortly after a user logs on. When this occurs, the **%username%** variable is not inherited by the new Explorer process.
If you deployed UE-V by using the **%username%** variable as part of the "Settings Storage" setting, the literal string will be used. So all user accounts write to the same folder. This can cause high CPU activity on the server that hosts the network share.

## Resolution

> [!WARNING]
> Serious problems might occur if you modify the registry incorrectly by using Registry Editor or by using another method. These problems might require that you reinstall the operating system. Microsoft cannot guarantee that these problems can be solved. Modify the registry at your own risk.

To fix this issue, enable one or both of the following registry keys to prevent OneDrive from restarting Explorer.

### Per user OneDrive installation

`HKEY_CURRENT_USER\SOFTWARE\Microsoft\OneDrive`  
"HasSystrayIconBeenPromoted"=dword:00000001

### Per computer OneDrive installation

- For 32-bit version of OneDrive:  
  `HKEY_CURRENT_USER\SOFTWARE\Microsoft\OneDrive`  
  "HasPerMachineSystrayIconBeenPromoted"=dword:00000001

- For 64-bit version of OneDrive:  
  `HKEY_CURRENT_USER\SOFTWARE\Microsoft\OneDrive`  
  "HasAMD64PerMachineSystrayIconBeenPromoted"=dword:00000001
