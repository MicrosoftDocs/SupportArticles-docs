---
title: Unable to reset this user's password for user that was set up for SSO
description: Describes an issue in which an administrator can't reset the password of a user who is a member of a domain that was formerly set up for single sign-on (SSO). Provides a resolution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
  - has-azure-ad-ps-ref
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Cloud Services (Web roles/Worker roles)
  - Azure Active Directory
  - Microsoft Intune
  - Azure Backup
  - Microsoft 365
ms.date: 03/31/2022
---

# "Unable to reset this user's password" when an admin resets the password of a domain member user

## Problem

Consider the following scenario: A user can't sign in to a Microsoft cloud service such as Microsoft 365, Microsoft Azure, or Microsoft Intune by using a user ID that's a member of a cloud service domain that was formerly set up for single sign-on (SSO). In this scenario, when a cloud service admin tries to reset the user's password by using the cloud service portal or Azure Active Directory module for Windows PowerShell, the administrator receives the following error message:

**Unable to reset this user's password. Try again later.**

## Cause 

This issue occurs if the user is a member of a cloud service domain that was formerly single sign-on (SSO)-enabled and if the user ID wasn't converted to use standard authentication.

For example, this issue can occur if the following Windows PowerShell cmdlet was used:

```powershell
convert-MSOLDomainToStandard –skipuserconversion:$true 
```

## Solution

To resolve this issue, convert the user ID to a standard (non-federated) type. To do this, follow these steps:

1. In the same Windows PowerShell console that you used to verify the issue, type the following cmdlet, and then press Enter:
   ```powershell
   Convert-MsolFederatedUser -userprincipalname < user ID > 
   ```
   > [!NOTE]
   > In this cmdlet, the placeholder <**user ID**> represents the user ID.
1. Give the user a temporary password. The next time that the user signs in to the cloud service, they have to change their temporary password before they can access cloud service resources.   

## More information

> [!NOTE]
> The Windows PowerShell cmdlets in this article require the Azure Active Directory module for Windows PowerShell. 

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Microsoft Entra Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.
