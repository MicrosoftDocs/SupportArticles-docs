---
title: Can't enter UEFI firmware setup
description: Provides a solution to an issue where you can't enter UEFI firmware setup when in native UEFI mode.
ms.date: 04/28/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, match, jaysenb
ms.custom: sap:setup, csstroubleshoot
---
# Can't enter UEFI firmware setup when in native UEFI mode in Windows 7 and Windows 8

This article provides a solution to an issue where you can't enter UEFI firmware setup when in native UEFI mode.

_Applies to:_ &nbsp; Windows 10 - all editions  
_Original KB number:_ &nbsp; 2804597

## Symptoms

Consider the following scenario:

- You enter UEFI F/W setup by pressing F1 key during POST.
- Navigate to **Startup** page and change the **UEFI/Legacy Boot** setting from **Both** to **UEFI Only**.
- Exit UEFI F/W setup using F10 key to save your changes.
- You then boot the system from the Windows 7/Windows 8 installation DVD and do a normal installation.

After Windows 7/Windows 8 setup completes, you're no longer able to enter the UEFI F/W setup option when using the F1 key during POST.

> [!NOTE]
> This only impacts certain OEM systems that shipped with Windows 7/Windows 8 preinstalled in BIOS Legacy Boot mode.

## Cause

During Windows 7/Windows 8 setup, certain BCDEdit commands are executed to configure the new installation. These commands may delete information in the BCD store that is necessary for the UEFI boot manager to load the UEFI firmware menu. Also, Vista, Windows Server 2008, Windows 7, Windows 8, or Windows Server 2008 R2 and Windows Server 2012 may modify the BCD store in a way that prevents the UEFI firmware menu from loading.

## Resolution

Contact your hardware vendor to see if there's a firmware update available to resolve this issue.

## More information

LOAD_OPTION_CATEGORY_APP bit of Attributes in Boot#### is deleted by `bcdedit.exe /export`, then `bcdedit.exe /import /clean` process. It may also be cleared by installing Windows Vista or later. It can cause the UEFI Boot Manager failure to enter UEFI firmware menu.

## Data collection

If you need assistance from Microsoft support, we recommend you collect the information by following the steps mentioned in [Gather information by using TSS for deployment-related issues](../windows-troubleshooters/gather-information-using-tss-deployment.md).
