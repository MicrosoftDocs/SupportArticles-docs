---
title: Forgot password to sign in to Microsoft 365, Intune, or Azure
description: Provides a resolution for when a user or administrator forgets their password to sign in to Microsoft 365, Intune, or Azure.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - CI 162285
  - CSSTroubleshoot
appliesto: 
  - Cloud Services (Web roles/Worker roles)
  - Azure Active Directory
  - Microsoft Intune
  - Azure Backup
  - Microsoft 365
ms.date: 03/31/2022
---

# Forgot password to sign in to Microsoft 365, Intune, or Azure

## Symptoms

You can't sign in to Microsoft 365, Microsoft Azure, or Microsoft Intune because you forgot your password.

## Resolution

Use one of the following options to reset your password, depending on your existing privileges to the service that you're trying to sign in to.

If you don't have administrator privileges:

- Ask your administrator to reset your password.
- If your administrator has given you the ability to reset your own password, use the Self-Service Password Reset wizard.
  - If you're using a work or school account, use [https://passwordreset.microsoftonline.com](https://passwordreset.microsoftonline.com/).
  - If you're using a Microsoft account, use [https://account.live.com/ResetPassword.aspx](https://account.live.com/resetpassword.aspx).

If you have administrator privileges:

- Reset your own password if you've already set up an alternative email address and a mobile phone number.
- Request another administrator in your company to reset your password.
- If you've forgotten the password for your company's administrator account in Azure or Intune, see [Quickstart: Self-service password reset](/azure/active-directory/authentication/quickstart-sspr).

## More information

- You can use the Self-Service Password Reset wizard to contact Support if the self-service password reset fails. You may have to wait for a few seconds before the link to contact Support displays.
- When you submit your request to Support, include your name, telephone number, and email address so that a Support professional can contact you.
- If you're the only administrator on your Azure subscription, and you have forgotten the password, contact [Azure support](https://azure.microsoft.com/support/create-ticket/).  
- You can also use the following resources to contact Support:
  - Microsoft 365: [Get support for Microsoft 365](/microsoft-365/admin/get-help-support)
  - Azure: [Get support for Azure](https://azure.microsoft.com/support/create-ticket/)
  - Intune: [Get support for Intune](/mem/get-support)
