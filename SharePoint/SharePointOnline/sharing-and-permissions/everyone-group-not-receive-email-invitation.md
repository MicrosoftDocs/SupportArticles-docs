---
title: Everyone or Everyone except external users group don't receive invitation
description: This article describes an issue that users who are in the Everyone or Everyone except external users group don't receive email invitations in SharePoint Online, and provides a solution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# Users who are in the "Everyone" or "Everyone except external users" group don't receive email invitations

## Problem

Consider the following scenario:

- You share a Microsoft SharePoint Online resource with the **Everyone** or **Everyone except external users** group.

- You select the **Send an email invitation** option.

In this scenario, users who are in the **Everyone** or **Everyone except external users** group don't receive the email invitation.

## Solution

This is expected behavior in SharePoint Online. When you share a resource in SharePoint Online, users in the **Everyone** or **Everyone except external users** groups don't receive email invitations when you specify either group while the **Send an email invitation** option is selected.

## More information

For more information, go to the following Microsoft website: 

- [Share SharePoint files or folders](https://support.office.com/article/1fe37332-0f9a-4719-970e-d2578da4941c)

> [!NOTE]
> While the **Everyone** or **Everyone except external users** groups are most common, other groups are also affected by this scenario. Groups that are created in the Microsoft 365 admin center and security groups that are imported from local Active Directory by using Directory Synchronization will also experience this behavior.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
