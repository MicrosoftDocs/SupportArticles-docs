---
title: Blank is displayed in the ERROR column for one or more objects
description: Describes how to resolve a problem that occurs when you run the IdFix DirSync Error Remediation Tool in your on-premises Active Directory Domain Services (AD DS) environment.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office 365
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
ms.reviewer: v-chblod, willfid
appliesto:
- Cloud Services (Web roles/Worker roles)
- Azure Active Directory
- Microsoft Intune
- Azure Backup
- Office 365 Identity Management
---

# "Blank" is displayed in the ERROR column for one or more objects after you run the IdFix tool

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

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

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Azure Active Directory Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.
