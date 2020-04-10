---
title: Shared items are missing in SharePoint Online search results
description: you have a SharePoint group that contains many users, and the group is used to define permissions for the resource that is missing from search results.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: sharepoint-server-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- SharePoint Online
---

# Items shared with many individual users are missing from SharePoint Online search results

## Problem

When you search for an item in SharePoint Online, no results are returned.

In this scenario, you have a SharePoint group that contains many users, and the group is used to define permissions for the resource that is missing from search results.

## Solution

To resolve this issue, keep SharePoint group membership size under 2,000 users.

If you need to grant access to many individual users, use an O365 security group as an alternative. To do this, create a security group, and then add the security group to the SharePoint group instead of adding the individual users to the SharePoint group. Next, add the individual users to the security group.

For more information about security groups in Office 365, see [Create, edit, or delete a security group in the admin center](https://docs.microsoft.com/office365/admin/email/create-edit-or-delete-a-security-group?redirectSourcePath=%252fen-us%252farticle%252fcreate-edit-or-delete-a-security-group-in-the-office-365-admin-center-55c96b32-e086-4c9e-948b-a018b44510cb&view=o365-worldwide).

## More information

This issue occurs because search results aren't available for a resource when more than 2,000 users are in a SharePoint group, and the group is used to define permissions for the resource.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
