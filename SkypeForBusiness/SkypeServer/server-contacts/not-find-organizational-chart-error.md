---
title: Can't view contact organization information
description: Provides a workaround for an issue in which contact organization information cannot be found and you receive a We didn't find an organizational chart error message.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: kenguil, bwilson
appliesto: 
  - SharePoint Server 2016
search.appverid: MET150
ms.date: 03/31/2022
---
# Didn't find an organizational chart error when you view a contact card in Skype for Business 2016

_Original KB number:_ &nbsp; 4501070

## Symptoms

You can no longer find contact organization information in Microsoft Skype for Business 2016. When you try to view the information, you receive the following error message:

> We didn't find an organizational chart.

Additionally, MAPI is displayed as disconnected, or you see a "Your Exchange Server is currently unavailable" status in **MAPI Information** in Skype for Business [Configuration Information](../server-configuration/how-to-use-configuration-information.md).  

## Cause

This issue occurs because the Active Directory Authentication Library (ADAL) isn't implemented in Microsoft Office correctly.

## Workaround

Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

There are at least two variants of this issue. A workaround for the first variant is to temporarily set the following registry keys' DWORD value to **1**:

Subkey: `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\16.0\Common\Identity path`  
Value: `DisableADALatopWAMOverride`  
DWORD data: **1**  

Subkey: `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\16.0\Common\Identity path`  
Value: `DisableAADWAM`  
DWORD data: **1**  

These registry keys should be removed when the issue is confirmed to be fixed in the Office clients.  

There currently is no workaround to the second variant.

## More information

This issue will be resolved in version 16.0.11610.10000 and later versions of Skype for Business 2016 client.
