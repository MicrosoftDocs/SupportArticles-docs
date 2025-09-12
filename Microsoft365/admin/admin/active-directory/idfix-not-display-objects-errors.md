---
title: Blank is displayed in the ERROR column for one or more objects
description: Fixes a problem that blank is displayed in the ERROR column when you run the IdFix DirSync Error Remediation Tool in your on-premises AD DS environment.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: v-chblod, willfid
appliesto: 
  - Cloud Services (Web roles/Worker roles)
  - Azure Active Directory
  - Microsoft Intune
  - Azure Backup
  - Microsoft 365
ms.date: 03/31/2022
---

# "Blank" is displayed in the ERROR column for one or more objects after you run the IdFix tool

## Problem

When you run the IdFix DirSync Error Remediation Tool in your on-premises Active Directory Domain Services (AD DS) environment, "blank" is displayed in the **ERROR** column for one or more objects.

This occurs if the displayName attribute of the object isn't defined.

## Solution

To resolve this issue, specify a value for the displayName attribute of the object. To do this, follow these steps:

1. In the **UPDATE** column for the object, type the name of its displayName attribute.
2. In the **ACTION** column, click **EDIT**, and then click **Apply**.
3. Repeat steps 1 and 2 for each object that has a "blank" entry in the **ERROR** column.
4. Run IdFix again to look for more object errors.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Entra Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.
