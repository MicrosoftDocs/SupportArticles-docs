---
title: Folder names are incorrect or displayed in an incorrect language in Outlook
description: Fixes an issue in which folder names are displayed in an incorrect language or folder functionality is incorrect in Outlook.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook 2010
  - Microsoft Office Outlook 2007
  - Exchange Online
  - Microsoft Exchange Online Dedicated
ms.date: 3/31/2022
---

# Folder names are incorrect or displayed in an incorrect language in Outlook

## Symptoms

You experience the following issues that affect folder names in Microsoft Outlook:

- Folder names appear in a language other than the default language.

    > [!NOTE]
    > This issue occurs if a mobile device or a third-party server application synchronizes the Exchange Server mailbox. To resolve this issue, try Method 1 first. If that doesn't work, try Method 2 or 3.
- Folder names are changed unexpectedly (for example, the **Inbox** folder and the **Outbox** folder are switched).

    > [!NOTE]
    > This issue may occur after Exchange Server mailbox maintenance. To resolve this issue, try Method 1 first. If that doesn't work, try Method 2 or 3.

    Or, the default **Inbox** folder is changed unexpectedly to **Archive** in Exchange Online. To resolve this issue, try Method 4.
- Folder names are no longer correct after you run the `Outlook.exe /ResetFolderNames` command to reset the default folder names.

    > [!NOTE]
    > To resolve this issue, try Method 2 or 3.

For more information about how to run outlook.exe with the command-line switches, see [Command-line switches for Outlook for Windows](https://support.microsoft.com/office/command-line-switches-for-microsoft-office-products-079164cd-4ef5-4178-b235-441737deb3a6#ID0EAABAAA=Outlook).  

To fix the issues, use one or more of the following methods.

## Method 1

Use the **/resetfolders** switch to restore missing folders at the default delivery location. To do this, follow these steps:

1. Exit Outlook.
2. Run `Outlook.exe /resetfolders`.
3. Run `Outlook.exe /resetfoldernames`.

## Method 2

Use Outlook Web App to reset the default folder names:

1. Exit Outlook.
2. Log on to [Outlook Web App](https://support.office.com/article/Sign-in-to-Outlook-Web-App-e08eb8ac-ac27-49f4-a400-a47311e1ee7e) by using your credentials.
3. Select **Settings** (the gear icon on the right) > **Options** > **General** (expand the list in the navigation pane) > **Language and time**.
4. On the **Language and time** page, change the language, select the date and time format that you want to use, select the **Rename default folders so their names match the specified language** option, and then select **Save**.
5. Exit Outlook Web App.

    > [!NOTE]
    > If your preferred language is already selected, you may have to select any other language, save the setting, reset the setting to your preferred language, and then save the setting again.
6. Restart Outlook.

## Method 3

If you're an administrator, run the following cmdlet to reset the default folder names for the user:  

```powershell
set-MailboxRegionalConfiguration -id <alias> -LocalizeDefaultFolderName:$true -Language <Language_code_to_switch_to> -DateFormat <your_preferred_DateFormat>
```

For more information about the **Set-MailboxRegionalConfiguration** cmdlet, see [Set-MailboxRegionalConfiguration](https://msdn.microsoft.com/subscriptions/dd351103%28v=exchg.141%29.aspx).

## Method 4

### Option 1 (preferred)

Use Outlook to select a new Archive folder. To do this, follow these steps:  

1. Right-click the mailbox name at the top of the folder hierarchy in Outlook, select **New Folder**, and then create a folder that's named **Archive01**.
2. On the **File** menu, select **Tools** > **Set Archive Folder**, and then select the new Archive01 folder.
3. Run `Outlook.exe /resetfoldernames`.

If this option isn't available or doesn't work, use Option 2.

### Option 2

Follow these steps:  

1. Right-click the mailbox name at the top of the folder hierarchy in Outlook, select **New Folder**, and then create a folder that's named **Archive01**.
2. Create a backup of the existing items in the old archive folder. 
3. Start MFCMapi in Online mode. To make sure that MFCMapi is in Online mode, select **Tools** > **Options**, and then make sure that the **Use the MDB_ONLINE flag** and **Use the MAPI_NO_CACHE** check boxes are selected.
4. Expand **Root Container**, and then expand **Top of Information Store** (if the user has the mailbox set to a language other than English, then the name of this folder will be translated).
5. Select the new Archive01 folder, and then find the property that's named **PR_ENTRYID**.  
6. Double-click to open the **PR_ENTRYID** property, and then copy the property binary value.
7. Close the property editor for Archive01 and select Inbox.
8. Arrange the entries based on the Tag column and search for the **0x35FF0102** property tag. Double-click on this property.
9. Paste the binary value of the Entry ID of the Archive01 folder that you copied in step 6 in the binary value box for the property 0x35FF0102.
10. Run `Outlook.exe /resetfolders`.
11. Run `Outlook.exe /resetfoldernames`.
12. Import data to the new archive folder from the backup，or move the items to the new folder.
13. Delete the old archive folder, as the **Archive01** folder is now the default archive folder.
