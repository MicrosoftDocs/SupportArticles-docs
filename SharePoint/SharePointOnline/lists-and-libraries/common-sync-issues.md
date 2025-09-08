---
title: Common Issues Syncing SharePoint Lists Offline
ms.author: meerak
author: Cloud-Writer
manager: dcscontentpm
ms.date: 07/30/2025
audience: Admin
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - SharePoint Online
ms.custom: 
  - sap:Lists and Libraries\Lists Offline sync
  - CI 157491
  - CSSTroubleshoot
ms.reviewer: prbalusu; nirupme
description: Provides resolutions for some common issues that affect syncing SharePoint lists offline.
---

# Common issues syncing Microsoft SharePoint lists offline

This article helps you troubleshoot common issues that occur when you try to sync Microsoft SharePoint lists offline.

## Troubleshooting
<details>
<summary><b>Sync icon doesn't appear</b></summary>

1. Open Windows Task Manager, and locate the following process under **Background Processes**:

   __Microsoft OneDrive Sync Service__ (__OneDrive.Sync.Service.exe__)  

   - If __Microsoft OneDrive Sync Service__  is running, continue to step 2.
   - If __Microsoft OneDrive Sync Service__ isn't running, the List sync process isn't running. Your organization might be preventing it from running. For more information, see [Lists sync policies](/sharepoint/lists-sync-policies). 
      
1. <a href=#logging>Enable Web App Logging</a>.  
1. Check the console log for a line that starts with "Found list" in the text. The line should resemble the following screenshot.

    :::image type="content" source="./media/common-sync-issues/console.png" alt-text="Screenshot that shows a console log line that starts with found list":::

    - If there's no log line that starts with “Found list,” the List sync process might not have synced the list yet. Wait for silent configuration or syncing to occur.
    - If the line with "Found list" shows "unsynced:true" in the text, the list is currently unsynced because List sync doesn’t support it. This is by design. We expect to extend support for lists to future versions of List sync. For more information, see the "Current Limitations of List sync" section in [Edit lists offline](https://support.microsoft.com/office/41403c3e-1795-4e07-b56b-ae591cbde2f9).

1. If __OneDrive.Sync.Service.exe__ is running, and the log contains a "Found list" line that doesn't show "unsynced," you might be experiencing a client issue. Go to <a href=#support>Contacting Support</a>.  

</details>
<details>
<summary><b>Sync icon stays on for more than 10 minutes</b></summary>

The sync icon is often in the "on" state for a few minutes. It appears next to the list name, as shown in the following screenshot.

:::image type="content" source="./media/common-sync-issues/sync-icon.png" alt-text="Screenshot that shows the sync icon next to the list name.":::

If the icon stays on for more than 10 minutes, make sure that the client device is online. If it's offline, the sync icon stays on.
If the client device is online, and the sync icon shows for more than 10 minutes, go to <a href=#support>Contacting Support</a>.

</details>
<details>
<summary><b>Local changes not synced</b></summary>

1. Check whether there are any conflicts or failed uploads. Open **View** > **All items** > **Items that need attention**.

    :::image type="content" source="./media/common-sync-issues/conflicts.png" alt-text="Screenshot that shows conflicts in the menu.":::

1. If there are conflicts, refresh the page, and then try again to run the update.
1. If there are no conflicts, or the conflicts continue to appear after step 2, go to <a href=#support>Contacting Support</a>.

</details>
<div id="support"></div>

## Contacting support
<details>
<summary><b>Information required to open a Microsoft support request</b></summary>

- **Required:** The email address that's used to sign in to the List web app.
- **Required:** A general time stamp of when the issue occurred (a time that's within a few hours is sufficient).
- **Required:** A description of the issue.
- **Required:** Web browser that you use (Edge, Chrome, Firefox).
- **Optional:** Screenshots of the issue. The more detail that you include in the request, the more likely that the Microsoft team can respond quickly.
- **Optional:** If you enabled web app logging during debugging, send a copy of the console logs. You can right-click the console in the browser tools, and then select "Save as" to generate a file.  
- **Optional:** The ticket might require client logs to be collected separately. Go to <a href=#collect>Collect Microsoft SharePoint client logs</a>.

</details>
<div id="logging"></div>
<details>
<summary><b>Enable web app logging</b></summary>

1. Open the browser, and navigate to the list that you're working with.  
1. Make sure that you use Microsoft Edge, Google Chrome, or Mozilla FireFox. These browsers are the only ones that are currently supported. Also, make sure that you're on a device that's running Windows 10 or a later version.  
1. Press F12 to open the browser tools.
1. Switch to the **Application** tab.
1. On the left side of the pane, locate a list of local storage domains. Expand the **Local Storage** category, and select the item that corresponds to the list URL. For example, if you're viewing `https://contoso.sharepoint.com/teams/teamSite/Lists/Number%20List/AllItems.aspx`, select `https://contoso.sharepoint.com`.  

1. In the right pane, add `sharepoint.datasync.nucleus.logToConsole`. To do this, select an empty line, and then set the value to **true**.

    :::image type="content" source="./media/common-sync-issues/logto.png" alt-text="Screenshot that shows that sharepoint.datasync.List sync.logToConsole is added and the value is set to true.":::

1. While the browser tools are still open, switch to the **Console** tab, and then press F5 to refresh the page. The console contains useful logging for web app issues.
</details>
<div id="collect"></div>
<details>
<summary><b>Collect Microsoft SharePoint client logs</b></summary>

1. Open File Explorer.
1. Navigate to `%localappdata%\Microsoft\OneDrive\logs\ListSync`.
1. Right-click the “Business1” folder, and then select **Send To** > **Compressed (zipped) folder**.
1. Send that compressed folder to Microsoft Support.  

</details>
<details>
<summary><b>Create a support request</b></summary>

Microsoft 365 administrative users have access to create support requests. Select the following link to populate the pane in the Microsoft 365 Admin Center:

[Run query: Issues with editing Microsoft Lists offline](https://aka.ms/editlistofflineIssue)

Complete the **Description** field by using the information that you gathered in the "Information required to open a Microsoft support request" section.

Select **Contact Support**.

</details>

## References

[Edit lists offline](https://support.microsoft.com/office/41403c3e-1795-4e07-b56b-ae591cbde2f9)

[Lists sync policies](/sharepoint/lists-sync-policies)
