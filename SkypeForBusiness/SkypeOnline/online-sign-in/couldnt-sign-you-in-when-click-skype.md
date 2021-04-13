---
title: We couldn't sign you in when you click the Skype button in Office Online
description: Describes an issue that triggers a "We couldn't sign you in" error when you click the Skype button in Office Online on SharePoint Online. Provides a solution.
author: Norman-sun
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.author: v-swei
ms.custom: CSSTroubleshoot
ms.reviewer: landerl, dahans, kristinw, chanh, corbinm, rorylen
appliesto:
- Skype for Business Online
---

# "We couldn't sign you in" when you click the Skype button in Office Online on SharePoint Online

## Problem

Consider the following scenario.

- You're using Internet Explorer or Microsoft Edge to access Office Online Web App in the SharePoint Online environment.   
- When you click the **Skype** button, you receive the following error message:

   "We couldn't sign you in. Please try to sign in again or refresh the page."

## Solution

For Skype for Business Online (formerly Lync Online) chat integration to work in Office Online Web App, remove the SharePoint Online URL from the **Local intranet** or **Trusted sites** settings under **Internet Options**.

> [!NOTE]
> The Open with Explorer feature requires that your SharePoint Online URLs are included in your **Trusted Sites** list. If you want to use the Open with Explorer feature, you must add this URL back to your trusted sites. 

## More Information

This issue occurs because SharePoint Online URL domains (*.sharepoint.com) are typically added to the **Trusted** or **Local intranet** zones in Internet Explorer or Microsoft Edge. For more information, see the following Microsoft website:

[Office 365 URLs and IP address ranges](https://support.office.com/article/office-365-urls-and-ip-address-ranges-8548a211-3fe7-47cb-abb1-355ea5aa88a2)

However, authentication into Skype for Business Online is performed by using a different OrgID URL, which resembles the following:

**https://login.microsoftonline.com**

When SharePoint Online creates an iframe to Skype for Business Online to enable integration, it must first authenticate. When it does this, it redirects to the OrgID URL in the iframe. Because an iframe inherits the zone of the parent, the page that's loaded in the iframe is also in the intranet zone. Internet Explorer stores cookies independently for each security zone. Therefore, the authentication cookie in the OrgID domain that's in the Internet zone can't be accessed by the iframe that's in the intranet zone. And because users can't enter their credentials to authenticate in a hidden iframe, authentication fails.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).