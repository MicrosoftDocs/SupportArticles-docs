---
title: Access Denied error when trying to access a shared folder in SharePoint
ms.author: v-todmc
author: McCoyBot
manager: dcscontentpm
localization_priority: Normal
ms.date: 8/5/2020
ms.audience: Admin
ms.topic: article
ms.service: sharepoint-online
ms.custom: CSSTroubleshoot
search.appverid:
- SPO160
- MET150
ms.assetid: 
description: Describes a resolution to an Access Denied error in SharePoint when trying to access a shared folder.
appliesto:
- SharePoint Online
- OneDrive for Business
---

# Access Denied error when trying to access a shared folder

## Symptoms

When you try to access a shared folder in SharePoint Online or OneDrive for Business, you receive one of the following error messages:

- Access Denied
- You need permission to access this site
- User not found in the directory

## Cause

There are many scenarios which can prompt one of these messages. The most frequent cause is that permissions for the user or administrator are configured incorrectly or not configured at all.

## Resolution

To work around this issue, use one of the following workarounds as appropriate for your situation:

- Share individual files but not folders.
- Share a whole site collection or subsite.
- If your site doesn't require **Limited-access user permission lockdown mode**, deactivate this site collection feature.

    > [!NOTE]
    > Other features such as publishing may require this feature to work correctly.

## More information

When you share a folder with a user who can't access the parent folder or site, SharePoint assigns the user limited access to the parent items. Specifically, SharePoint lets the user access the folder without obtaining permission to access the parent folder and other items (other than limited access). However, after **Limited-access user permission lockdown mode** is enabled, the user doesn't have access to the folder because the necessary limited access permission on other items no longer works correctly. 

#### What is "Limited Access" permission?

The **Limited Access** permission level is unusual. It lets a user or group browse to a site page or library to access a specific content item without seeing the whole list. For example, when you share a single item in a list or library with a user who doesn't have permission to open or edit any other items in the library, SharePoint automatically grants limited access to the parent list. This lets the user see the specific item that you shared. In other words, the **Limited Access** permission level includes all the permissions that the user must have to access the required item.

For more information about site collection features that includes **Limited-access user permission lockdown mode**, see [Enable or disable site collection features](https://support.office.microsoft.com/article/enable-or-disable-site-collection-features-a2f2a5c2-093d-4897-8b7f-37f86d83df04?correlationid=3fa0f19c-84e4-403d-9046-3c25d66fd867).

For more information about permission levels in SharePoint Online, go to [Understanding permission levels](https://support.office.com/article/understanding-permission-levels-in-sharepoint-87ecbb0e-6550-491a-8826-c075e4859848?ocmsassetID=HA102772294&CorrelationId=8cb2ee53-10d3-48ec-baee-588885e94ba3&ui=en-US&rs=en-US&ad=US).

For more information about "Access Denied" errors in SharePoint or OneDrive for Business, see the following articles: 

- [Error message when trying to access SharePoint Online or OneDrive for Business](access-denied-or-need-permission-error-sharepoint-online-or-onedrive-for-business.md)
- [Error message when an external user tries to access SharePoint Online or OneDrive for Business](error-when-external-user-tries-to-access-sharepoint-onedrive.md)
- [Access Denied error when trying to approve a SharePoint Approval Workflow task](approval-workflow-access-denied-error.md)

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).