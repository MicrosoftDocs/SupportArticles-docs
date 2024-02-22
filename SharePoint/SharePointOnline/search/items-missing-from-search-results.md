---
title: Shared items are missing in SharePoint Online search results
description: you have a SharePoint group that contains many users, and the group is used to define permissions for the resource that is missing from search results.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: CSSTroubleshoot
ms.author: luche
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# Items shared with many individual users are missing from SharePoint Online search results

## Problem

When you search for an item in SharePoint Online, no results are returned.

In this scenario, you have a SharePoint group that contains many users, and the group is used to define permissions for the resource that is missing from search results.

## Solution

To resolve this issue, keep SharePoint group membership size under 2,000 users.

If you need to grant access to many individual users, use an O365 security group as an alternative. To do this, create a security group, and then add the security group to the SharePoint group instead of adding the individual users to the SharePoint group. Next, add the individual users to the security group.

For more information about security groups in Microsoft 365, see [Create, edit, or delete a security group in the admin center](/office365/admin/email/create-edit-or-delete-a-security-group).

## More information

This issue occurs because search results aren't available for a resource when more than 2,000 users are in a SharePoint group, and the group is used to define permissions for the resource.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).