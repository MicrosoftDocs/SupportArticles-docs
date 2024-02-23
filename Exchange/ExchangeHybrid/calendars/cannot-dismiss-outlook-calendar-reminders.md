---
title: Calendar reminders in Outlook can't be dismissed or keep reappearing
description: Describes an issue that prevents you from dismissing calendar reminders in Outlook. Provides a resolution.
author: cloud-writer
ms.author: meerak
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - Exchange Hybrid
  - CSSTroubleshoot
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
appliesto: 
  - Exchange Online
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
ms.date: 01/24/2024
ms.reviewer: v-six
---
# Calendar reminders in Outlook can't be dismissed or keep reappearing

## Symptoms

When you try to dismiss calendar reminders in Microsoft Outlook, you discover that they can't be dismissed or keep reappearing.

## Cause

The reminders folder or the reminder view is corrupted. A sync conflict may also prevent Outlook from dismissing a reminder.

## Resolution 1

Delete the item using a command line:

1. Close Outlook.
2. Right-click the **Start** button in Windows and select **Run**.
3. In the **Run** window, type or paste the command below and select **Enter**.

    ```console
    outlook.exe /cleanreminders
    ```

If that method doesn't work, use Resolution 2.

## Resolution 2

Delete the Reminders folder by using the Microsoft Exchange Server MAPI Editor (MFCMAPI). To do this, follow these steps:

1. Download **MFCMAPI** from [github](https://github.com/stephenegriffin/mfcmapi/releases/) (scroll down and then click **Latest release**).
2. Exit Outlook.
3. Open MFCMAPI.
4. On the **Tools** menu, click **Options**, select both of the following check boxes (if they're not already selected), and then click **OK**:
   - **Use the MDB_ONLINE flag when calling OpenMsgStore**
   - **Use the MAPI_NO_CACHE flag when calling OpenEntry**

5. Click **Session**, click **Logon**, select the profile that you want to change, and then click **OK**.
6. Double-click the mailbox store that you want to open.
7. Expand **Root Container**.
8. Right-click the **Reminders** folder, and then click **Delete folder**.

    > [!NOTE]
    > Do not delete the individual items inside the Reminders folder. The Reminders folder is just a view of upcoming events on the calendar. If the items inside the folder are deleted, those items will be removed from the calendar.
9. Run the `Outlook.exe /cleanreminders` or `Outlook.exe /ResetFolders` command line. (This step re-creates the Reminders folder and adds any valid entries back in.)

## Resolution 3

The sync issue can be fixed by clearing all offline items from the Calendar folder. This will remove all items from the local copy, but they can be downloaded again from the server.

1. Right-click the affected calendar and select **Properties** > **Clear Offline Items** > **OK**. All items on the calendar will be removed.
2. Select **Send / Receive** > **Update Folder** in the ribbon to force the items' download.
