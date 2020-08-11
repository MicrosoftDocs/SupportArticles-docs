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

After enabling Conditional Access on the tenant in Microsoft Teams, tabs no longer functioning in the desktop client as expected. However, the tabs load when using the Web Client.

The tabs affected include PowerBI, Forms, VSTS, PowerApps, and SharePoint List. 

## More information

To see affected tabs you must use Teams in Edge, Internet Explorer, or Chrome with the [Windows 10 Accounts extension](https://chrome.google.com/webstore/detail/windows-10-accounts/ppnbnpeolgkicgegkbkbjmhlideopiji) installed. Some tabs still depend on web authentication, which doesn't work in the Desktop Client when Conditional Access is enabled. Microsoft is working with partners to enable these scenarios. To date we have enabled Planner, OneNote, and Stream.


Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).