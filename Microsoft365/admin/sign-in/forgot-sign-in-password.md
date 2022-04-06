---
title: A user or an admin forgot their password
description: Describes a scenario in which a user or an administrator forgets his or her password and can't sign in to Office 365, Azure, or Microsoft Intune. Provides a resolution.
author: MaryQiu1987
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-maqiu
ms.custom: 
  - CI 162285
  - CSSTroubleshoot
appliesto: 
  - Cloud Services (Web roles/Worker roles)
  - Azure Active Directory
  - Microsoft Intune
  - Azure Backup
  - Office 365 Identity Management
ms.date: 3/31/2022
---

# Forgotten password in Microsoft 365, Intune, or Azure

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Problem

You can't sign in to Microsoft 365, Microsoft Azure, or Microsoft Intune because you forgot your password.

## Solution

To fix this issue, do one of the following:

- Reset your own password by using the Self-Service Password Reset wizard:
  - If you're using a work or school account, go to [https://passwordreset.microsoftonline.com](https://passwordreset.microsoftonline.com/).
  - If you're using a Microsoft account, go to [https://account.live.com/ResetPassword.aspx](https://account.live.com/resetpassword.aspx).

  If the admin turned on the capability to let you reset your own password, you will be able to reset your own password. Otherwise, the password reset form gives you the option to contact your admin.

- Rest a password if you are an admin:

  - You can [reset a user's password](/azure/active-directory/fundamentals/active-directory-users-reset-password-azure-portal).
  - You can enable password reset for your users, see [Quickstart: Self-service password reset](/azure/active-directory/authentication/quickstart-sspr).
  - You can try to reset your own password if you had already set up an alternate email address and a mobile phone number.
  - You can reset the password for your company admin account in Azure or Intune, see [Quickstart: Self-service password reset](/azure/active-directory/authentication/quickstart-sspr).
  - If your company has more than one admin, ask another admin to reset your password.

## More information

- You can use the Self-Service Password Reset wizard to contact Support if the self-service password reset fails. You may need to wait a few seconds before the link to contact Support appears.
- When you submit your request to Support, include your name, telephone number and email address so that a Support professional can contact you.
- If you're the only admin on your Azure subscription and have forgotten the password, contact [Azure support](https://azure.microsoft.com/support/create-ticket/).  
- You can also use the following resources to contact Support:
  - Office 365: [Get support for O365](/microsoft-365/admin/get-help-support)
  - Azure: [Get support for Azure](https://azure.microsoft.com/support/create-ticket/)
  - Intune: [Get support for Intune](/mem/get-support)
