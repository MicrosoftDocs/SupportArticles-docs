---
title: Users can't access a shared folder in SharePoint Online
description: This article describes an issue where users can't access a shared folder in SharePoint Online, and provides a solution.
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

# Users can't access a shared folder in SharePoint Online

## Problem

Consider the following scenario:

- In SharePoint Online, you share a folder on a site collection with a user.

- You click **Activate** to enable **Limited-access user permission lockdown mode** for a SharePoint Online site collection.

   > [!NOTE]
   > You may have previously enabled this feature, or it may have been enabled because it's required for other features that you're using, such as **Publishing sites**.

- When the user browses to the shared folder, or to a file or a folder within the shared folder, he or she receives one of the following messages:
    ```adoc
    Access Denied
        
    You need permission to access this site.
    ```

## Workaround

To work around this issue, use one of the following workarounds as appropriate for your situation:

- Share individual files but not folders.

- Share a whole site collection or subsite.

- If your site doesn't require **Limited-access user permission lockdown mode**, deactivate this site collection feature.

    > [!NOTE]
    > Other features such as publishing may require this feature to work correctly.

## More information

When you share a folder with a user who can't access the parent folder or site, SharePoint assigns the user limited access to the parent items. Specifically, SharePoint lets the user access the folder without obtaining permission to access the parent folder and other items (other than limited access). However, after **Limited-access user permission lockdown mode** is enabled, the user doesn't have access to the folder because the necessary limited access permission on other items no longer works correctly. 

### What is "Limited Access" permission?

The **Limited Access** permission level is unusual. It lets a user or group browse to a site page or library to access a specific content item without seeing the whole list. For example, when you share a single item in a list or library with a user who doesn't have permission to open or edit any other items in the library, SharePoint automatically grants limited access to the parent list. This lets the user see the specific item that you shared. In other words, the **Limited Access** permission level includes all the permissions that the user must have to access the required item.

For more information about site collection features that includes **Limited-access user permission lockdown mode**, see [Enable or disable site collection features](https://support.office.microsoft.com/article/enable-or-disable-site-collection-features-a2f2a5c2-093d-4897-8b7f-37f86d83df04?correlationid=3fa0f19c-84e4-403d-9046-3c25d66fd867).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/en-us).
