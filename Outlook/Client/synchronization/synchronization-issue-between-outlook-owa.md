---
title: Synchronization issues between Outlook and Outlook Web App
description: Describes synchronization problems that occur in Outlook 2013 and Outlook 2010. The cause might be a corrupted OST file. Troubleshooting steps are provided.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
ms.reviewer: tasitae
appliesto: 
  - Outlook 2013
  - Microsoft Outlook 2010
search.appverid: MET150
ms.date: 10/30/2023
---
# Synchronization issues between Outlook and Outlook Web App

_Original KB number:_ &nbsp;3077398

## Symptoms

When synchronization issues occur in Microsoft Outlook 2013 or Outlook 2010, you may experience one or more of the following symptoms.

- Symptom 1

    You see differences or mismatches between the messages that you receive in Outlook compared to those that you receive in Outlook Web App (OWA).

- Symptom 2

    You experience an issue in Outlook, but that issue doesn't occur when cached mode is disabled.

- Symptom 3

    You occasionally receive error messages when you synchronize your Offline Folder OST file (.ost) in Outlook with your mailbox on a server that's running Exchange Server.

- Symptom 4

    You notice that some items such as email messages, appointments, contacts, tasks, journal entries, and notes are missing from your OST file or from your mailbox after you synchronize your OST file and your mailbox.

## Cause

The reason for these symptoms and other problems in synchronizing might be a corrupted OST file.

## Resolution

If there's an issue with a specific folder, you can resynchronize the folder in Outlook 2013 or Outlook 2010. Follow these steps:

1. Right-click the folder, and then click **Properties**.
1. Click **Clear Offline Items** > **OK**.
1. On the Outlook ribbon, click the **Send/Receive** tab.
1. Click **Update Folder**.

If this method doesn't resolve the issue, we recommend that you rebuild the OST file. That is, delete the OST file, and then let Outlook create a new OST file and download the information again from Exchange Server. To do this, follow these steps.

### How to rebuild the OST file

1. Locate the following folder in Windows 8, Windows 7, or Windows Vista:

    *C:\Users\ \<username>\AppData\Local\Microsoft\Outlook*

1. If the folder isn't displayed, unhide the folder:

    - On the **View** menu, click **Options**.
    - Click the **View**  tab, select the **Show hidden files and folders** check box, and then clear the **Hide extensions for known file types** check box. Click **OK**.

1. Rename any OST files by changing the OST file extension to .old. If the OST file name extensions aren't displayed, make sure that you clear the **Hide extensions for known file types** check box, as described in step 2.

    > [!NOTE]
    > If you receive a **File is in use** error message, press Ctrl+Alt+Delete, and then click **Task Manager**. Click the **Processes**  tab, and verify that Outlook.exe and Winword.exe aren't displayed in the list of processes. If these processes appear in the list, select each file, and then click **End Process**.

1. After you rename the OST file, start Outlook. You'll receive a **Preparing for first use** message. Wait for the mailbox to synchronize. The time that this process takes will vary, depending on the size of the mailbox.
1. After the mailbox is synchronized, test to see whether the issue still occurs. If it still occurs, the OST file isn't the cause of the issue.

> [!IMPORTANT]
> There's an exception to this conclusion: when you have local data that's not present on the server. In that situation, we recommend that you follow these steps:
>
> 1. Export the data to an Outlook Data File (.pst), and then delete the OST file.
> 1. Let the server data download again, and then import the .pst file data by using the **Do not import duplicates** option. To access this option, click **File**, and then click the **Open & Export** option in Outlook 2013 or the **Open** option in Outlook 2010.

Did this fix the problem?

- Check whether the problem is fixed. If the problem isn't fixed, [contact support](https://support.microsoft.com/contactus/).
