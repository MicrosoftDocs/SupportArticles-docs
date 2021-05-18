---
title: URL for meetings doesn't use the custom domain
description: Describes an issue in which the "Meet Now" URL fails to reflect a custom domain that you set up in Skype for Business Online. Provides a solution.
author: Norman-sun
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.author: v-swei
ms.reviewer: dahans
ms.custom: CSSTroubleshoot
appliesto:
- Skype for Business Online
---

# URL for meetings in Skype for Business Online doesn't use the custom domain that you created

## Problem 

Consider the following scenario.

- You set up an account in Office 365 by using the abc.onmicrosoft.com domain. 
- Later, you decide to use litwareinc.com as your custom domain in Office 365. 
- You create a user who has a sign-in address of user1@litwareinc.com.   
- When user1@litwareinc.com creates a Skype for Business Online (formerly Lync Online) meeting, the meeting URL still reflects the old domain (abc.onmicrosoft.com), and the meeting URL resembles the following:

   https://meet.lync.com/onmicrosoft/abc/user1/45GZFH99   

In this scenario, you expect the meeting URL to reflect the new domain (litwareinc.com) as in the following example:

https://meet.lync.com/litwareinc/user1/45GZFH99

## Solution

To resolve this issue, administrators should run the **Update-CsTenantMeetingUrl** cmdlet. This cmdlet replaces the old meeting URL with a new one that contains the custom URL instead. For example: https://meet.lync.com/onmicrosoft/user1/37JYLP71.

For more information about the **Update-CsTenantMeetingUrl** cmdlet, see [Update-CsTenantMeetingUrl](/powershell/module/skype/Update-CsTenantMeetingUrl).

## More Information

The **update-CsTenantMeetingUrl** cmdlet updates the Skype for Business Online meeting URL to a simpler and more standardized format. This eliminates problems that may occasionally occur with the original meeting URL. For example, assume that an organization sets up an Office 365 domain that has the name contoso.onmicrosoft.com. In this situation, the organization meetings have URLs that resemble the following:

https://meet.lync.com/onmicrosoft/contoso/user1/45GZFH99

Now, assume that the organization undergoes some changes and decides to use a custom URL (litwareinc.com) instead of the default URL of onmicrosoft.com. The organization changes its user email addresses to use the litwareinc.com domain. However, its meeting URLs still use the old domain name. For example, the **Meet Now** URLs are https://meet.lync.com/contoso/user1/45GZFH99. The only way to fix this issue is by running the **Update-CsTenantMeetingUrl** cmdlet.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).