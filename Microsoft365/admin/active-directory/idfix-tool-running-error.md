---
title: Error when you run the IdFix tool
description: Describes how to resolve an error that occurs when you run the IdFix DirSync Error Remediation Tool in your on-premises AD DS environment.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: v-chblod
ms.custom: 
  - CSSTroubleshoot
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

# "You first must install one of the following versions of .NET Framework" when you run the IdFix tool

## Problem

When you try to run the IdFix DirSync Error Remediation Tool in your on-premises Active Directory Domain Services (AD DS) environment, you receive the following error message:

```output
To run this application, you first must install one of the following versions of .NET Framework. 
```

This issue occurs if the Microsoft .NET Framework 4 isn't installed on the computer. The IdFix tool requires the .NET Framework 4 to run. 

## Solution

To resolve this issue, install the .NET Framework 4 on the computer on which the IdFix tool is installed. The .NET Framework 4 is available from [Microsoft .NET Framework 4 (Web Installer)](https://www.microsoft.com/download/details.aspx?id=17851).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Entra Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.
