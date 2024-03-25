---
title: You are not allowed to create team sites when you click new site on the SharePoint Online Followed Sites page
description: Describes an issue in which you receive You are not allowed to create team sites error message when you click new site on the SharePoint Online Followed Sites page.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Permissions\Permission Groups
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# "You are not allowed to create team sites" error message when you click "new site" on the SharePoint Online "Followed Sites" page

## Problem

When you click **new site** on the **Followed Sites** page in Microsoft SharePoint Online, you receive the following error message:

> You are not allowed to create team sites at `https://yourdomain.sharepoint.com/`.

> [!NOTE]
> The yourdomain placeholder represents the domain that you use for your organization.

## Solution

To fix this issue, an administrator must provide Create Subsites permissions to the users who need permission to use the "new site" link.

> [!NOTE]
> If you use this solution, all users who are added to the new group that you create will be able to create subsites within the site collection. There are many methods that provide this level of access. However, this solution lets you (the administrator) easily manage the number and range of people who can also create subsites. You manage this variable by adding or removing users from the new group.

To determine the location at which a site is created after a user clicks the **new site** link, follow these steps:

1. Log on to the SharePoint admin center, and then click settings.

2. In the **Start a Site** option, review the URL that's listed in the **Create sites under** field. For example, the value may be `https://contoso.sharepoint.com`, where *contoso* is the domain name that you use for your organization.

To create a new permission level, you must be an administrator of the site that's been specified to have sites created under it. In this situation, follow these steps:

1. Click the gear icon for the **Tools** menu, and then click **Site settings**.

2. Click **Site Permissions**.

3. On the ribbon, click **Permission Levels**, and then click **Add a Permission Level**.

4. Enter a name for the permission level, and then in the **Site Permissions** section, select the **Create Subsites** check box.

5. Click **Create**.

To create a group that uses the new permission level, follow these steps as an administrator of the site:

1. Click the gear icon for the **Tools** menu, and then click **Site settings**.

2. Click **Site Permissions**, and then click **Create Group**.

3. Provide a name for the group, and then in the **Give Group Permission to this Site** section, select the check box next to the name of the new permission level that you created.

   > [!NOTE]
   > There are also other settings available in this section. Select any additional settings as appropriate for your particular scenario.

4. Click **Create**.

Add and remove users from the new group in order to grant or deny the permissions that you've configured.

## More information

This issue occurs because the user who is trying to create the site doesn't have **Create Subsites** permissions for the site collection where the user is trying to create the site.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
