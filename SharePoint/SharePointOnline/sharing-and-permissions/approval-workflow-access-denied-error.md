---
title: Access Denied message when trying to approve an Approval Workflow task in SharePoint
ms.author: luche
author: helenclu
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
description: Describes a resolution to an issue where you see an error message when trying to approve an Approval Workflow task in SharePoint. 
appliesto:
- SharePoint Online
- OneDrive for Business
---

# Error when trying to approve a SharePoint Approval Workflow task

## Symptoms

You receive one of the following messages when you try to approve an Approval Workflow task in SharePoint Online or OneDrive for Business:

- Access Denied
- You need permission to access this site
- User not found in the directory

## Cause

Many scenarios can generate these error messages. The most frequent cause is that permissions for the user or administrator are configured incorrectly or not configured at all.

## Resolution

To resolve this issue, grant **Edit** access to the specific task list for the workflow to the affected user.

Additionally, the user who is approving the item as part of the workflow is also required to have **Read** access to the item that's the target of the workflow.

## More information

This behavior is by design. Users who try to approve a SharePoint 2010 Approval Workflow task, but who have only **Edit** permissions to the task list item, can't view the task's form page. The user must have at least **Read** access to the workflow task list.

For more information about approval workflows, go to [Understand approval workflows in SharePoint 2010](https://support.office.com/article/understand-approval-workflows-in-sharepoint-server-a24bcd14-0e3c-4449-b936-267d6c478579?ocmsassetID=HA101857172&CorrelationId=41ffeb3a-fdca-4c19-a471-5cd02c4525ea&ui=en-US&rs=en-US&ad=US).

For more information about permission levels in SharePoint Online, go to [Understanding permission levels](https://support.office.com/article/understanding-permission-levels-in-sharepoint-87ecbb0e-6550-491a-8826-c075e4859848?ocmsassetID=HA102772294&CorrelationId=8cb2ee53-10d3-48ec-baee-588885e94ba3&ui=en-US&rs=en-US&ad=US).

For more information about "Access Denied" errors in SharePoint or OneDrive for Business, see the following articles:


- [Error when trying to access SharePoint Online or OneDrive for Business](access-denied-sharepoint-error.md)
- [Error when an external user tries to access SharePoint Online or OneDrive for Business](error-when-external-user-tries-to-access-sharepoint-onedrive.md)
- [Error when trying to access a shared folder or "Access Requests" list](access-requests-list-error-access-denied.md)
- [Users can't access a shared folder in SharePoint Online](cannot-access-shared-folder.md)

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).