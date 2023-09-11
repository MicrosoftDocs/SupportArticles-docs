---
title: Invitation sent to a distribution list in SharePoint works for only one user
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 10/08/2020
audience: Admin
ms.topic: troubleshooting
localization_priority: Normal
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - SharePoint Server
  - SharePoint Online
ms.custom: 
  - CI 123888
  - CSSTroubleshoot
ms.reviewer: pamgreen
description: Describes a resolution to an issue where an invitation sent to a distribution list that is accessed by an external user prevents other users from accessing the SharePoint resource.
---

# SharePoint invitation sent to a distribution list works for only one user

## Symptoms

When you send an external user invitation to a shared Microsoft SharePoint resource, and a user accepts and accesses the resource, the others in the group are unable to access the resource. Instead, they receive one of the following messages:

- Access Denied
- You need permission to access this site.
- Let us know why you need access to this site.
- User is not found in the directory

## Cause

This issue occurs because distribution lists aren't supported methods for assigning SharePoint permissions. When you share with a distribution list, the first user who accepts the invitation receives access to the resource as an external user. 

## Resolution

To resolve this issue, use one of the following methods, depending on your specific scenario:

- If you're using directory synchronization, share the resource with security groups and not with a distribution list.
- Use SharePoint groups. For more information, go to [Customize SharePoint site permissions](/sharepoint/customize-sharepoint-site-permissions).
- Use Microsoft 365 groups. For more information, go to [Learn about Microsoft 365 Groups](https://support.microsoft.com/office/learn-about-microsoft-365-groups-b565caa1-5c40-40ef-9915-60fdb2d97fa2).

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).