---
title: Performance issues for too many items or folders
description: Describes a performance issue that occurs when there are too many items or too many folders in a cached mode .ost file or .pst file folders. Provides a resolution.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: office-perpetual-itpro
localization_priority: Normal
ms.custom: 
- Outlook for Windows
- CSSTroubleshoot
ms.reviewer: gregmans, gbratton
appliesto:
- Outlook for Office 365
- Outlook 2019
- Outlook 2016
- Outlook 2013
- Microsoft Outlook 2010
search.appverid: MET150
---
# Outlook performance issues when there are too many items or folders in a cached mode .ost or .pst file

_Original KB number:_ &nbsp; 2768656

## Symptoms

If you have lots of items in any single folder, you may experience symptoms such as the following in Microsoft Outlook:

- When you use Cached Exchange Mode or an Outlook data (.pst) file, you notice performance issues when you perform certain actions.
- You experience decreased performance in Outlook if the Inbox, Calendar, Tasks, Sent Items, and Deleted Items folders contain lots of items.
- Calendar performance is inconsistent. For example, meeting updates may not be reflected in the primary, shared or delegated Calendar.

If you have lots of mail folders, you may experience performance issues such as the following:

- Folders are not displayed correctly, or they take a long time to appear, especially in cached mode.
- If your Outlook profile has shared mailboxes and has caching enabled (**Download Shared Folders** is selected), folder synchronization issues, performance issues, and other problems occur if the number of shared folders per mailbox exceeds 500, as described in [Performance and synchronization problems when you work with folders in a secondary mailbox in Outlook](https://support.microsoft.com/help/3115602). Additionally, errors are logged in the Sync Issues folder and "9646" events are logged in the Application log.
- In extreme cases, if there are more than 10,000 folders, Outlook is very slow to open. This behavior occurs because it takes a long time to enumerate the folders.

## Cause

This problem may occur if you have folders that exceed the limit for the number of items per folder or if you have too many folders total. The limits for Outlook 2019, Outlook 2016, Outlook 2013, and Outlook 2010 are as follows:

- 100,000 items per folder
- 5,000 items per Calendar folder

## Resolution

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/help/322756) in case problems occur.

If you have folders that exceed the limit for the number of items in an Outlook data (.pst) file or an offline Outlook data (`.ost`) file, move items from the larger folders to separate or smaller folders in the same mailbox or data file. Optionally, if you have a Microsoft Exchange online archive, you can move items to that archive.

If you have exceeded the recommended limit of 5,000 total Calendar items, use any of the following methods to reduce the number of items that you have.

### Method 1

If you have enabled Online Archive Mailbox, archive items to the Online Archive Mailbox.

### Method 2

Apply a Retention Policy on the Calendar folder to delete items from this folder. (For example: Any item that is not modified within one year moves to the Deleted Items folder.)

### Method 3

In Sync Window Settings, adjust the number of months of data that are synced for the primary shared calendars. To do this, add the following registry keys.

> [!NOTE]
> This method applies to [Version 1810](/officeupdates/monthly-channel-2018#version-1810-october-29) or later version of Microsoft 365 Apps for enterprise (Click-to-Run).

|Description|Setting to enable Calendar Sync window|
|---|---|
|Registry Path|HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Outlook\Cached Mode|
|Name|CalendarSyncWindowSetting|
|Type|REG_DWORD|
|Value|Value = 0 Inactive<br/>Value = 1 Primary Calendar folder<br/>Value = 2 All Calendar folders<br/>Defaults to 0 if not set|
|||

|Description|Setting to control the number of months in the Calendar Sync window|
|---|---|
|Registry Path|HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Outlook\Cached Mode|
|Name|CalendarSyncWindowSettingMonths|
|Type|REG_DWORD|
|Value|Value = Choose decimal value to select how many months in the Calendar sync window such as 1, 3, 6, or 12<br/>Defaults to 6 if not set|
|||

|Description|Setting to control whether to keep all recurring items instead of filtering them|
|---|---|
|Registry Path|HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Outlook\Cached Mode|
|Name|CalendarSyncWindowAllRecurring|
|Type|REG_DWORD|
|Value|0|
|||

These registry keys update the sync restriction so that the Cached Mode client downloads fewer Calendar items, even for a Calendar that has multiple years of history on the server. These keys don't clean up older Calendar content that was already downloaded. However, this method can be effective if you're willing to *clear offline items* and resync your Calendar (instead of bulk deleting old items). If you already have the Calendar in the profile, you have to clear the Offline Items after you set the registry keys and restart Outlook.

To clear offline Calendar items, follow these steps:

1. Open the **Calendar** pane in Outlook, then right-click the **Calendar**  folder.
2. Select **Properties**.
3. On the **General** tab, select **Clear Offline Items**.
4. Select **OK**.

Additionally, you can use the Support and Recovery Assistant (SaRA) for Office 365 to diagnose issues that affect Outlook. (The tool works for both programs.)

To download and install the tool, go to the following Microsoft website:

[Download Microsoft Support and Recovery Assistant for Office 365](https://support.microsoft.com/office/about-the-microsoft-support-and-recovery-assistant-e90bb691-c2a7-4697-a94f-88836856c72f)

In the tool, run the Outlook Diagnostic under the Advanced Diagnostics section to determine the cause of the performance issue.

## More information

To view the Calendar item count, use the **Calendar Properties** dialog box to check how many items are in a Calendar folder in Outlook Cached Mode.

To do this, follow these steps:

1. Open the Calendar pane in Outlook, then right-click the **Calendar** folder.
2. Select **Properties**.
3. On the **General** tab, select **Show total number of items**.
4. Select the **Synchronization** tab.
5. View the count under **View statistics for this folder**.

Outlook uses an `.ost` file only if the Exchange email account is configured to use Cached Exchange Mode. When Outlook is configured to connect to the Exchange mailbox in online mode, an `.ost` file is not used. If your Outlook client is connected to Exchange in online mode, and you do not have high item-count folders in a .pst file, the performance issue may be occurring on the server.

For more information about Outlook performance issues, see [You may experience application pauses if you have a large Outlook data file](https://support.microsoft.com/help/2759052/).
