---
title: Error when you run the IdFix tool
description: Describes how to resolve an error that occurs when you run the IdFix DirSync Error Remediation Tool in your on-premises AD DS environment.
author: MaryQiu1987
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.prod: office 365
ms.topic: article
ms.author: v-maqiu
ms.reviewer: v-chblod
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Cloud Services (Web roles/Worker roles)
- Azure Active Directory
- Microsoft Intune
- Azure Backup
- Office 365 Identity Management
---

# "You first must install one of the following versions of .NET Framework" when you run the IdFix tool

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Problem

When you try to run the IdFix DirSync Error Remediation Tool in your on-premises Active Directory Domain Services (AD DS) environment, you receive the following error message:

```adoc
To run this application, you first must install one of the following versions of .NET Framework. 
```

This issue occurs if the Microsoft .NET Framework 4 isn't installed on the computer. The IdFix tool requires the .NET Framework 4 to run. 

## Solution

To resolve this issue, install the .NET Framework 4 on the computer on which the IdFix tool is installed. The .NET Framework 4 is available from [Microsoft .NET Framework 4 (Web Installer)](https://www.microsoft.com/download/details.aspx?id=17851).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Azure Active Directory Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.
