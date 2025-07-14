---
title: External users cannot access a shared SharePoint file
description: The webpage cannot be found or 404 NOT FOUND when an external user accesses a shared file in SharePoint Online.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Sharing\Grant or change access to an item
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# An external user receives an error message when they click the link to a shared resource in SharePoint Online

## Problem

Consider the following scenario:

- You have a newly created file in Microsoft SharePoint Online, and you select the option to share the file with a user.
- The file is located in a library where the **Require documents to be checked out before they can be edited?** option is set to **Yes**, and the file has never been checked in.

When a user clicks the link to the file in this scenario, they receive one of the following error messages:

- **The webpage cannot be found**
- **404 NOT FOUND**

## Solution

To resolve this issue, check in the affected file before you share it. To do this, click the ellipsis button (…) for the affected file, click the second ellipsis, find the **Advanced** section, and then click **Check In**.

This must be performed by an administrator or by the user who created the file.

> [!NOTE]
> When the **Require Check Out** option for the library is set to **Yes**, newly created files can't be shared until they're checked in.

## More information

This issue occurs because the document that you're trying to share is checked out to a user.

For more information about sharing sites or documents in SharePoint Online, go to [Share SharePoint files or folders](https://support.office.com/article/share-sharepoint-files-or-folders-1fe37332-0f9a-4719-970e-d2578da4941c?ocmsassetID=HA102894713&CorrelationId=f03a5546-1dd0-48fa-98f0-906ce671d249).

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
