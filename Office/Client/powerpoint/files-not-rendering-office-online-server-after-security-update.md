---
title: PowerPoint files not rendering in Office Online Server after Security Update
ms.author: meerak
author: Cloud-Writer
manager: dcscontentpm
ms.date: 06/06/2024
audience: Admin
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
ms.assetid: 
appliesto: 
  - PowerPoint
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Web Server Integration (SharePoint & Non-SharePoint)
  - Open\Errors
  - CI 106705
  - CSSTroubleshoot
ms.reviewer: randring
description: Describes how to resolve an issue where PowerPoint files do not render correctly after installing a security update.
---

# PowerPoint files not rendering in Office Online Server after Security Update

## Symptoms

After patching Office Online Server to the May or June 2019 security update, PowerPoint files do not render, under what appears to be random circumstances during Skype for Business sharing sessions, and displays the following error:

> Sorry, PowerPoint Online ran into a problem opening this presentation. To view this presentation please open it in Microsoft PowerPoint.

:::image type="content" source="media/files-not-rendering-office-online-server/error-screen.png" alt-text="Screenshot of the error, showing PowerPoint Online ran into a problem." border="false":::

Also, while attempting to render PowerPoint in the browser, you might see a similar error message before or after scrolling through slides:

:::image type="content" source="media/files-not-rendering-office-online-server/error-message.png" alt-text="Screenshot of the error message before or after scrolling through slides.":::

The exact circumstances of the issue are not necessarily limited to the above scenarios. Also, the error may be present for issues other than those listed in this article.

## Cause

Issue was introduced to the product in the May and June 2019 security updates for Office Online Server.

## Resolution

This issue was resolved as part of the August 2019 Security Update for Office Online Server, but some steps must be taken to ensure functionality after the patch. This is currently the only supported resolution for the issue:

1. Remove all Office Online Servers from the farm (all servers must be removed at the same time).
2. Install the August 2019 Security update on all OOS servers but do NOT rebuild the farm yet.
https://support.microsoft.com/en-us/help/4475528/security-update-for-office-online-server-august-13 
3. Clear the caches on each Office Online Server:<br/><br/>
   a. Navigate to the cache location (note that this can change if you did not install OOS on the root drive): <br/><br/>
C:\ProgramData\Microsoft\OfficeWebApps\Working<br/><br/>
    b. Delete the "d" and "waccache" folders.<br/>
:::image type="content" source="media/files-not-rendering-office-online-server/delete-folders.png" alt-text="Screenshot to delete the d and waccache folders.":::
4. Add the Office Online Servers back to the farm.
5. Verify that the PowerPoint files appear as expected.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com).
