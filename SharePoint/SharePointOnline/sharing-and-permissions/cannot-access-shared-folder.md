---
title: Users cannot access a shared folder in SharePoint Online
description: This article fixes a problem in which users can't access a shared folder in SharePoint Online.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: sharepoint-server-itpro
ms.topic: article
ms.author: luche
editor: v-jesits
ms.custom: CSSTroubleshoot
ms.date: 8/17/2020
appliesto:
- SharePoint Online
---

# Users can't access a shared folder in SharePoint Online

## Problem

In SharePoint Online, you share a folder in a site collection with a user.

You select **Activate** to enable **Limited-access user permission lockdown mode** for a SharePoint Online site collection.

   > [!NOTE]
   > You may have previously enabled this feature, or it may have been enabled because it's required for other features that you're using, such as **Publishing sites**.

When users browse to the shared folder, or to a file or a folder that's within the shared folder, they receive one of the following messages:

```adoc
Access Denied
        
You need permission to access this site.
```

## Workaround

To work around this problem, use the method that's appropriate for your situation:

- Share individual files but not folders. For more information, see [Share SharePoint files or folders](https://support.microsoft.com/en-us/office/share-sharepoint-files-or-folders-1fe37332-0f9a-4719-970e-d2578da4941c).

- If your site doesn't require **Limited-access user permission lockdown mode**, deactivate this site collection feature. To do this, follow these steps:
    > 1. As a Site Collection Administrator, select the gear icon in the upper-right corner of the screen.
    > 1. Select **Site Settings**.
    > 1. Under **Site Collection Administrator** > **Site Collection Features**, locate **Limited-access user permission lockdown mode**, and then select the **Deactivate** button.

    > [!NOTE]
    > Other features, such as publishing, may require this feature in order to work correctly.

## More information

When you share a folder with a user who can't access the parent folder or site, SharePoint assigns to the user limited access to the parent items. Specifically, SharePoint grants to the user permission to access the folder without having to obtain additional permission to access the parent folder and other items. However, after **Limited-access user permission lockdown mode** is enabled, the user no longer has access to the folder. This is because the necessary limited access permission on other items no longer works correctly.

### About "Limited Access" permission

The **Limited Access** permission level enables a user or group to access specific content without seeing other content. By granting this permission, you can share a single item in a list or library with a user who doesn't have permission to open or edit any other library items. In this situation, SharePoint automatically grants limited access to the parent list. This enables the user see the specific item that you shared.

For more information about site collection features that include **Limited-access user permission lockdown mode**, see [Enable or disable site collection features](https://support.office.microsoft.com/article/enable-or-disable-site-collection-features-a2f2a5c2-093d-4897-8b7f-37f86d83df04?correlationid=3fa0f19c-84e4-403d-9046-3c25d66fd867).

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).

Also see [Publishing Infrastructure-Turn Off-implications](https://techcommunity.microsoft.com/t5/sharepoint/publishing-infrastructure-turn-off-implications/m-p/59288).
