---
title: Microsoft 365 can't open files from the most recently used document list (MRU)
description: Describe an issue where Microsoft 365 can't open files from the most recently used document list (MRU). Provides a solution.
author: helenclu
ms.author: luche
ms.reviewer: warrenr
manager: dcscontentpm
localization_priority: Normal
ms.custom: 
  - sap:office-experts
  - CSSTroubleshoot
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
appliesto: 
  - Microsoft 365
ms.date: 03/31/2022
---

# Microsoft 365 can't open files from the most recently used document list (MRU)

This article was written by [Warren Rath](https://social.technet.microsoft.com/profile/Warren_R_Msft), Support Escalation Engineer.

## Symptoms

Assume that you have Microsoft 365 client applications and the **RoamingSettingsDisabled** policy is enabled. When you try to open a document from SharePoint or OneDrive through the Office **Most Recently Used** document list, you receive the following error message:

**Sorry, something went wrong.**

## Cause

Microsoft 365 doesn't support Roaming Settings for MRU:

- HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\16.0\Common\Roaming\RoamingSettingsDisabled
- HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common\Roaming\RoamingSettingsDisabled

## Workaround

To fix this issue, delete the **RoamingSettingsDisabled** registry key or set the value to **0**.

## More information

If you need to reduce the traffic between Office applications and the Internet, set the following registry key:

- **Location**: HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common\Internet or HKEY_CURRENT_USER\Software\Policies\Microsoft\Office\16.0\Common\Internet
- **Name**: UseOnlineContent
- **Type**: DWORD
- **Value**: 0 (Through this value, Office applications are disallowed to connect to the Internet, and they can't access online services or download the latest online content.)

> [!NOTE]
> When the **UseOnlineContent** registry key is set to **0**, you may need set the value of the **EnableAuthInOfflineMode** registry key to **1** in the **HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\16.0\Common\Identity** location to allow Office applications to activate.
