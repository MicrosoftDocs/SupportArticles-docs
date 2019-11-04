---
title: Microsoft Teams is stuck in a login loop in Edge or Internet Explorer
description: Microsoft Teams continous loop in Edge or Internet Explorer when you try to sign in to Teams.microsoft.com. But not in other browsers.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: msteams
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- Microsoft Teams
- Skype for Business Online
---

# Microsoft Teams is stuck in a login loop in Edge or Internet Explorer

## Symptoms

When you try to sign in to Microsoft Teams in Microsoft Edge or Internet Explorer, the site continually loops, and you can never sign in. 

## Cause

This issue occurs if your organization uses **Trusted Sites** in Internet Explorer and doesn't enable the URLs for Microsoft Teams. In this case, the Teams web-based application cannot sign in, as the trusted sites for Teams are not enabled. 

## Resolution

To resolve this issue, make the following changes to Internet Explorer settings either through administrator rights or a Group Policy object (GPO). 

> [!NOTE]
> This procedure must be performed in Internet Explorer. Edge uses the same settings. 
 
1. In the Internet Options window, click **Privacy** and then **Advanced**.    
2. Select **Accept** for **First-party Cookies** and **Third-party Cookies**. Also, select the **Always allow session cookies** check box.     
3. In the Internet Options window, click **Security** -> **Trusted Sites** -> **Sites**.     
4. Add all the following sites: 

    - https://*.microsoft.com
    - https://*.microsoftonline.com
    - https://*.teams.skype.com
    - https://*.teams.microsoft.com
    - https://*.sfbassets.com
    - https://*.skypeforbusiness.com     

> [!NOTE]
> It's always good to validate and enable all trusted URLs for Teams and review the requirements in the following article: 
 
[Microsoft Teams](https://support.office.com/article/Office-365-URLs-and-IP-address-ranges-8548a211-3fe7-47cb-abb1-355ea5aa88a2#bkmk_teams)