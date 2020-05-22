---
title: Search results don't appear for group owners after creating a new Office 365 group
ms.author: v-todmc
author: todmccoy
manager: dcscontentpm
ms.date: 10/18/2019
ms.audience: Admin
ms.topic: article
ms.service: sharepoint-online
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- SharePoint Online 
ms.custom: 
- CI 108412
- SSTroubleshoot
ms.reviewer: snarra, anundlie, knutb
description: Describes how to get search results to appear for a group owner after creating a new Office 365 group. 
---

# Search results don't appear for group owners after creating a new Office 365 group

## Symptoms

When the owner of an Office 365 group conducts a SharePoint Online search by way of one of the following search engines: 

- Microsoft 365 search box
- Enterprise Search Center
- Design customization search web parts
- Queries via the CSOM/REST search API

The owner fails to find content in the search results.

## Cause

The issue is caused by the security trimming of the query (filtering based on user's access rights and memberships) which only relates to the  security group membership, not the group ownership.  Office 365 groups can have an owner that is not a member.  

## Resolution

To resolve this issue, ensure that the owner is also a member of that group. All search results will then be visible for the owner of the group.

If you create a group from the admin portal, this is the dialogue you will see:

![The admin portal dialogue box.](media/search-results-dont-appear/search-results-dont-appear-1.png)

Here you can define owner of the group. The owner is not automatically added as a member. 

For the owner to be a first-class member of the group, and be able to search for all the content, you must explicitly add the owner as member of the group via the configuration dialogue:
 
![Explicitly add the owner as a member.](media/search-results-dont-appear/search-results-dont-appear-2.png)

## More information

When an admin creates a new Office 365 group, the admin is not always added as a member of the group. This depends on the actual admin dialogue used to create the group. If the owner is not a member, then the owner is not able to search for content in the group from the Microsoft 365 search interfaces and APIs. This often happens when creating a new group from the admin portal in Microsoft 365.

In certain cases, this may be the expected behavior. If an admin creates a group on behalf of a user, it may not be expected that the admin should be a member of the group. The admin can still manage the group by adding and deleting members of the group.

In other cases, this may be unintentional and cause issues because the group admin is also a participant of the group but failed to add himself/herself as a group member.
If you create the group from a user interface in Outlook or SharePoint, this is not an issue. The group creator automatically becomes a member.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
