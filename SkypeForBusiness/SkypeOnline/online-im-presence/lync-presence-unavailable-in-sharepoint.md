---
title: Lync presence is unavailable or missing in SharePoint sites
description: Describes an issue in which the Lync presence is unavailable or missing in SharePoint sites. Provides a solution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: skype-for-business-online
ms.topic: article
ms.author: v-six
ms.reviewer: dahans, rorylen
ms.custom: CSSTroubleshoot
appliesto:
- Skype for Business Online
- SharePoint Online
---

# Lync presence is unavailable or missing in SharePoint sites

## Problem 

When you view a SharePoint site, the Lync presence icons that are next to the user names are unavailable (appear dimmed), and the status is displayed as **Presence Unknown**. 

## Solution

If the Lync 2010 or Lync 2013 client is not running, or if no user is signed in, the presence status is not available in SharePoint. Make sure that the user is signed in to Lync and that presence is working correctly in the Lync client.

The other resolution to this issue involves updating the ProxyAddresses Active Directory attribute to include the SharePoint user’s Lync address. This is especially important if the Lync and SharePoint environments aren’t in the same domain or forest. For example, if SharePoint is hosted on-premises but users sign in to Skype for Business Online (formerly Lync Online) through Office 365, you should update the ProxyAddresses Active Directory attribute in this manner. As long as the ActiveDirectory object that's associated with the SharePoint user contains the user’s Lync sign-in address in the ProxyAddresses attribute, presence should display for that contact.

If you have Exchange tools available, populate the ProxyAddresses attribute by using the method that's described in the following Microsoft Knowledge Base article: 

[2614242 ](https://support.microsoft.com/help/2614242) How to integrate Exchange Server 2013 with Lync Server 2013, Skype for Business Online, or a Lync Server 2013 hybrid deployment

If you do not have Exchange tools available, populate the ProxyAddresses attribute manually by using tools such as ADSIEdit. When you add the value, use the following format: 

**SIP:user@contoso.com**

## More Information 

This issue occurs mainly when the Lync client is not installed or when the Lync user is not signed in. This issue may also occur if there is incorrect information in Active Directory that prevents SharePoint from knowing which Lync users are associated with SharePoint users.

This article applies primarily to Skype for Business Online and SharePoint Server on-premises integration. However, it can also be used for an installation of Lync Server that has SharePoint Online integration as long as directory synchronization is enabled.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
