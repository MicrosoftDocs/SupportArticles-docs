---
title: Presence icons do not show in Outlook
description: This article provides a resolution for the issue that the presence information or presence icons don't display in Microsoft Outlook.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: gregmans
appliesto:
- Outlook LTSC 2021
- Outlook 2019
- Outlook 2016
- Outlook for Microsoft 365
search.appverid: MET150
ms.date: 01/30/2024
---
# Presence icons don't appear in Outlook

## Symptoms

Presence information or presence icons don't appear in Microsoft Outlook.

## Cause

This problem can occur if any of the following registry values are configured on the computer running Outlook.

Key: `HKEY_CURRENT_USER\Software\Microsoft\Office\<x.0>\Common\IM`  
or Policy key: `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\<x.0>\Common\IM`  
DWORD: TurnOffPresenceIcon  
Value: 1 (turn off presence icons in email messages, but leave them on in the contact card), or 2 (turn off presence icons everywhere).

Key: `HKEY_CURRENT_USER\Software\Microsoft\Office\<x.0>\Common\IM`  
or Policy Key: `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\<x.0>\Common\IM`  
DWORD: TurnOffPresenceIntegration  
Value: 1 (turn off presence integration everywhere in Outlook).

Key: `HKEY_CURRENT_USER\Software\Microsoft\Office\<x.0>\Common\PersonaMenu`  
or Policy Key: `HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\<x.0>\Common\PersonaMenu`  
DWORD: Enabled  
Value: 0 (turn off presence icons in email messages, but leave them on in the contact card).

> [!NOTE]
> The \<x.0\> placeholder represents your version of Office (16.0 = Outlook 2016, Outlook 2019, Outlook LTSC 2021, or Outlook for Microsoft 365, 15.0 = Office 2013, 14.0 = Office 2010).

## Resolution

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

To resolve this problem, either remove the group policies controlling presence integration in Outlook, or change the non-policy registry values to the following.

Key: `HKEY_CURRENT_USER\Software\Microsoft\Office\<x.0>\Common\IM`

DWORD: TurnOffPresenceIcon  
Value: 0

DWORD: TurnOffPresenceIntegration  
Value: 0

Key: `HKEY_CURRENT_USER\Software\Microsoft\Office\<x.0>\Common\PersonaMenu`

DWORD: Enabled  
Value: 1

> [!NOTE]
> The *x.0* placeholder represents your version of Office (16.0 = Office 2016, Office 2019, Office LTSC 2021, or Microsoft 365, 15.0 = Office 2013, 14.0 = Office 2010).
