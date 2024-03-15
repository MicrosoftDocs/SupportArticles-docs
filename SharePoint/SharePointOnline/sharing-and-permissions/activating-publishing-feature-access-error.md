---
title: Access Denied when you activate or deactivate for Publishing feature
description: Access Denied when you activate or deactivate the SharePoint Server Publishing feature though you have Full Control permissions.
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
  - SharePoint Server
ms.date: 12/17/2023
---

# Access error when a user tries to activate or deactivate the SharePoint Server Publishing feature

## Problem

Consider the following scenario.

- A SharePoint Online user has at least **Full Control** permissions for a subsite.
- The same user has limited permissions, or no permissions, for the site collection that contains the subsite.
- When the user browses to the **Site Features** page for the subsite and then clicks **Activate** or **Deactivate** for the SharePoint Server Publishing feature, the user receives one of the following error messages:

  **Access Denied**

  **Sorry, you don't have access to this page**

## Solution

To resolve this issue, have a site collection administrator activate or deactivate the feature on the subsite. Or, an administrator can add the affected user to the **Hierarchy Managers** group for the site collection that contains the subsite.

For more information about how to manage SharePoint groups, see [Customize SharePoint site permissions](/sharepoint/customize-sharepoint-site-permissions).

## More information

This is the expected behavior in SharePoint Online. The user must have access to the parent site collection through the **Hierarchy Managers** group to activate or deactivate the SharePoint Server Publishing site feature for the subsite.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).