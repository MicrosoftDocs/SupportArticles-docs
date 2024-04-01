---
title: Search results don't appear for group owners after creating a new Microsoft 365 group
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 12/17/2023
audience: Admin
ms.topic: troubleshooting
localization_priority: Normal
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - SharePoint Online
ms.custom: 
  - sap:Search\Customize and Configure Results
  - CI 108412
  - SSTroubleshoot
ms.reviewer: snarra, anundlie, knutb
description: Describes how to get search results to appear for a group owner after creating a new Microsoft 365 group.
---

# Search results don't appear for group owners after creating a new Microsoft 365 group

## Symptoms

When the owner of a Microsoft 365 group conducts a SharePoint Online search by way of one of the following search engines: 

- Microsoft 365 search box
- Enterprise Search Center
- Design customization search web parts
- Queries via the CSOM/REST search API

The owner fails to find content in the search results.

## Cause

The issue is caused by the security trimming of the query (filtering based on user's access rights and memberships) which only relates to the  security group membership, not the group ownership. Microsoft 365 groups can have an owner that isn't a member.  

## Resolution

To resolve this issue, ensure that the owner is also a member of that group. All search results will then be visible for the owner of the group.

If you create a group from the admin portal, it's the dialogue you'll see:

:::image type="content" source="media/search-results-dont-appear/new-group-admin-center.png" alt-text="Screenshot of the New Group form in Microsoft 365 admin center.":::

Here you can define owner of the group. The owner isn't automatically added as a member. 

For the owner to be a first-class member of the group, and be able to search for all the content, you must explicitly add the owner as member of the group via the configuration dialogue:
 
:::image type="content" source="media/search-results-dont-appear/add-owner-config-dialog.png" alt-text="Screenshot of the Owners and Members fields where you can add the owner in the configuration dialogue of the group.":::

## More information

When an admin creates a new Microsoft 365 group, the admin is not always added as a member of the group. The membership setting depends on the actual admin dialogue used to create the group. If the owner is not a member, then the owner is not able to search for content in the group from the Microsoft 365 search interfaces and APIs. It often happens when creating a new group from the admin portal in Microsoft 365.

In certain cases, it may be the expected behavior. If an admin creates a group on behalf of a user, it may not be expected that the admin should be a member of the group. The admin can still manage the group by adding and deleting members of the group.

In other cases, it may be unintentional and cause issues because the group admin is also a participant of the group but failed to add himself/herself as a group member.
If you create the group from a user interface in Outlook or SharePoint, it isn't an issue. The group creator automatically becomes a member.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
