---
title: Sync issues with an .ost file
description: Provides guidance for issues when you synchronize an Exchange Server mailbox with an Offline Outlook Data File.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.reviewer: aruiz, meerak
ms.custom: 
  - sap:Clients and Mobile\Can't Connect to Mailbox with Outlook
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook for Microsoft 365
ms.date: 01/24/2024
---
# Issues when you synchronize your Exchange Server mailbox with your .ost file in Outlook

_Original KB number:_ &nbsp; 842284

When you try to synchronize a Microsoft Exchange Server mailbox with an Offline Outlook Data File (.ost), the synchronization fails, and you experience any of the following issues:

- Folders in Microsoft Outlook are not updated.
- Email messages are available in Outlook on the web (OWA) but not in Outlook.
- You see a different message count in Outlook and OWA.
- New email messages are not downloaded in Outlook.

These issues occur if either the .ost file or the Exchange Server support file is damaged. This article provides guidance to troubleshoot and resolve these issues.

## Determine whether offline folders are being synchronized

Follow these steps in Outlook:

1. Right-click an offline folder, and select **Properties**.
1. Select the **Synchronization** tab.

    > [!NOTE]
    > If you don't see the **Synchronization** tab, this indicates that you didn't set up your profile to use offline folders.

1. Under **Statistics for this folder**, verify the settings in the following fields:

    - **Last Synchronized on**
    - **Server folder contains**
    - **Offline folder contains**

    :::image type="content" source="media/ost-sync-issues/synchronization-status.png" alt-text="Screenshot shows the statistics for this folder under the Synchronization tab." border="false":::

If synchronization is working correctly, the number of items in the **Server folder contains** field and the **Offline folder contains** field will be the same.

> [!NOTE]
> The item count for the offline folder depends on the **Mail to keep offline** or the **Download email for the past** setting. For more information, see [Only a subset of your Exchange mailbox items are synchronized in Outlook](/outlook/troubleshoot/user-interface/only-subset-items-synchronized).

## Synchronize the folders again

After you check the offline folder settings, use one of the following methods to synchronize the folders again.

### Manual synchronization

1. Select the folder that you want to synchronize.
1. On the Outlook ribbon, select **Send/Receive**, and then select **Update Folder** to synchronize one offline folder, or select **Send/Receive All Folders** to synchronize all offline folders.

When the synchronization procedure starts, you'll see a synchronization status message in the lower-right part of the screen. If you have many items in the mailbox, and you haven't synchronized the offline folders for a while, the synchronization procedure might take more than 30 minutes.

### Automatic synchronization

To synchronize all offline folders automatically every time that you're online and every time that you exit Outlook, follow these steps:

1. On the **File** tab, select **Options**.
1. In the **Outlook Options** dialog box, select **Advanced**.
1. In the **Send and receive** section, select the **Send immediately when connected** check box.
1. Select **Send/Receive**.
1. In the **Send/Receive Groups** dialog box, make sure that the **Perform an automatic send/receive when exiting** check box is selected, and then select **Close**.
1. select **OK**.

## Create an .ost file

If all the folders except the Inbox folder are synchronized, or if you're not able to synchronize the folders, you might have a damaged .ost file. To fix the issue, create a new .ost file. Follow the steps in [How to rebuild the OST file](/outlook/troubleshoot/synchronization/synchronization-issue-between-outlook-owa#how-to-rebuild-the-ost-file). Then, synchronize the offline folders again.

## Replace a damaged Exchange Server support file

If you're still not able to restore offline folder synchronization, the Microsoft Exchange Server service support file might be damaged. To replace the damaged service support file, you must either remove or rename the file, and then replace the removed or renamed file with the original service support file.

### Remove or rename the Exchange Server service support file

Follow these steps:

1. Open File Explorer.
1. Locate *C:\Program Files(x86)\Microsoft Office\root\Office16* or *C:\Program Files\Microsoft Office\root\Office16*.

    > [!NOTE]
    > The folder path to the *EMSMDB32.dll* file will vary, depending on the version and bit-value of the Office product installed.

1. Right-click the *EMSMDB32.dll* file, select **Rename**, and then add the `.old` filename extension. For example, *EMSMDB32.dll.old*.

### Replace the Exchange Server service support file

To replace the support file that you renamed in the original media, follow these steps:

1. Right-click **Start**, and select **Apps and Features** on the pop-up menu.
1. Select the Microsoft Office product that you want to repair, and then select **Modify**.
1. Depending on whether your copy of Office is a Click-to-run-based or .msi-based installation, you'll see the following options to proceed with the repair. Follow the steps for your installation type.

    |Click-to-run|MSI|
    |-|-|
    |In the **How would you like to repair your Office Programs** window, select **Online Repair** > **Repair** to make sure that everything gets fixed. (The **Quick Repair** option is faster, but it only replaces corrupted files.)|In the **Change your installation** window, select **Repair**, and then select **Continue**.|

1. Synchronize the offline folders.

For more information, see [Repair an Office application](https://support.microsoft.com/office/7821d4b6-7c1d-4205-aa0e-a6b40c5bb88b).
