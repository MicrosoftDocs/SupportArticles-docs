---
title: Email messages are stuck in Outbox in Outlook 2016 for Mac
description: Provide workarounds for the issue that Email messages are stuck in Outbox in Outlook 2016 for Mac.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Connectivity\Cannot send or receive new email
  - Outlook for Mac
  - CSSTroubleshoot
ms.reviewer: monish
appliesto: 
  - Outlook 2016 for Mac
search.appverid: MET150
ms.date: 01/30/2024
---
# Email messages are stuck in Outbox in Outlook 2016 for Mac

_Original KB number:_ &nbsp;4484206

## Symptoms

When you try to send email messages in Outlook 2016 for Mac, the email messages remain stuck in the **Outbox** folder, and you receive the following error message:

> Unexpected data was encountered.

## Cause

This issue occurs because Outlook 2016 for Mac can't locate and use the **Sent Items** folder. The folder hierarchy in the mailbox may have become corrupted.

For example, in some cases, the **Sent Items** folder is converted into the **Archive** folder, and the icons that mark the two folders are incorrect. See the following screenshots:

| **A working account**| **A non-working account** |
|---|---|
|:::image type="content" source="./media/email-stuck-in-outbox-outlook-2016-mac/correct-folders.png" alt-text="Screenshot of correct Sent and Archive folders in a working account." border="false":::|:::image type="content" source="./media/email-stuck-in-outbox-outlook-2016-mac/incorrect-folders.png" alt-text="Screenshot of incorrect Sent and Archive folders in a non-working account." border="false":::|

## Resolution

To resolve this issue, reset or rename the Outlook folders by using Outlook for Windows.

### Method 1: Use the /resetfolders switch

Use the **/resetfolders** switch to restore the missing folders at the default delivery location. To do this, follow these steps:

1. Exit Outlook.
2. Open the **Run** dialog box:
   - In Windows 10, Windows 8.1, and Windows 8, press Windows logo key +R.
   - In Windows 7 and Windows Vista, select **Start** > **All Programs** > **Accessories** > **Run**.
3. In the **Run** dialog box, enter the following command, and then click **OK**:

    ```console
    Outlook.exe /resetfolders
    ```

### Method 2: Use Outlook Web App

Use Outlook Web App to reset the default folder names. To do this, follow these steps:

1. Exit Outlook.
2. Sign in to [Outlook Web App](https://support.office.com/article/Sign-in-to-Outlook-Web-App-e08eb8ac-ac27-49f4-a400-a47311e1ee7e) by using your credentials.
3. Select **Settings** (the gear icon on the right) > **Options** > **General** (expand the list in the navigation pane) > **Region and time zone**.
4. On the **Regional and time zone settings** page, change the language, select the date and time format that you want to use, select the **Rename default folders so their names match the specified language** option, and then select **Save**.
5. Exit Outlook Web App.
    > [!NOTE]
    > If your preferred language is already selected, you may have to select any other language, save the setting, reset the setting to your preferred language, and then save the setting again.
6. Restart Outlook.

### Method 3: Use the Set-MailboxRegionalConfiguration cmdlet

If you're an administrator, run the following cmdlet to reset the default folder names for the user:

```powershell
set-MailboxRegionalConfiguration -id <alias> -LocalizeDefaultFolderName:$true -Language <Language_code_to_switch_to> -DateFormat <your_preferred_DateFormat>
```

For more information about language codes and the `Set-MailboxRegionalConfiguration` cmdlet, see the following websites:

[Language codes](https://msdn.microsoft.com/library/ms533052%28v=vs.85%29.aspx)

[Set-MailboxRegionalConfiguration](https://msdn.microsoft.com/subscriptions/dd351103%28v=exchg.141%29.aspx)

### Method 4: Use Outlook to select a new Archive folder

To do this, follow these steps:

1. Download and install [MFCMAPI](https://github.com/stephenegriffin/mfcmapi/releases/tag/17.0.17099.01).
    > [!NOTE]
    > The x86-based version of MFCMAPI should be used with the x86-based version of Office, and the x64-based version of MFCMAPI should be used with the x64-based version of Office.
2. Right-click the mailbox name at the top of the folder hierarchy in Outlook, select **New Folder**, and then create a folder that's named **Archive01**.
3. Start MFCMAPI in Online mode. To make sure that MFCMAPI is in Online mode, select **Tools** > **Options**, and then make sure that the **Use the MDB_ONLINE flag** and **Use the MAPI_NO_CACHE** check boxes are selected.
4. Expand **Root Container** > **Top of Information Store**.
5. Copy the default input ID from the Inbox folder (the renamed **Archive** folder in this case). To do this, click the **Archive** folder, select the **InternalSchema.ArchiveFolderEntryId (0x35ffXXXX)** tag, right-click this tag, select **Open Entry ID**, and then copy the whole ID.
6. Select the **Archive01** folder that you created, and then examine the item. The following details are displayed:
   - Tag: 0x0FFF0102
   - Type: PT_BINARY
   - Name (s) of property: PR_ENTRYID, PR_MEMBER_ENTRYID, PidTagEntryId, PidTagMemberEntryId, ptagEntryId
   - DASL: `http://schemas.microsoft.com/mapi/proptag/0x0FFF0102`
7. Delete the input ID, and then paste the ID that you copied in step 5.
8. Close MFCMAPI.
9. Run `Outlook.exe /resetfolders`.
10. Run `Outlook.exe /resetfoldernames`.

For more information, see [Folder names are incorrect or displayed in an incorrect language in Outlook](https://support.microsoft.com/help/2826855/folder-names-are-incorrect-or-displayed-in-an-incorrect-language-in-ou).

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-information-disclaimer.md)]
