---
title: We could not verify your account when reset admin password in Office 365
description: Describes a scenario where you receive an error message when you try to reset your admin password in Office 365, Microsoft Intune, or Azure.
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
appliesto:
- Cloud Services (Web roles/Worker roles) 
- Azure Active Directory 
- Microsoft Intune 
- Azure Backup 
- Office 365 
- User and Domain Management
---

# "We could not verify your account" error when you try to reset your admin password in Office 365, Intune, or Azure

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Problem 

When you try to reset your admin password for a Microsoft cloud service such as Office 365, Microsoft Intune, or Microsoft Azure, you receive the following error message:

**We could not verify your account**

**To protect your account, we need to contact the mobile phone associated with your account before you can use this site to reset your password. Unfortunately, recent attempts to contact you at this number were not successful.**

**If you'd like, we can contact another administrator in your organization to reset your password for you.**

**If this option doesn't work for you, please contact Support.**

## Cause 

This issue occurs if the UsageLocation parameter isn't set for your user account in Azure Active Directory (Azure AD). Self-service password reset for admins doesn't work if the UsageLocation parameter isn't set.

## Solution 

To change your password, ask another admin to reset it. If there are no other admins in your organization, contact Technical Support. 

To resolve the issue that triggers the error message, use one of the following methods, as appropriate for your situation.

### Method 1: Set your mobile phone number

Work with another admin to set your mobile phone number. Or, after you're able to sign in, update your mobile phone number in your cloud service portal.

### Method 2: Set your user location

Work with another admin to set your user location. Or, after you're able to sign in, set your user location in the Office 365 portal. To do this, follow these steps:

1. Sign in to the Office 365 portal ([https://portal.office.com](https://portal.office.com)).
2. Go to **users and groups**, and then select the admin account.   
3. Go to **settings**.   
4. Under **Set user location**, select the region where you're located.    
Or, you can use the Set-MsolUser Azure Active Directory Module for Windows PowerShell cmdlet together with the UsageLocation parameter to set your user location.

## More information

For more info about the Set-MsolUser cmdlet, see [Set-MsolUser](https://technet.microsoft.com/library/dn194136.aspx).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Azure Active Directory Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.