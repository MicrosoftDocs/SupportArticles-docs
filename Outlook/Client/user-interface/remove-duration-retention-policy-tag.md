---
title: How to remove duration from retention policy tags in Outlook
description: Outlook introduced a change that enables administrators and users to remove the duration information from the retention policy tag view by setting a registry key.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Exchange Mailbox Accounts\Retention policies
  - Outlook for Windows
  - CI 114394
  - CSSTroubleshoot
ms.reviewer: sfellman
appliesto: 
  - Outlook for Microsoft 365
search.appverid: 
  - MET150
ms.date: 03/19/2025
---

# How to remove duration information from retention policy tags in Outlook

By default, Microsoft Outlook appends duration information when displaying retention policy tag names. For example, the **1 Month Delete** tag name displays as **1 Month Delete (30 days)**. 

However, in build **16.0.12318.10000** and later builds of Outlook for Microsoft 365, you can remove the appended duration information by setting the registry key that's shown in the following table.

| Type|Value |
|---------|---------|
|Registry subkey|HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\16.0\Outlook\Preferences|
|Value name|HideRetentionPolicyDuration|
|Value type|REG_DWORD|
|Value data|0x1|

> [!NOTE]
> - Value `0x0` (default): display tag duration information
> - Value `0x1`: hide tag duration information
