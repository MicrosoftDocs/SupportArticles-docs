---
title: Access denied when a user tries to approve a SharePoint Approval Workflow task in SharePoint Server or SharePoint Online
description: Describes an issue in which Access denied when a user tries to approve a SharePoint Approval Workflow task in SharePoint Server or SharePoint Online.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
  - SharePoint Server 2013
  - SharePoint Server 2010
ms.date: 12/17/2023
---

# "Access denied" error when a user tries to approve an Approval Workflow task

## Problem

In SharePoint Server 2013, SharePoint Server 2010, or SharePoint Online, you use the SharePoint 2010 Workflow platform to configure an **Approval** workflow. However, when an approver tries to approve the item, the following error message is returned:

> **Access Denied**

## Solution

To resolve this issue, grant **Edit** access to the specific task list for the workflow to the affected user.

Additionally, the user who is approving the item as part of the workflow is also required to have **Read** access to the item that's the target of the workflow.

## More information

This behavior is by design. Users who try to approve a SharePoint 2010 Approval Workflow task, but who have only **Edit** permissions to the task list item, can't view the task's form page. The user must have at least **Read** access to the workflow task list.

For more information about approval workflows, go to [Understand approval workflows in SharePoint 2010](https://support.office.com/article/understand-approval-workflows-in-sharepoint-server-a24bcd14-0e3c-4449-b936-267d6c478579?ocmsassetID=HA101857172&CorrelationId=41ffeb3a-fdca-4c19-a471-5cd02c4525ea&ui=en-US&rs=en-US&ad=US).

For more information about permission levels in SharePoint Online, go to [Understanding permission levels](https://support.office.com/article/understanding-permission-levels-in-sharepoint-87ecbb0e-6550-491a-8826-c075e4859848?ocmsassetID=HA102772294&CorrelationId=8cb2ee53-10d3-48ec-baee-588885e94ba3&ui=en-US&rs=en-US&ad=US).

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
