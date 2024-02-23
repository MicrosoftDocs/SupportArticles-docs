---
title: How to remove duration from retention policy tags in Outlook
description: Outlook introduced a change that enables administrators and users to remove the duration information from the retention policy tag view by setting a registry key.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CI 114394
  - CSSTroubleshoot
ms.reviewer: sfellman
appliesto: 
  - Outlook for Microsoft 365
search.appverid: 
  - MET150
ms.date: 10/30/2023
---

# How to remove duration from retention policy tags in Outlook

## Summary

By default, Microsoft Outlook displays the following information in retention policy tags:

- Tag name
- Tag duration

**Build 16.0.12318.10000** of Outlook for Microsoft 365 introduced a change that enables administrators and users to remove the duration information from the tag view. For example, the tag **1 Month Delete (30 days)** becomes **1 Month Delete**.

To remove the duration information, set the following registry key.

| Type|Value |
|---------|---------|
|Registry subkey|HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\16.0\Outlook\Preferences|
|Value name|HideRetentionPolicyDuration|
|Value type|REG_DWORD|
|Value data|0x1|

> [!NOTE]
> - A value of **0x0** uses the Outlook default setting (duration information is displayed).
> - A value of **0x1** removes the duration information and displays the policy name only.
> - This change won't be backported to Office 2016 or earlier versions.
