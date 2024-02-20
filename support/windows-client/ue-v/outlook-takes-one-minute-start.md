---
title: Unexpected one-minute delay of Outlook if UE-V is enabled
description: Resolves an issue in which you encounter an unexpected one-minute delay for Outlook to start if UE-V is enabled in Windows 10, version 1809 or a later version of Windows.
ms.date: 12/26/2023
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: narafa, winciccore, kaushika
ms.custom: sap:uev-2.1, csstroubleshoot
---
# Unexpected one-minute startup of Outlook if UE-V is enabled

This article helps resolve an issue where you experience an unexpected one-minute delay for Outlook to start if UE-V is enabled in Windows 10, version 1809 or a later version of Windows.

_Applies to:_ &nbsp; Windows 10 – all editions  
_Original KB number:_ &nbsp; 4569308

## Symptoms

Consider the following scenario:

- You're using Outlook 2019 or Outlook 2016 on a computer that is running Windows 10, version 1809 or a later version of Windows.
- You install a cumulative update for Windows 10 that is released after March 17, 2020.
- You deploy User Experience Virtualization (UE-V) that has the **Sync Method** set to **None**.
- You register the MicrosoftOutlook2016CAWinXX.xml UE-V template. For example, you register MicrosoftOutlook2016CAWin32.xml.

In this scenario, Outlook takes one minute to start and display its splash screen.

## Cause

This issue occurs when the **UE-V Sync** method is set to **None**. This setting causes Windows to ignore the synchronize timeout (by default, two seconds). Therefore, UE-V times out after one minute.

## Resolution

To resolve this issue, use one of the following methods:

### Method 1

Use the default Sync method **SyncProvider.**  

The Sync method **None** is specific to workstations that have a permanent network connection to the **SettingsStoragePath**.

### Method 2

Download and replace the version 3 of the Outlook custom action UEV template from the download center [UE-V OutlookCA template update](https://www.microsoft.com/download/details.aspx?id=102259)

## More information

For more information, see the following articles:  

- [Unregister and register UE-V template](/powershell/module/uev/?view=win10-ps&preserve-view=true )  
- [Sync Methods for UE-V 2.x](/microsoft-desktop-optimization-pack/uev-v2/sync-methods-for-ue-v-2x-both-uevv2)  
