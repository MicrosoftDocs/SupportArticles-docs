---
title: Someone has already setup Teams for your organization error in Microsoft Teams
description: This article provides three resolutions fixing an issue where Microsoft Teams shows up an error when you set up your account. 
author: TobyTu
ms.author: Bill.Kaupp
manager: dcscontentpm
audience: ITPro 
ms.topic: article 
ms.service: o365-proplus-itpro
localization_priority: Normal
ms.custom: 
- CI 116762
- CSSTroubleshoot
ms.reviewer: Bill.Kaupp
appliesto:
- Microsoft Teams
search.appverid: 
- MET150
---

# "Someone has already setup Teams for your organization" error in Microsoft Teams

## Symptoms

When setting up a Microsoft Teams account, the error "Someone has already setup Teams for your organization" occurs.

## Resolutions

There are multiple possible causes. Corresponding resolutions are listed below:

**Cause:** Someone has already set up Teams for you.

**Resolution:** Look for the invitation in your email or try to sign to Teams from a private/incognito browser with your domain credentials: [https://teams.microsoft.com](https://teams.microsoft.com).<br>


**Cause:** Your email address is tied to both a work and a personal account. For example, you're using contoso.com domain for both your Microsoft Service Account (Live ID) and your work account (Active Directory).

**Resolution:** Try to create a Teams account in a new [private/incognito browser window](https://teams.microsoft.com) and select the Work or School version for your sign-in instead of the personal version. If that doesn't work, you must unlink the two accounts to create a free Teams account. Read the **I want to use a different email address or phone number to sign in** section in [Change the email address or phone number for your Microsoft account](https://support.microsoft.com/help/12407/microsoft-account-change-email-phone-number).<br>


**Cause:** You're trying to sign up your work account to a free tenant.

**Resolution:** Use your organization's tenant for this account. For personal use, create a free Teams account with a personal email address.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).