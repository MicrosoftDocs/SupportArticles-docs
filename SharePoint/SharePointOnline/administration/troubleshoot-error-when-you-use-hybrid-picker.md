﻿---
title: error when you use the SharePoint Hybrid Picker
description: Describes an issue when you use the SharePoint Hybrid Picker.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: sharepoint-online
ms.custom: CSSTroubleshoot
ms.topic: article
ms.author: v-six
appliesto:
- SharePoint Online
---

# "My site URL or team site URL from Discovery Service is null or empty" error when you use the SharePoint Hybrid Picker

## Problem
When you use the SharePoint Hybrid Picker, you receive the following error message during the Hybrid solution configuring phase:

**Value cannot be null. Parameter name: My site URL or team site URL from Discovery Service is null or empty.**

## Solution

To resolve this issue, grant permissions to the **Everyone except external users** group so that users can create personal sites in Office 365, and then browse to the OneDrive for Business page as the administrator. To do this, follow these steps:

1. With an account that has the Global administrator or SharePoint administrator role, browse to the SharePoint admin center for your Office 365 subscription.

2. Click **user profiles**, and then click **Manage User Permissions**.

3. If it's not already listed, add the **Everyone except external users** group to the permissions dialog box.

4. Make sure that the **Create Personal Site (required for personal storage, newsfeed, and followed content)** permission is selected for the **Everyone except external users** group, and then click **OK**.

5. Browse to https://*your_domain*-my.sharepoint.com to provision the OneDrive for Business account for the administrator account.

   **NOTE** Replace your_domain with the domain that you use for your organization.

6. Run the Hybrid Picker again. The wizard should no longer generate an error message.

## More information

This is a known issue when you use the Hybrid Picker. This issue occurs when users don't have permissions to create sites and the administrator doesn't have a OneDrive for Business site provisioned for their account.

For more information about the Hybrid Picker, see [Hybrid picker in the SharePoint Online admin center](https://docs.microsoft.com/SharePoint/hybrid/hybrid-picker-in-the-sharepoint-online-admin-center).

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
