---
title: A user or an admin forgot their password
description: Fixes an issue in which a user or an administrator forgets his or her password and can't sign in to Office 365, Azure, or Microsoft Intune.
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

Follow one of the options to rest your password depending on whether or not you have admin privileges to the service that you're trying to sign into.

If you don't have administrator privileges:

- Ask your admin to reset your password.
- If your admin has turned on the capability for you to reset your own password, use the Self-Service Password Reset wizard.
  - If you're using a work or school account, use [https://passwordreset.microsoftonline.com](https://passwordreset.microsoftonline.com/).
  - If you're using a Microsoft account, use [https://account.live.com/ResetPassword.aspx](https://account.live.com/resetpassword.aspx).

If you have administrator privileges:

- Reset your own password if you've already set up an alternate email address and a mobile phone number.
- Request another admin in your company to reset your password.
- If you've forgotten the password for your company's admin account in Azure or Intune, see [Quickstart: Self-service password reset](/azure/active-directory/authentication/quickstart-sspr).

## More information

- You can use the Self-Service Password Reset wizard to contact Support if the self-service password reset fails. You may need to wait a few seconds before the link to contact Support appears.
- When you submit your request to Support, include your name, telephone number, and email address so that a Support professional can contact you.
- If you're the only admin on your Azure subscription and have forgotten the password, contact [Azure support](https://azure.microsoft.com/support/create-ticket/).  
- You can also use the following resources to contact Support:
  - Office 365: [Get support for O365](/microsoft-365/admin/get-help-support)
  - Azure: [Get support for Azure](https://azure.microsoft.com/support/create-ticket/)
  - Intune: [Get support for Intune](/mem/get-support)
