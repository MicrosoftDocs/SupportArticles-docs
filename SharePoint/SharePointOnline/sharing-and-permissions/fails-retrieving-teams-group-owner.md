---
title: Teams group creator is listed as a SharePoint admin
description: SomeUser created the site is mentioned in an activity of a SharePoint web part of a group that you created by Teams.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# Creator of Microsoft Teams group is listed as a SharePoint admin

## Problem

Consider the following scenario:

- You use Microsoft Teams to create a new group.
- You locate the SharePoint site of the created group.
- The activity web parts displays an activity for the site creation.

In this scenario, the activity mentions that the site was created by another user, for example:

"*SomeUser* created the site"

## Cause

In certain scenarios, SharePoint can't retrieve the group owner. In these scenarios, SharePoint will list the first site administrator of the root site collection in the site creation activity.

## Solution

To fix this issue, follow these steps:

1. Locate the tenant root site (for example, https://*TenantPrefix*.sharepoint.com).
1. Locate **Site Settings** > **Site Collection**.
1. Add your CompanyAdministrator as the first entry in the **Administrators** field.

## More information

Microsoft is aware of the issue and working to improve the user experience.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
