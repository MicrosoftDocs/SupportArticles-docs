---
title: Outlook performance issues in a Cached Exchange Mode .ost or .pst file
description: Describes performance issues if there are lots of items or folders in a Cached Exchange Mode .ost  or .pst file. Provides a resolution.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
  - CI 163089, CI 170535
ms.reviewer: gregmans, gbratton, tasitae, martinca
appliesto: 
  - Outlook for Microsoft 365
  - Outlook 2021
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook 2010
search.appverid: MET150
ms.date: 12/08/2022
---
# Outlook performance issues in a Cached Exchange Mode .ost or .pst file

_Original KB number:_ &nbsp; 2768656

## Symptoms

You experience symptoms such as the following in Microsoft Outlook:

- When you use Cached Exchange Mode or an Outlook data (.pst) file, you notice performance issues when you take certain actions.
- You experience decreased performance in Outlook if the Inbox, Calendar, Tasks, Sent Items, or Deleted Items folders contain lots of items.
- Calendar performance is inconsistent. For example, meeting updates might not be reflected in the primary, shared, or delegated calendar.
- Folders take a long time to appear or don't appear correctly.
- If your Outlook profile contains shared mailboxes and has caching enabled (**Download Shared Folders** is selected), you encounter folder synchronization issues, performance issues, or other issues if the number of shared folders per mailbox exceeds 500, as described in [Performance and synchronization problems when you work with folders in a secondary mailbox in Outlook](https://support.microsoft.com/topic/performance-and-synchronization-problems-when-you-work-with-folders-in-a-secondary-mailbox-in-outlook-d45e5881-3d32-ca00-6338-5962cfc41ea8). Additionally, errors are logged in the Sync Issues folder and "9646" events are logged in the Application log.
- In extreme cases in which there are more than 10,000 folders, Outlook is very slow to open. This behavior occurs because of the time required to enumerate the large number of folders.

## Cause

These problems might occur if a mailbox contains lots of folders or there are lots of items in any one folder. There's no hard limit to how many folders a mailbox can contain or how many items a folder can contain. However, you might experience an increase in performance issues as the number of items approaches 10,000 calendar items, 10,000 folders, or 100,000 mail items per folder. Large numbers of recurring meetings, or long-lived recurring meetings can also have an exaggerated effect on performance.

## Resolution

Use the following resolutions, as appropriate, to fix performance issues that affect your Calendar and mail.

### Resolutions for Calendar issues

To fix performance issues that affect your Calendar, try the following methods.

**Method 1**: **Manage the growth of exceptions for recurring meetings**

Not all calendar items have an equal effect on performance. One-time meetings have a relatively low impact, and long-lived, recurring meetings have a greater effect. When an instance of a recurring meeting is changed, this creates exceptions that are stored in the recurring meeting series. Every change to the meeting attributes, such as the subject, body, location, or time, creates a corresponding exception. Eventually, these exceptions inflate the size of the recurring meeting and have more performance cost.  You can address this higher cost by using Appointment Recurrence settings to set an end time or maximum recurrence count. Then, you can create a new recurring meeting instead of extending the existing recurrence.

**Method 2**: **Enable shared calendar improvements**

Use the **Turn on shared calendar improvements** option for primary calendar users and users who have delegated access to improve performance. When you enable this option, calendar actions are sent directly to the server instead of having to be synchronized from local storage. Therefore, conflict resolution can be done more efficiently.

For more information about how to activate and manage the shared calendar improvements, see [How to enable and disable the Outlook calendar sharing updates](https://support.microsoft.com/office/how-to-enable-and-disable-the-outlook-calendar-sharing-updates-c3aec5d3-55ce-4cea-84b0-80aab6d8dc26)

**Method 3**: **Limit the Sync window**

You can limit the synchronization window that’s used for calendar folders to reduce the number of items that are stored locally in your calendar folders. Doing this can improve performance.

> [!IMPORTANT]
> Follow the steps in this section carefully. Serious problems might occur if you modify the registry incorrectly. Before you modify it, [back up the registry for restoration](https://support.microsoft.com/topic/how-to-back-up-and-restore-the-registry-in-windows-855140ad-e318-2a13-2829-d428a2ab0692) in case problems occur.

In Sync Window Settings, adjust the number of months of data that are synced for the primary shared calendars. To do this, add the following registry keys.

**Note**: This method applies to [Version 1810](/officeupdates/monthly-channel-2018#version-1810-october-29) or later version of Microsoft 365 Apps for enterprise (Click-to-Run).

|Description|Setting to enable Calendar Sync window|
|---|---|
|Registry path|HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Outlook\Cached Mode|
|Name|CalendarSyncWindowSetting|
|Type|REG_DWORD|
|Value|Value = 0 Inactive<br/>Value = 1 Primary Calendar folder<br/>Value = 2 All Calendar folders<br/>Defaults to 0 if not set|

|Description|Setting to control the number of months in the Calendar Sync window|
|---|---|
|Registry path|HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Outlook\Cached Mode|
|Name|CalendarSyncWindowSettingMonths|
|Type|REG_DWORD|
|Value|Value = Select a decimal value to select the number of months in the Calendar sync window, such as 1, 3, 6, or 12<br/>Defaults to 6 if not set|

|Description|Setting to control whether to keep all recurring items instead of filtering them|
|---|---|
|Registry path|HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Outlook\Cached Mode|
|Name|CalendarSyncWindowAllRecurring|
|Type|REG_DWORD|
|Value|Value = 0 - Only recurring meeting series that have an end date that is either in the future or falls within the current calendar sync window setting will be synced. <br/>Value = 1 - All recurring meeting series will be synced, regardless of the end date. <br/>Defaults to 0 if not set|
|Explanation|By default (if the value isn't set or is set to 0), recurring meeting series that have an end date that is either in the future or falls within the current calendar sync window setting will be synced. For example, if today's date is May 3, 2022, and the calendar sync window is set to 1 month, all recurring meeting series that have an end date on or after April 3, 2022, will be synced. If the end date is outside the sync window setting, the recurring meeting series will be removed from the .ost file.<br/>To sync all recurring meeting series regardless of the end date, set the `CalendarSyncWindowAllRecurring` value to **1**.|

These registry keys update the sync restriction so that the client that's using Cached Exchange Mode downloads fewer Calendar items, even for a Calendar that has multiple years of history on the server. These keys don't clean up older Calendar content that was already downloaded. However, this method can be effective if you're willing to *clear offline items* and resync your Calendar (instead of bulk deleting old items). If you already have the Calendar in the profile, you have to clear the Offline Items after you set the registry keys and restart Outlook.

To clear offline Calendar items, follow these steps:

1. Open the **Calendar** pane in Outlook, and then right-click the **Calendar**  folder.
2. Select **Properties**.
3. On the **General** tab, select **Clear Offline Items**.
4. Select **OK**.

### Resolutions for Mail issues

If you have folders whose content is approaching the limit of 10,000 calendar items, 10,000 folders, or 100,000 mail items, and these items are stored in an Outlook data (.pst) file or an offline Outlook data (`.ost`) file, move items from the larger folders to separate or smaller folders in the same mailbox or data file. Optionally, if you have a Microsoft Exchange online archive, you can move items to that archive or create retention policies to automatically dispose of older items.

**Archive Mail items**

If you have enabled Online Archive Mailbox, archive items to the Online Archive Mailbox.

**Apply a retention policy**

Apply a retention policy on the Mail or Calendar folders to delete older items from this folder. For example: Any item that is not modified within one year moves to the Deleted Items folder.

### Run Microsoft Support and Recovery Assistant

You can use Microsoft Support and Recovery Assistant to diagnose both Calendar and Mail issues that affect Outlook. To download and install the Assistant, see [About the Microsoft Support and Recovery Assistant](https://support.microsoft.com/office/about-the-microsoft-support-and-recovery-assistant-e90bb691-c2a7-4697-a94f-88836856c72f)

In the Assistant, run the Outlook Diagnostic under the Advanced Diagnostics section to determine the cause of the performance issues.

## More information

To view the item count in an Outlook Calendar when using Cached Exchange Mode, use the **Calendar Properties** dialog box:

1. Open the Calendar pane in Outlook, and then right-click the **Calendar** folder.
2. Select **Properties**.
3. On the **General** tab, select **Show total number of items**.
4. Select the **Synchronization** tab.
5. View the count under **View statistics for this folder**.

Outlook uses an `.ost` file only if the Exchange email account is configured to use Cached Exchange Mode. When Outlook is configured to connect to the Exchange mailbox in Online mode, an `.ost` file is not used.

If your Outlook client is connected to Exchange in Online mode, and you don't have high-item-count folders in a .pst file, any performance issues that you experience might be occurring on the server. See [You may experience application pauses if you have a large Outlook data file](https://support.microsoft.com/help/2759052) for more information.
