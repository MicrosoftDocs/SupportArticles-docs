---
title: Duplicate is displayed in the ERROR column for two or more objects
description: Fixes a problem that duplicate is displayed in the ERROR column when you run the IdFix DirSync Error Remediation Tool in your on-premises AD DS environment.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: v-chblod, willfid
search.appverid: 
  - MET150
appliesto: 
  - Cloud Services (Web roles/Worker roles)
  - Azure Active Directory
  - Microsoft Intune
  - Azure Backup
  - Microsoft 365
ms.date: 03/31/2022
---

# "Duplicate" is displayed in the ERROR column for two or more objects after you run the IdFix tool

## Problem

When you run the IdFix DirSync Error Remediation Tool in your on-premises Active Directory Domain Services (AD DS) environment, "duplicate" is displayed in the **ERROR** column for one or more objects.

This problem occurs if two or more objects have the same email address.

## Solution

To resolve this problem, specify a unique email address for the object. To do this, follow these steps:

1. In the **UPDATE** column for the object, type an email address that isn't already used.
2. In the **ACTION** column, click **EDIT**, and then click **Apply**.
3. Run IdFix again to look for more object errors.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Entra Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.
