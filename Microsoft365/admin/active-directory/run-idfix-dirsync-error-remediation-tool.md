---
title: Duplicate is displayed in the ERROR column for two or more objects
description: Describes how to resolve a problem that occurs when you run the IdFix DirSync Error Remediation Tool in your on-premises Active Directory Domain Services (AD DS) environment.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.prod: office 365
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
ms.reviewer: v-chblod, willfid
search.appverid: 
- MET150
appliesto:
- Cloud Services (Web roles/Worker roles)
- Azure Active Directory
- Microsoft Intune
- Azure Backup
- Office 365 Identity Management
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

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Azure Active Directory Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.
