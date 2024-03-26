---
title: The user name or password is incorrect when you use connect-MSOLService
description: Fixes an issue in which you receive an error when you use connect-MSOLService to connect to Microsoft 365.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
  - has-azure-ad-ps-ref
  - azure-ad-ref-level-one-done
appliesto: 
  - Cloud Services (Web roles/Worker roles)
  - Azure Active Directory
  - Microsoft 365
  - Microsoft Intune
  - CRM Online via Office 365 E Plans
  - Azure Backup
  - Microsoft 365 User and Domain Management
ms.date: 03/31/2022
---

# "The user name or password is incorrect" when you use connect-MSOLService to connect to Microsoft 365

## Problem

When you try to use the connect-MSOLService cmdlet in the Microsoft Azure Active Directory module for Windows PowerShell to connect to a Microsoft cloud service such as Microsoft 365, Azure, or Microsoft Intune, your attempt is unsuccessful. Additionally, you may receive the following error message:

**Connect-MsolService : The user name or password is incorrect. Verify your user name, and then type your password again.**

## Cause 

This issue may occur if the user name or password that you're using is incorrect or if there's a problem with the user account. 

[!INCLUDE [Azure AD PowerShell deprecation note](../../../includes/aad-powershell-deprecation-note.md)]

## Solution 

To resolve this issue, see [You can't sign in to your organizational account such as Microsoft 365, Azure, or Intune](https://support.microsoft.com/help/2412085).

## More information 

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Entra Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.
