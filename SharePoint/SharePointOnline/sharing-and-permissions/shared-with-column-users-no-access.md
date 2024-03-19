---
title: SharedWith column displays users who no longer have access to a document
description: This article explains an issue where the SharedWith column displays users who no longer have access to a document in SharePoint Online.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Permissions\Errors
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# "SharedWith" displays users without document access in SharePoint Online

## Problem

Consider the following scenario:

- In a SharePoint Online library, you add the **SharedWith** column to the view for the library.

- You share a document with a user or group, and the user or group is then displayed in the **SharedWith** column.

- You remove permissions for that user or group to access the shared document.

In this scenario, the user or group is still displayed in the **SharedWith** column.

## Solution

To avoid this problem, [hide the **SharedWith** column](https://support.microsoft.com/office/show-or-hide-columns-in-a-list-or-library-b820db0d-9e3e-4ff9-8b8b-0b2dbefa87e2). Then, determine who a file is shared with by using the [Manage Access panel](https://support.office.com/article/see-who-a-file-is-shared-with-in-onedrive-or-sharepoint-51bb79a9-b696-410d-a7a7-c320e541272d), audit logs, or the [site sharing report](/sharepoint/sharing-reports).

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
