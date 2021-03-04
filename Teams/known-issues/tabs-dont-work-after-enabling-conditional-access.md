---
title: Enabling Conditional Access in Teams causes tabs to stop working
ms.author: v-todmc
author: McCoyBot
ms.date: 4/9/2020
audience: ITPro
ms.topic: article
manager: dcscontentpm
ms.service: msteams
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- Microsoft Teams
ms.custom: 
- CI 113425
- CSSTroubleshoot 
ms.reviewer: scapero
description: Explains why tab might stop functioning after enabling Conditional Access in Teams.
---

# Tabs not working after enabling Conditional Access

## Summary

After enabling Conditional Access on the tenant in Microsoft Teams, some tabs no longer functioning in the desktop client as expected. However, the tabs load when using the Web Client.
 
The tabs affected are the website tab and app tabs that open an AAD authentication dialog requiring users to sign-in with their AAD credentials.

## More information

To see affected tabs you must use Teams in Edge, Internet Explorer, or Chrome with the Windows 10 Accounts extension installed. Some tabs still depend on web authentication, which doesn't work in the Desktop Client when Conditional Access is enabled. Microsoft is working with partners to enable AAD single sign-on support which does support Conditional Access.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
