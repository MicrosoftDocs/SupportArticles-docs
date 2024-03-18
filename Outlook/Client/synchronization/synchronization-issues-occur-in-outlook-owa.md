---
title: Synchronization problems in Outlook and OWA
description: The synchronization issues could result from a corrupted .ost file. Discusses methods to troubleshoot this issue.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CSSTroubleshoot
appliesto:
- Outlook 2019
- Outlook 2016
- Office 2016
- Outlook 2013
- Microsoft Office Outlook 2007
- Microsoft Office Outlook 2003
search.appverid: MET150
ms.reviewer: aruiz, rakeshs, v-six
author: cloud-writer
ms.author: meerak
ms.date: 01/30/2024
---
# Synchronization problems occur in Outlook and in Outlook Web App

## Symptoms

When synchronization issues occur in Microsoft Outlook or in Microsoft Outlook Web App (formerly Outlook Web Access), you may experience the following symptoms.

- Symptom 1

  You see differences or mismatches between the messages that you receive in Microsoft Outlook compared to Microsoft Outlook Web App.

- Symptom 2

  You have an issue with Outlook, but the issue does not occur when cached mode is disabled.

- Symptom 3

  Occasionally you receive an error message when you synchronize your Offline Folder file (.ost) in Outlook with your mailbox on a server that is running Microsoft Exchange Server. The error message may resemble the following:

  > Cannot start Microsoft Outlook. Cannot open the Outlook window. The set of folders cannot be opened. The file c:\Users\\\<username>\AppData\Local\Microsoft\Outlook\<username@domain.com.ost> is not an Outlook data file (ost).

- Symptom 4

  You notice that some items such as email messages, appointments, contacts, tasks, journal entries, notes, posted items, and documents are missing from your .ost file or from your mailbox after you synchronize your .ost file and your mailbox.

## Cause

When these symptoms occur, or you have other problems synchronizing, the problem might be a corrupted .ost file.

## Resolution

For Outlook 2003 and Outlook 2007:

Use the OST Integrity Check Tool (Scanost.exe) to check your .ost file for inconsistencies.

For Outlook 2010 and later versions:

The OST Integrity Check Tool (scanost.exe) is not included in Outlook 2010 and later versions. This tool was recommended in earlier versions to fix errors in Outlook data files (.ost). If there is an issue with a specific folder, you can resync the folder in Outlook. To do this, follow these steps:

1. Right-click the folder, and then select **Properties**.
2. Select **Clear Offline Items**, and then select **OK**.
3. On the Outlook 2010 ribbon, select the **Send/Receive** tab.
4. Select **Update Folder**.

If these methods do not resolve the issue, we recommend that you rebuild the .ost file. To do this, delete the .ost file, and then let Outlook download the information again from Exchange Server. For more information, see the More information section of this article.

However, the exception is if you have local data that is not present on the server. In that case, we recommend that you follow these steps:

1. Export the data to an Outlook Data File (.pst), and then delete the .ost file.
2. Let the server data download again, and then import the .pst file data by using the **Do not import duplicates** option. To access this option, select the **File** tab, and then select the **Open** option.

## More information

The OST Integrity Check Tool runs only on .ost files and can be used to diagnose and repair synchronization issues. It scans your local copy of the .ost file and your mailbox on an Exchange Server. The tool compares items and folders in the file and in your mailbox and tries to reconcile synchronization differences between the files and the mailbox. The OST Integrity Check Tool does not change your mailbox on the Exchange Server. The tool records any differences in a scan log so that you can see what differences the tool found and resolved. The scan log also identifies any situations that the tool could not resolve and that you must fix manually. The scan log is in your Deleted Items folder.

The OST Integrity Check Tool (Scanost.exe) is installed when you install Outlook in the following locations, as appropriate for the Outlook version that you are running.

For Outlook 2003: **drive**:\Program Files\Common Files\System\MSMAPI\\**LocaleID** folder. Be aware that in this example, **LocaleID** is the locale identifier (LCID) for the installation of Microsoft Office. The LCID for English - United States is 1033.

For Outlook 2007: **drive**:\Program Files\Microsoft Office\OFFICE12

### How to repair errors by using Scanost.exe

1. Exit Outlook 2003 or Outlook 2007 if it is running.
2. Double-click **Scanost.exe**.
3. If you have set up Outlook to prompt you for a profile, the tool also prompts you for a profile. In the **Profile Name** list, select the profile that contains the .ost file that you want to check. If you are prompted to **Connect** or to **Work Offline**, select **Connect**.

4. Select the options that you want. To have the tool automatically resolve differences that it finds during the scan, select the **Repair Errors** check box. If this check box is cleared, the tool logs the problems. However, the tool does not make the necessary corrections.

5. Select **Begin Scan**.

> [!NOTE]
> To view the scan log, start Outlook, and then open the Deleted Items folder. The tool does not scan the Deleted Items folder. Any problems are noted in a message that has "OST Integrity Check" as its Subject.

If you have problems when you try to open your .ost file, you can use the Inbox Repair tool (Scanpst.exe) to diagnose and repair errors in your .ost file. The Inbox Repair tool can be used on both .ost files and on Personal Folders (.pst) files. The Inbox Repair tool scans the .ost or .pst file and makes sure that the file structure is intact. The tool also tries to repair the internal data structures, if it is necessary. The tool does not interact with your mailbox on the Exchange Server.

### How to rebuild the .ost file

1. Locate the following folder, as appropriate for the operating system that you are running:

    Windows XP: C:\Documents and Settings\\\<alias>\Local Settings\Application Data\Microsoft\Outlook  
    Windows Vista and later versions: C:\Users\\\<alias>\AppData\Local\Microsoft\Outlook

2. If the folder is not displayed, unhide the folder. To do this, follow these steps:

    Windows 8 and Windows 10:

    On the **View** tab, select the **Hidden items** check box, and the **File name extensions** check box.

    Windows 7:

    - On the **Organize** menu, select **Folder and search** options.
    - Select the **View** tab, and then select the **Show hidden files, folders, and drives** option, and then clear the **Hide extensions for known file types** check box.

    Windows XP:

    - On the **Tools** menu, select **Folder Options**.
    - Select the **View** tab, and then select the **Show hidden files and folders** check box, and then clear the **Hide extensions for known file types** check box.

3. By default, Outlook creates an Outlook.ost for the user's local cache. If an Outlook.ost file already exists, Outlook inserts a number at the end of the file name (for example, Outlook0.ost or Outlook1.ost). Rename any .ost files. To do this, rename the .ost file name extension to `.old`. If the .ost file name extensions are not displayed, make sure that you clear the **Hide extensions for known file types** check box as described in steps 2A and 2B.

4. If you receive a "File is in use" error message, press CTRL+ALT+DELETE, and then select **Task Manager**. Select the **Processes** tab, and verify that Outlook.exe and Winword.exe are not displayed in the list of processes. If these processes appear in the list, select each file, and then select **End Process**.

5. After you rename the .ost file, restart Outlook. You receive a "Preparing for first use" message. Wait for the mailbox to synchronize. This process varies, depending on the user's mailbox size.

6. After the mailbox is synchronized, test to see whether the issue still occurs. If it still occurs, the .ost file is not the cause of the issue.

For a similar error caused by a different issue, refer to [Outlook shows Disconnected in status bar if the last character in legacyExchangeDN is a space](/outlook/troubleshoot/connectivity/outlook-displays-disconnected-in-status).
