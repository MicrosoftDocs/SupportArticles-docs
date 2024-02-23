---
title: SharePoint workflow that uses Replace List Item Permissions action fails
description: This article describes an issue where SharePoint workflow that uses the Replace List Item Permissions action fails, and provides a solution.
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
  - SharePoint Server
ms.date: 12/17/2023
---

# SharePoint workflow that uses the "Replace List Item Permissions" action fails

## Problem

Consider the following scenario:

- You have a SharePoint Online or SharePoint Server site collection that contains complex permissions. For example, you have more than 200 SharePoint groups.

- You have a workflow that uses the SharePoint 2010 Workflow Platform Type.

- The workflow uses the Replace List Item Permissions action.

In this scenario, the workflow fails.

## Solution/Workaround

To work around this issue, do one of the following:

- Break inherited permissions and remove unique permissions for the list or library where you're running the workflow. Also remove any unnecessary permissions from the list. This limits the number of operations that are required when you use **Replace List Item Permissions** in the workflow.

- Use Active Directory or Microsoft 365 Security groups to manage permissions. Add the SharePoint groups to the security group instead of using individual SharePoint groups to manage permissions. You can manage the users in the group by using Active Directory or the Microsoft 365 admin center, depending on your configuration.

## More information

This issue occurs because the Replace List Item Permissions action causes the workflow to terminate when the site collection contains complex permissions, such as 200 SharePoint groups. This is a known limitation in SharePoint.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
