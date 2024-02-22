---
title: Folder names or locations are incorrect in Outlook
description: Fixes an issue in which folder names or locations are displayed incorrectly or folder functionality is incorrect in Outlook.
author: cloud-writer
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - Outlook for Windows
  - CSSTroubleshoot
  - CI 160888
appliesto: 
  - Outlook 2019
  - Outlook 2016
  - Outlook 2013
  - Outlook 2010
  - Exchange Online
ms.date: 10/30/2023
---

# Issues with default folders in Outlook

You experience any of the following issues that affect default folders in Microsoft Outlook:

- Folder names appear in a language other than the default language.

    This issue occurs if a mobile device or a third-party server application synchronizes with the Microsoft Exchange Server mailbox. To resolve this issue, try Method 1. If that doesn't work, try Method 2 or Method 3.

- Folder names are switched. For example, the **Inbox** and **Outbox** folder names are switched.  

  This issue might occur after a maintenance cycle is run for the Exchange Server mailbox. To resolve this issue, try Method 2 or Method 3.

- Folder names become incorrect after you run the `Outlook.exe /ResetFolderNames` command to reset the default folder names.

  To resolve this issue, try Method 2 or Method 3.

- The default **Inbox** folder is renamed to **Archive** in Exchange Online.

  To resolve this issue, try Method 4.

- The **Junk Email** folder is moved under another default folder, such as **Journal** or **Deleted Items**.

  To resolve this issue, try Method 5.

## Method 1: Restore default folder names by using the /resetfolders switch

1. Exit Outlook.
2. Run `Outlook.exe /resetfolders`.
3. Run `Outlook.exe /resetfoldernames`.

## Method 2: Reset default folder names by using Outlook on the web

**Note:** The following steps apply to the latest version of Outlook on the web.

1. Exit Outlook.
2. Log on to Outlook on the web by using your credentials.
3. Select **Settings** (:::image type="icon" source="media/incorrect-folder-names/settings-icon.png":::) > **View all Outlook settings**.
4. Select **General** > **Language and time**.
5. In the **Language** list, change the language to your preferred language, and then select the **Rename default folders so their names match the specified language** checkbox.

    :::image type="content" source="media/incorrect-folder-names/owa-settings.png" alt-text="Screenshot of the OWA Settings page in which you have to change the language and date and time format.":::

6. Select the date and time format that you want to use, and then select **Save**.
7. Exit Outlook on the web.

    > [!NOTE]
    > If your preferred language is already selected, select a different language, save the setting, revert the setting to your preferred language, and then save the setting again.

8. Restart Outlook, and then check whether the folder names appear in the default language.

## Method 3: Reset default folder names by using the Set-MailboxRegionalConfiguration cmdlet

You must have administrator permission to run the [Set-MailboxRegionalConfiguration](/powershell/module/exchange/set-mailboxregionalconfiguration) cmdlet.

1. Open an elevated Command Prompt window.
1. Run the following cmdlet:

    ```powershell
    set-MailboxRegionalConfiguration -id <alias> -LocalizeDefaultFolderName:$true -Language <Language_code_to_switch_to> -DateFormat <your_preferred_DateFormat>
    ```

## Method 4: Create a new Archive folder

### Option 1 (preferred)

1. Right-click the mailbox name at the top of the folder hierarchy in Outlook, select **New Folder**, and then create a folder that's named *Archive01*.
2. On the **File** menu, select **Tools** > **Set Archive Folder**, and then select the *Archive01* folder.
3. Run `Outlook.exe /resetfoldernames`.

If this option isn't available or doesn't work, use Option 2.

### Option 2

1. Right-click the mailbox name at the top of the folder hierarchy in Outlook, select **New Folder**, and then create a folder that's named *Archive01*.
1. Create a backup of the existing items in the current archive folder.
1. Download and install the latest version of [MFCMAPI](https://github.com/stephenegriffin/mfcmapi/releases).

    **Notes:**

    - Download MFCMAPI according to your Office installation. If you have 32-bit Office, download MFCMAPI.exe. If you have 64-bit Office, download MFCMAPI.x64.exe.  
    - To determine which version of Office you are running, see [About Office: What version of Office am I using?](https://support.microsoft.com/office/about-office-what-version-of-office-am-i-using-932788b8-a3ce-44bf-bb09-e334518b8b19)

1. Start MFCMAPI, and then select **Tools** > **Options**.
1. Make sure that the **MDB_ONLINE** and **MAPI_NO_CACHE** checkboxes are selected, and then select **OK**.
1. Select **Session** > **Logon**, and then select the mailbox.  
1. Expand **Root Container**, and then expand **Top of Information Store**.

   **Note:** If the user mailbox is set to a language other than English, the name of this folder will be in the default language.

1. Select the new *Archive01* folder, and then find the **PR_ENTRYID** property.  
1. Double-click to open the **PR_ENTRYID** property, and then copy the binary value of the property.
1. Close the property editor for *Archive01*, and select **Inbox**.
1. Sort the entries by the **Tag** column, locate the **0x35FF0102** property tag, and then double-click this property tag.
1. Paste the binary value of the **PR_ENTRYID** property of the *Archive01* folder that you copied in step 8 into the binary value box for the 0x35FF0102 property tag.
1. Run `Outlook.exe /resetfolders`.
1. Run `Outlook.exe /resetfoldernames`.
1. Import data to the new archive folder from the backup, or move the items to the new folder.
1. Delete the old archive folder (because the *Archive01* folder is now the default archive folder).

## Method 5: Restore the location of the Junk Email folder by using MFCMAPI

You can use the MFCMAPI tool to bring the **Junk Email** folder back under the **Top of Information Store**, or at the same level as the other default mailbox folders.

1. Download and install the latest version of [MFCMAPI](https://github.com/stephenegriffin/mfcmapi/releases).

    **Notes:**

    - Download MFCMAPI according to your Office installation. If you have 32-bit Office, download MFCMAPI.exe. If you have 64-bit Office, download MFCMAPI.x64.exe.  
    - To determine which version of Office you are running, see [About Office: What version of Office am I using?](https://support.microsoft.com/office/about-office-what-version-of-office-am-i-using-932788b8-a3ce-44bf-bb09-e334518b8b19)

1. Right-click the name of your account in Outlook, select **New Folder**, and then create a folder that's named, for example, *New Junk*. This will create a new Junk email folder at the same level as the **Inbox** folder.
1. Close all Outlook clients to make sure that only MFCMAPI can access the mailbox.
1. Start MFCMAPI, and then select **Tools** > **Options**.
1. Make sure that the **MDB_ONLINE** and **MAPI_NO_CACHE** checkboxes are selected, and then select **OK**.
1. Select **Session** > **Logon** to select the Outlook profile of the affected mailbox.
1. Double-click the name of the affected mailbox, and then expand **Root Container**.
1. Expand **Top of Information Store**.  

    **Note:** If the mailbox is set to a language other than English, the name of this folder will be in the default language.

1. Select the **Inbox** folder, and then locate the **PR_ADDITIONAL_REN_ENTRYIDS** property that has the **0x36D81102** tag.

    **Note:** This property holds the IDs of several default folders, including the **Junk Email** folder.

    Here's an example of the **PR_ADDITIONAL_REN_ENTRYIDS** property.

    :::image type="content" source="media/incorrect-folder-names/mfcmapi-property.png" alt-text="Screenshot of the MFCMAPI page in which the PR_ADDITIONAL_REN_ENTRYIDS property is highlighted.":::

1. Right-click the property, and then select **Delete**.
1. Close MFCMAPI.
1. Run `Outlook.exe /ResetFolderNames`.
1. Restart Outlook.
