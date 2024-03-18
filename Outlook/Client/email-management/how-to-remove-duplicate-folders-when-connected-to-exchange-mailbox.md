---
title: How to remove duplicate folders when connected to Exchange mailbox
description: Provides a resolution to remove duplicate folders in Outlook when connected to an Exchange Server mailbox.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto:
- Outlook
- Exchange
search.appverid: MET150
ms.reviewer: meshel, benjak, aruiz, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/30/2024
---
# How to remove duplicate folders in Outlook when connected to an Exchange Server mailbox

## Symptoms

In Microsoft Outlook, you see duplicate folders in your Microsoft Exchange Server mailbox when you view the Outlook folder list, or when you view the folder list by using Outlook Web App (OWA).

## Cause

A mobile device or a third-party server application that synchronizes with the Exchange Server mailbox may unexpectedly introduce the duplication. Or, the unexpected duplication may be the result of Exchange Server mailbox maintenance or of other changes that are performed on the computer that is running Exchange Server. Other factors could also contribute to the issue described in the Symptoms section of this article.

## Resolution

The following steps may result in data loss if you do not follow them exactly as written. We recommend that you back up Outlook data or make sure that the Exchange Server mailbox has been backed up before you proceed with these steps.

To delete the duplicate items, follow these steps:

1. Exit Outlook and close OWA on all workstations that are connected to the user mailbox.

2. Use MFCMapi to identify the duplicate folders. To do this, follow these steps:

    1. Download [MFCMAPI](https://github.com/stephenegriffin/mfcmapi) (scroll down and then select **Latest release**).
    2. Run MFCMAPI.exe.
    3. Select the **Tools** menu, then select **Options**.
    4. Enable the following option:
       - Use MDB_ONLINE when calling OpenMsgStore
    5. Select **OK**.
    6. On the **Session** menu, select **Logon**.
    7. If you are prompted for a profile, select your profile name, and then select **OK**.
    8. In the top pane, locate the line that corresponds to your mailbox, and double-click it.  
    9. In the navigation pane (left-side pane), expand **Root Container**, and then expand **Top of Information Store**.
    10. To identify the duplicate folder, select one of the duplicate folders on the left pane. In the right pane, locate the **Value** column for the `PR_CREATION_TIME` property. Compare this value to the duplicate folder with the same name. The duplicate folder will have a newer creation date and time. Work with one pair of folders at a time (for example, start with the two Calendar folders that appear).

3. Use MFCMAPI to copy any items from the duplicate folder to the original folder. These are items created after the duplicate folders were created. This can include email that was received in the Inbox, Contacts that were created, Calendar appointments that you scheduled and meetings that you accepted.

    1. In the left pane of MFCMAPI, double-click on the duplicate folder, which has the newer creation date and time.
    2. On the window that opens, select the top pane, then press CTRL+A to select all items.

       If no items appear in the top pane, the folder is already empty; skip to step 7.

    3. Select the **Actions** menu, then select the **Copy Messages** command.
    4. Close the folder window, then double-click on the original folder, which has the older creation date and time.
    5. Select the **Actions** menu, then select the **Paste Messages** command.
    6. Enable the **MESSAGE_MOVE** checkbox, then select **OK**.
    7. Close the folder window.

4. In MFCMAPI, switch back to the duplicate folder, which is now empty. Use MFCMAPI to delete it.

    1. Right-click the duplicate folder, and then select **Delete Folder**.
    2. Enable the **Hard Deletion** option, and then select **OK**.

5. Repeat steps 2 through 4 for other common Outlook folders (Contacts, Deleted Items, Drafts, Inbox, Journal, Junk E-mail, Notes, Sent Items, and Tasks).
6. Close MFCMAPI.
7. Start Outlook with the `resetfolders` switch:

    1. Open the **Run** dialog box. To do this, use one of the following procedures, as appropriate for your version of Windows.

       **Windows 10, Windows 8.1 and Windows 8:** Press Windows Key+R.  
       **Windows 7 and Windows Vista:** Select the **Start** button, point to **All Programs**, select **Accessories**, and then select **Run**.  
       **Windows XP:** Select the Windows **Start** button, and then select **Run**.

    2. In the **Run** dialog box, type the following, and then select **OK** :

       _Outlook.exe /resetfolders_

## More information

For more information about command-line switches in Outlook, see [Command-line switches for Microsoft Office products](https://support.microsoft.com/office/command-line-switches-for-microsoft-office-products-079164cd-4ef5-4178-b235-441737deb3a6?ocmsassetid=hp001218589&ctt=1&correlationid=2d283ed6-cf6f-4d1b-a807-09046452228c)
