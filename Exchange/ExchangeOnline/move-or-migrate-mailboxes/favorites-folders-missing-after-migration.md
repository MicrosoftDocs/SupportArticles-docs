---
title: Favorites Folders Are Missing in the Outlook Client After Migration to Exchange Online
description: Works around an issue in which Favorites folders are missing in the Outlook client after migration to Exchange Online.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Migration
  - Exchange Online
  - CSSTroubleshoot
  - CI 175574, 6015
ms.reviewer: likhitk, sujnai, batre, meerak, v-trisshores
appliesto:
  - Exchange Online
search.appverid: MET150
ms.date: 05/28/2025
---

# Favorites folders are missing in the Outlook client after migration to Exchange Online

## Symptoms

Consider the following scenario:

- You migrate an on-premises user mailbox to Microsoft Exchange Online.

- After migration, the mailbox user creates a new Microsoft Outlook profile.

In that scenario, folders that were listed as Favorites prior to migration are no longer listed as Favorites in the Outlook client.

Outlook on the web doesn't have this issue.

## Cause

Each Favorites folder has a `MailboxDN` field value within the `PR_WLINK_STORE_ENTRYID` property value that associates the folder with the mailbox. Prior to mailbox migration, the `MailboxDN` field value reflects the `LegacyExchangeDN` property value of the on-premises mailbox.

When the mailbox is migrated to the cloud, Exchange Online applies a new `LegacyExchangeDN` value to the cloud mailbox. However, Exchange Online doesn't update the `MailboxDN` field value of each Favorites folder to the new `LegacyExchangeDN` value. If the mailbox user continues to use their existing Outlook profile after migration, the Favorites folders appear as usual in the Outlook client. However, if the user creates and uses a new Outlook profile, the mismatch between the `MailboxDN` value of each folder and the `LegacyExchangeDN` value of the Exchange Online mailbox causes the Favorites folders to not appear in the Outlook client.

## Workaround

To work around this issue, mailbox users can use either of the following workarounds.

### Workaround 1 (recommended)

Manually [re-add folders to Favorites](https://support.microsoft.com/office/add-or-remove-folders-in-favorites-8913f2d0-b167-48cc-8983-86fa9b0d945f) in the Outlook client.

### Workaround 2

Use the [MFCMAPI](https://github.com/stephenegriffin/mfcmapi/releases) tool to manually update the `MailboxDN` value of each folder that should appear in the Favorites list.

> [!IMPORTANT]
> Although the MFCMAPI editor is supported, you should use caution when you use this tool to change mailboxes. Using the MFCMAPI editor incorrectly can cause permanent damage to a mailbox.

Follow these steps in the user's new profile:

1. Note the name of a Favorites folder that is visible. If none are visible, add a folder to Favorites to create a visible folder.

2. Note the names of all Favorites folders that don't appear in the Favorites list.

3. [Open the associated contents table in MFCMAPI](#open-the-associated-contents-table-in-mfcmapi).

4. For the Favorites folder that does appear in the Favorites list:
   
   1. [Open the PR_WLINK_STORE_ENTRYID editor for the folder](#open-the-pr_wlink_store_entryid-editor-for-a-folder).
   
   2. Copy the hexadecimal value from the **Binary** section of the editor.

   3. Select **Cancel** to close the editor, and then close the Properties window for the folder.

5. For each Favorites folder that doesn't appear in the Favorites list, perform the following steps:

   1. [Open the PR_WLINK_STORE_ENTRYID editor for the folder](#open-the-pr_wlink_store_entryid-editor-for-a-folder).

   2. Replace the entire hexadecimal value in the **Binary** section of the editor with the hexadecimal value that you copied in Step 4.

   3. Select **OK** to save the value and close the editor, and then close the Properties window for the folder.

6. Close all MFCMAPI windows to exit the application.

7. Start Outlook and verify that the Favorites folder collection that you had prior to migration is restored.

#### Common MFCMAPI procedures

##### Open the associated contents table in MFCMAPI

1. If you don't already have MFCMAPI installed, follow these steps:

   1. Determine whether your Outlook installation is a [32-bit or 64-bit](https://support.microsoft.com/office/what-version-of-outlook-do-i-have-b3a9568c-edb5-42b9-9825-d48d82b2257c) version by checking **File** \> **Office account** \> **About Outlook**.

   2. Download and extract the latest 32-bit or 64-bit [MFCMAPI](https://github.com/stephenegriffin/mfcmapi/releases) release to match your Outlook installation.

3. Make sure that Outlook is closed, and then run MFCMapi.exe. If the MFCMAPI startup screen appears, close it.

4. Select **Session** \> **Logon** to open the **Choose Profile** window.

5. Select the new profile for the user's mailbox, and then select **OK**.

6. Double-click the mailbox SMTP address in the **Display Name** column to open the **Root Mailbox** window for the mailbox.

7. In the left pane, select **Root Mailbox** \> **Common Views** to open the applicable right-pane view.

8. In the right-pane, double-click **PR_FOLDER_ASSOCIATED_CONTENTS** to open the **Associated contents** table.

##### Open the PR_WLINK_STORE_ENTRYID editor for a folder

1. In the **Associated contents** table, locate the name of the folder in the **PR_SUBJECT** column.

2. Double-click the folder's name to open its **Properties** window.

3. In the **Properties** window, double-click the **PR_WLINK_STORE_ENTRYID** entry in the **Name** column. This will open the **Property Editor** window for the folder.
