---
title: Shared With column displays users who no longer have access to a document
description: This article explains an issue where the Shared With column displays users who no longer have access to a document in SharePoint Online.
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
ms.date: 4/19/2023
---

# "Shared With" displays users without document access in SharePoint Online

## Problem

Consider the following scenario:

- In a SharePoint Online library, you add the **Shared With** column to the view for the library.

- You share a document with a user or group, and the user or group is then displayed in the **Shared With** column.

- You remove permissions for that user or group to access the shared document.

In this scenario, the user or group is still displayed in the **Shared With** column.

## Solution

To avoid this problem, [hide the **Shared with** column](https://support.microsoft.com/office/show-or-hide-columns-in-a-list-or-library-b820db0d-9e3e-4ff9-8b8b-0b2dbefa87e2). Then, determine who a file is shared with by using the [Manage Access panel](https://support.office.com/article/see-who-a-file-is-shared-with-in-onedrive-or-sharepoint-51bb79a9-b696-410d-a7a7-c320e541272d), audit logs, or the [site sharing report](/sharepoint/sharing-reports).

## More information

This is a known issue. The **Shared with** column might continue to display accounts with whom the document was previously shared before automatic updating of this column was disabled. However, the contents of the column won't be automatically increased or cleaned up in future versions of the software.

The **SharedWith** and **SharedWithDetails** columns don't accurately reflect the permissions and people who have access to an item. Therefore, the column has been hidden by default in OneDrive and SharePoint for more than three years. Starting in the near future, we will no longer update the **SharedWith** fields during sharing operations. After that change is made, the column data will be considered to be customer content, and it won't be updated or changed by Microsoft. 

We'll gradually roll out this change to customers starting in early June. The rollout will be finished by the end of July, 2023.
In a future update, we will stop provisioning this column entirely.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
