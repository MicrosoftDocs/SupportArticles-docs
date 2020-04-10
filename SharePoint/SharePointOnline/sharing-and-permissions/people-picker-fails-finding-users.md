---
title: External users can't find Office 365 users in the people picker
description: External users can't find Office 365 users in the people picker when they try to share a SharePoint Online resource.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: sharepoint-server-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- SharePoint Online
---

# External users can't find users in the people picker in SharePoint Online

## Problem

An external user tries to share a Microsoft SharePoint Online resource with a Microsoft Office 365 user. But when the external user types either the other user's name or a partial email address, the people picker doesn't return results.

## Solution/Workaround

To work around this issue, external users must type the complete email address of the internal users to share anything within SharePoint Online with those users.

## More information

This issue occurs because external users can't run Active Directory queries in the people picker in SharePoint Online.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
