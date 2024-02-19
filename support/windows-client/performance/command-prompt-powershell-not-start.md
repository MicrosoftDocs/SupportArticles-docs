---
title: Command prompt and PowerShell don't start
description: Command prompt and PowerShell don't start after in-place upgrade of Windows 10 S to Professional, Education, or Enterprise edition.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: Fix, csstroubleshoot
---
# Command prompt and PowerShell don't open after in-place upgrade of Windows 10 S

This article provides a solution to an issue where Command prompt and PowerShell don't open after in-place upgrade of Windows 10 S.

_Applies to:_ &nbsp; Windows 10, version 1809  
_Original KB number:_ &nbsp; 4019568

## Symptom

Windows 10 S can be upgraded to Windows 10 Pro, Windows 10 Enterprise, or Windows 10 Education by using various methods. For example:  

- Manually entering a product key  
- Using Microsoft Store for Business  
- Purchasing a license from the Microsoft Store  
- Using installation media (in-place upgrade)  

For more information, see Windows 10 edition upgrade [Windows 10 edition upgrade](/windows/deployment/upgrade/windows-10-edition-upgrades).  
After you do an in-place upgrade of Windows 10 S by using Setup.exe from Windows 10 installation media, when you open a command prompt, PowerShell, or any Win32 application, you may receive the following error message:  
Your organization used Device Guard to block this app
C:\Windows\System32\cmd.exe

Contact your support person for more info.  

:::image type="content" source="media/command-prompt-powershell-not-start/organization-used-device-guard-block-app-error.png" alt-text="Screenshot of the Your organization used Device Guard to block this app error." border="false":::

## Cause

This issue occurs because the policy that allows Windows 10 S to control Win32 applications has not cleared.  

## Resolution

To resolve this issue, restart the computer. You may have to restart two or three times to clear this policy.  

## Reference

For more information about what is blocked in Windows 10 S, see [Planning a Windows 10 in S mode deployment](/windows-hardware/manufacture/desktop/windows-10-s-planning#what-is-blocked-in-windows-10-s).

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for User Experience issues](../windows-troubleshooters/gather-information-using-tss-user-experience.md#powershell).
