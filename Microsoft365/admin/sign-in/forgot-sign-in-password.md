---
title: A user or an administrator forgot their password
description: Describes a scenario in which a user or an administrator forgets his or her password and can't sign in to Office 365, Azure, or Microsoft Intune. Provides a resolution.
author: MaryQiu1987
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: o365-administration
ms.topic: article
ms.author: v-maqiu
ms.custom: CSSTroubleshoot
appliesto:
- Cloud Services (Web roles/Worker roles)
- Azure Active Directory
- Microsoft Intune
- Azure Backup
- Office 365 Identity Management
---

# A user or an administrator forgot his or her password in Office 365, Azure, or Intune

[!INCLUDE [Branding name note](../../../includes/branding-name-note.md)]

## Problem

A user or admin forgot his or her password and can't sign in to Office 365, Microsoft Azure, or Microsoft Intune.

## Solution

To fix this issue, do one of the following:

- Try to reset your own password by using the Self-Service Password Reset wizard:
  - If you're using a work or school account, go to [https://passwordreset.microsoftonline.com](https://passwordreset.microsoftonline.com/).
  - If you're using a Microsoft account, go to [https://account.live.com/ResetPassword.aspx](https://account.live.com/resetpassword.aspx).

  If the admin turned on the capability to let you to reset your own password, you will be able to reset your own password. Otherwise, the password reset form gives you the option to contact your admin.
- If you're an admin and you want to enable password reset for your users, see [Quickstart: Self-service password reset](/azure/active-directory/authentication/quickstart-sspr).
- If you're an admin, you can try to reset your own password if you had already set up an alternate email address and a mobile phone number.
  - For more info about how to reset the password for your company admin account in Azure or Intune, see [Quickstart: Self-service password reset](/azure/active-directory/authentication/quickstart-sspr).
- If you're an admin and your company has more than one admin, ask another admin to reset your password.

> [!NOTE]
> - You can use the Self-Service Password Reset wizard to contact Support when self-service password reset fails. You may need to wait a few seconds before the link to contact Support appears.
> - When you submit your request to Support, include your name, telephone number and email address so that Support knows how to contact you.

## More information

For more info about how to reset a user's password, see [Reset a user's password](/azure/active-directory/fundamentals/active-directory-users-reset-password-azure-portal).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/) or the [Azure Active Directory Forums](https://social.msdn.microsoft.com/forums/azure/home?forum=windowsazuread) website.