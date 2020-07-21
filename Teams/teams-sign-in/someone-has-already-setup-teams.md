---
title: Someone has already setup Teams for your organization error in Microsoft Teams
description: Resolves an issue in which Microsoft Teams returns an error message when you try to set up your account. 
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

When you try to set up a Microsoft Teams account, you receive a "Someone has already setup Teams for your organization" error message.

## Resolution

This issue has multiple possible causes and resolutions, including the following.

**Cause 1:** Someone has already set up Teams for you.

**Resolution 1:** Look for an invitation in your email Inbox, or try to sign in to Teams from a private or incognito browser window by using your domain credentials at [https://teams.microsoft.com](https://teams.microsoft.com).<br>


**Cause 2:** Your email address is tied to both a work and a personal account. For example, you're using contoso.com domain for both your Microsoft Service Account (Live ID) and your work account (Active Directory).

**Resolution 2:** Try to create a Teams account in a new [private or incognito browser window](https://teams.microsoft.com), and then select the work or school version instead of the personal version for your sign-in. If that doesn't work, you must unlink the two accounts to create a free Teams account. For more information, see the "I want to use a different email address or phone number to sign in" section in [Change the email address or phone number for your Microsoft account](https://support.microsoft.com/help/12407/microsoft-account-change-email-phone-number).<br>


**Cause 3:** You're trying to sign up for your work account by using a free tenant.

**Resolution 3:** Use your organization's tenant for this account. For personal use, create a free Teams account by using a personal email address.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).
