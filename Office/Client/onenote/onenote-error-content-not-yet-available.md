---
title: Content Not Yet Available error in OneNote
ms.author: meerak
author: Cloud-Writer
manager: dcscontentpm
ms.date: 06/06/2024
audience: Admin
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - OneNote Online (OneNote on the Web)
  - OneNote for Win 10
  - OneNote App on Teams Client
  - OneNote for Mac
  - OneNote on Devices
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Open\ContentNotYetAvailable
  - CI 117004
  - CSSTroubleshoot
description: Describes resolutions to the OneNote error message Content Not Yet Available.
---

# OneNote error: "Content Not Yet Available"

## Symptom

When you try to access a OneNote page, you receive the following error:

> **Content Not Yet Available**<br/>
> Sorry, it looks like this page was added from another computer and hasn't synced yet. Click here or press ENTER to reload this page.

   :::image type="content" source="media/onenote-error-content-not-yet-available/error-message.png" alt-text="Screenshot of the error after accessing the OneNote page.":::



## Cause

This issue occurs for one of the following reasons:

- Your OneNote Notebook content is not synced completely with the SharePoint Online or OneDrive for Business server. 
- You are disconnected from internet.
- Your account is not authenticated (that is, you are not signed-in).
- The OneNote client is offline.


## Resolution 

Check to see whether the page (or section) is in one of the following states:

- **Opened and accessed across different devices.** Check whether the content is visible on another device. 
- **Shared with multiple users.** Check whether other users experience the same problem. 
    - If "no" (content is visible), move the available content to a new section.
    - If "yes" (content isn't visible), consider the next two options.
- **Stored in OneDrive for Business.** Follow the steps in [Restore your OneDrive](https://support.office.com/article/restore-your-onedrive-fa231298-759d-41cf-bcd0-25ac53eb8a15) to restore the content to a previous state.
- **Stored in SharePoint Online**. If so, follow the steps in [Restore your OneDrive](https://support.office.com/article/restore-your-onedrive-fa231298-759d-41cf-bcd0-25ac53eb8a15) to identify whether the content is in a restorable state. 
    > [!NOTE]
    > SharePoint Online retains backups of all content for 14 additional days beyond actual deletion. If content cannot be restored through the Recycle Bin or [Files Restore](https://support.office.com/article/restore-your-onedrive-fa231298-759d-41cf-bcd0-25ac53eb8a15), an [administrator can contact Microsoft Support to request a restoration](/microsoft-365/admin/contact-support-for-business-products?view=o365-worldwide&tabs=online&preserve-view=true) any time inside the 14-day window.

## More information

### Why this error occurs

When you use OneNote, it is important that you give each page and section adequate time to reach our servers. The status of this operation for a given page is indicated by the cloud icon on the ribbon. If not enough time has passed, the customer may receive the "Content Not Yet Available" error message for the page. This can occur when you view the page from another device, from the OneNote app, or in a browser window.

The speed at which notes can be retrieved might be affected by poor network connections, organizational traffic, and geographic location. In these situations, the error should resolve itself within a few hours, at most, after the underlying cause is corrected.


### Best practices for saving pages 

To make sure that your data is synced to the cloud, you must see the successful sync status icon before you exit your OneNote session (whether by closing the OneNote app or by closing the browser session).

> [!NOTE]
> OneNote Online (OneNote on the Web) and the OneNote on Teams client have no local caches. Using either app in offline mode may cause unrecoverable data loss, if the sync does not connect to the server.<br/><br/>
OneNote 2016 and OneNote for Win 10 each keep a cached copy of your pages on your device. We recommend that you use them offline until the next time that you connect to the internet. By that time, all the changes that you made will be synced to OneDrive so that you'll be able to see the changes on other devices.

A "successful sync" icon can appear in either of the following user interface locations:

> [!NOTE]
> All screenshot images are taken from OneNote for Windows 10.

:::image type="content" source="media/onenote-error-content-not-yet-available/successful-sync-icon.png" alt-text="Screenshot of the successful sync icon in OneNote.":::<br/><br/>
:::image type="content" source="media/onenote-error-content-not-yet-available/saved-status.png" alt-text="Screenshot of the successful sync status icon.":::
 
### Other OneNote sync status messages

- A page sync is in progress.

  :::image type="content" source="./media/onenote-error-content-not-yet-available/sync-progress.png" alt-text="Screenshot shows the notebook is sync in progress.":::

- A page has been saved offline.

  :::image type="content" source="media/onenote-error-content-not-yet-available/saved-offline.png" alt-text="Screenshot shows the notebook has been saved offline.":::
  :::image type="content" source="media/onenote-error-content-not-yet-available/unsaved-changes-offline.png" alt-text="Screenshot shows Unsaved Changes (Offline) in OneNote.":::
 
- A page has not been saved because of network issues and OneNote is trying to reconnect.

  :::image type="content" source="media/onenote-error-content-not-yet-available/network-issues-reconnect.png" alt-text="Screenshot shows the notebook has network issues and is trying to connect.":::
 
Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
