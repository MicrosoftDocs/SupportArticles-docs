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
ms.date: 3/31/2022
---

# The "Shared With" column displays users who no longer have access to a document in SharePoint Online

## Problem

Consider the following scenario.

- In a SharePoint Online library, you add the **Shared With** column to the view for the library.

- You share a document with a user or group, and the user or group is then displayed in the **Shared With** column.

- You remove the permissions for the user or group with whom you previously shared the document. However, the user or group is still displayed in the **Shared With** column.

## Solution

To avoid this issue, [hide the **Shared with** column](https://support.microsoft.com/office/show-or-hide-columns-in-a-list-or-library-b820db0d-9e3e-4ff9-8b8b-0b2dbefa87e2) and then determine who a file is shared with by using the [Manage Access panel](https://support.office.com/article/see-who-a-file-is-shared-with-in-onedrive-or-sharepoint-51bb79a9-b696-410d-a7a7-c320e541272d), audit logs, or the [site sharing report](/sharepoint/sharing-reports).

## More information

This is a known issue. The **Shared with** column may display any accounts with whom the document was previously shared before automatic updating of this column was disabled. However, the contents of the column will not be automatically added to nor cleaned up in future versions of the software.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).