---
title: Error (You don't have access to this file) when opening a file in Teams
description: Provides a resolution to an issue in which user can't open a file that is automatically stored in OneDrive in Teams. 
ms.author: prbalusu
author: helenclu
manager: dcscontentpm
ms.date: 11/26/2020
audience: Admin
ms.topic: article
ms.prod: onedrive
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- Microsoft OneDrive for Business
- Microsoft Teams
ms.custom: 
- CI 125301
- CSSTroubleshoot 
ms.reviewer: prbalusu
---

# Error when opening a file in Teams: You don't have access to this file

## Symptoms

In Microsoft Teams, you share a file with another user in a chat window. Then, the file is automatically stored on your OneDrive site. When the other user tries to open the file in Teams, the following error message is displayed:

> You don't have access to this file.

## Cause

This issue occurs because the **Limited-access user permission lockdown mode** feature is activated on your OneDrive site. This is a site collection feature that helps prevent anonymous users from accessing application pages that are mostly helpful on classic, publishing-based SharePoint sites. We recommend that you do not enable this feature on OneDrive sites.

## Resolution

To fix this issue, deactivate this feature in OneDrive.

1. Sign into your OneDrive site.
2. Select the **Setting** icon in the upper-right corner of the screen.
3. Select **OneDrive Settings** > **More Settings**.
4. Under **Features and storage**, select **Site Collection Features**.
5. Locate **Limited-access user permission lockdown mode**, and then select **Deactivate**.

For more information about **Limited-access user permission lockdown mode**, see [Enable or disable site collection features](https://support.microsoft.com/office/enable-or-disable-site-collection-features-a2f2a5c2-093d-4897-8b7f-37f86d83df04).
