---
title: Enabling Conditional Access in Teams causes tabs to stop working
ms.author: meerak
author: Cloud-Writer
ms.date: 10/30/2023
audience: ITPro
ms.topic: troubleshooting
manager: dcscontentpm
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - Microsoft Teams
ms.custom: 
  - sap:Teams Identity and Auth\Conditional Access
  - CI 113425
  - CSSTroubleshoot
ms.reviewer: scapero
description: Explains why tab might stop functioning after enabling Conditional Access in Teams.
---

# Tabs not working after enabling Conditional Access

## Summary

After enabling Conditional Access on the tenant in Microsoft Teams, some tabs no longer functioning in the desktop client as expected. However, the tabs load when using the Web Client.

The tabs affected are the website tabs and app tabs (such as Power BI, Forms, VSTS, PowerApps, and SharePoint List) that open a Microsoft Entra authentication dialog requiring users to sign in with their Microsoft Entra credentials.

## More information

To see affected tabs you must use Teams in Edge, Internet Explorer, or Chrome with the [Windows 10 Accounts extension](https://chrome.google.com/webstore/detail/windows-10-accounts/ppnbnpeolgkicgegkbkbjmhlideopiji) installed. Some tabs still depend on web authentication, which doesn't work in the Desktop Client when Conditional Access is enabled. Microsoft is working with partners to enable Microsoft Entra single sign-on support, which does support Conditional Access.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
