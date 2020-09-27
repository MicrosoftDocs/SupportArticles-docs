---
title: Unexpected one-minute delay of Outlook if UE-V is enabled
description: Resolves an issue in which you encounter an unexpected one-minute delay for Outlook to start if UE-V is enabled in Windows 10, version 1809 or a later version of Windows.
ms.date: 09/21/2020
author: Deland-Han
ms.author: delhan
manager: dscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: narafa, winciccore, kaushika
ms.prod-support-area-path: Certificates and public key infrastructure (PKI)
ms.technology: WindowsSecurity
---
# Unexpected one-minute startup of Outlook if UE-V is enabled

This article helps resolve an issue where you experience an unexpected one-minute delay for Outlook to start if UE-V is enabled in Windows 10, version 1809 or a later version of Windows.

_Original product version:_ &nbsp; Windows 10 – all editions  
_Original KB number:_ &nbsp; 4569308

## Symptoms

Consider the following scenario:

- You're using Outlook 2019 or Outlook 2016 on a computer that is running Windows 10, version 1809 or a later version of Windows.
- You install a cumulative update for Windows 10 that is released after March 17, 2020.
- You deploy User Experience Virtualization (UE-V) that has the **Sync Method** set to **None**.
- You register the MicrosoftOutlook2016CAWinXX.xml UE-V template. For example, you register MicrosoftOutlook2016CAWin32.xml.

In this scenario, Outlook takes one minute to start and display its splash screen.

## Cause

This issue occurs when the **UE-V Sync** method is set to **None**. This setting causes Windows to ignore the synchronize timeout (by default, two seconds). Therefore, UE-V times out after one minute.

## Resolution

To resolve this issue, use one of the following methods:

### Method 1

Use the default Sync method **SyncProvider.**  

The Sync method **None** is specific to workstations that have a permanent network connection to the **SettingsStoragePath**.

### Method 2

If you can't change to other **Sync** methods, you can change the behavior of UE-V by configuring the items in the corresponding template by following these steps:

1. Go to the TemplateCatalog path that is defined in the UEV Configuration settings. If you use the default location, the path should be  as follows:

    %ProgramData%\Microsoft\UEV\InboxTemplates\MicrosoftOutlook2016CAWinXX.xml 
2. Update the following lines in the template, and then save and re-apply the new template:

    \<Version> **3** \</Version>  
    \<Asynchronous> **true** \</Asynchronous>
 
**Important**  For method 2, the template editing is applicable to only Office 2019 and Office 2016. It doesn't apply to earlier versions of Office. Changing the template for a version of Office other than Office 2019 or Office 2016 can cause crashes and undefined behavior in the program.

## More information

For more information, see the following articles: 

- [Understanding the limitations of roaming Outlook signatures in Microsoft UE-V](https://support.microsoft.com/help/2930271) 
- [Unregister and register UE-V template](/powershell/module/uev/?view=win10-ps) 
- [Sync Methods for UE-V 2.x](/microsoft-desktop-optimization-pack/uev-v2/sync-methods-for-ue-v-2x-both-uevv2) 
