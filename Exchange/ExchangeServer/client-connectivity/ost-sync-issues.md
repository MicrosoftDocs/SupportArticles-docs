---
title: Sync issues with an OST file 
description: Provides guidance for issues when you synchronize an Exchange Server mailbox with an offline Outlook data file.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.reviewer: 
ms.custom: 
- Exchange Server
- CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Outlook 2019
- Outlook 2016
- Outlook 2013
- Outlook for Microsoft 365
---
# Issues when you synchronize your Exchange Server mailbox with your OST file in Outlook

_Original KB number:_ &nbsp; 842284

When you try to synchronize a Microsoft Exchange Server mailbox with an offline Outlook Data File (.ost), the synchronization might fail, and you may experience any of the following issues:

- Folders in Microsoft Outlook not being updated
- Email messages available in Outlook on the web (OWA), but not in Outlook
- Different email count in Outlook and OWA
- New email messages not downloaded

These issues occur if either the OST file or the Exchange Server support file is damaged. This article provides guidance to troubleshoot and resolve these issues.

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

    :::image type="content" source="media/ost-sync-issues/synchronization-status.png" alt-text="Screenshot of the synchronization status":::

If synchronization is working correctly, the number of items in the **Server folder contains** field and in the **Offline folder contains** field will be the same.

> [!NOTE]
> The item count for the offline folder depends on the **Mail to keep offline** or the **Download email for the past** setting. For more information, see [Only a subset of your Exchange mailbox items are synchronized in Outlook](/outlook/troubleshoot/user-interface/only-subset-items-synchronized).

## Synchronize the folders again

After you check the offline folder settings, use one of the following methods to synchronize the folders again.

### Manual synchronization

1. Select the folder that you want to synchronize.
1. On the Outlook ribbon, select **Send/Receive**, and then select **Update Folder** to synchronize one offline folder, or select **Send/Receive All Folders** to synchronize all offline folders.

When the synchronization procedure starts, you will see a synchronization status message in the lower-right part of the screen. If you have many items in the mailbox and you haven't synchronized the offline folders for a while, the synchronization procedure may take more than 30 minutes.

### Automatic synchronization

To synchronize all offline folders automatically every time that you are online and every time that you exit Outlook, follow these steps:

1. On the **File** tab, select **Options**.
1. In the **Outlook Options** dialog box, select **Advanced**.
1. In the **Send and receive** section, select the **Send immediately when connected** check box.
1. Select **Send/Receive**.
1. In the **Send/Receive Groups** dialog box, make sure that the **Perform an automatic send/receive when exiting** check box is selected, and then select **Close**.
1. select **OK**.

### Create a new OST file

If all the folders except the Inbox folder are synchronized, or if you're not able to synchronize the folders, you may have a damaged OST file. To fix the issue, create a new OST file. Follow the steps in [How to rebuild the OST file](/outlook/troubleshoot/synchronization/synchronization-issue-between-outlook-owa#how-to-rebuild-the-ost-file). Then, synchronize the offline folders again.

## Replace a damaged Exchange Server support file

If you're still not able to restore offline folder synchronization, the Microsoft Exchange Server service support file may be damaged. To replace the damaged service support file, you must either remove or rename the file, and then replace the removed or renamed file with the original service support file.

### Remove/rename the Exchange Server service support file

Follow these steps:

1. Open File Explorer.
1. Locate *C:\Program Files(x86)\Microsoft Office\root\OFFICE16* or *C:\Program Files\Microsoft Office\root\OFFICE16*.

    > [!NOTE]
    > The folder path to the Emsmdb32.dll file will change depending on the version and bit-value of the Office product installed.

1. Right-click the *Emsmdb32.dll* file, select Rename and add the `.old` filename extension. For example, *Emsmdb32.dll.old*.

### Replace the Exchange Server service support file

To replace the support file that you renamed in the original media, follow these steps:

1. Right-click the Start button, and select **Apps and Features** on the pop-up menu.
1. Select the Microsoft Office product you want to repair, and select **Modify**.
1. Depending if your copy of Office is Click-to-run or MSI-based install, you'll see the following options to proceed with the repair. Follow the steps for your installation type.

    |Click-to-run|MSI-based|
    |-|-|
    |In the window **How would you like to repair your Office Programs**, select **Online Repair** > **Repair** to make sure everything gets fixed. (The faster **Quick Repair** option is also available, but it only detects and then replaces corrupted files.)|In **Change your installation**, select **Repair**, and then click **Continue**.|

1. Synchronize the offline folders.
