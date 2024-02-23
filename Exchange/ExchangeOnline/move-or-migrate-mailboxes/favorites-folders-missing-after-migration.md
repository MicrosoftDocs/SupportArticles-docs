---
title: Favorites folders are missing in the Outlook client after migration to Exchange Online
description: Works around an issue in which Favorites folders are missing in the Outlook client after migration to Exchange Online.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom:
  - Exchange Online
  - CSSTroubleshoot
  - CI 175574
ms.reviewer: likhitk, batre, meerak, v-trisshores
appliesto:
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---

# Favorites folders are missing in the Outlook client after migration to Exchange Online

## Symptoms

Consider the following scenario:

- You migrate an on-premises user mailbox to Microsoft Exchange Online.

- After migration, the mailbox user creates a new Microsoft Outlook profile.

In that scenario, folders that were listed as Favorites prior to migration are no longer listed as Favorites in the Outlook client.

Outlook on the web isn't affected by this issue.

## Cause

Each Favorites folder has a `MailboxDN` field value within the `PR_WLINK_STORE_ENTRYID` property value that associates the folder with the mailbox. Prior to mailbox migration, the `MailboxDN` field value reflects the `LegacyExchangeDN` property value of the on-premises mailbox.

When the mailbox is migrated to the cloud, Exchange Online applies a new `LegacyExchangeDN` value to the cloud mailbox. However, Exchange Online doesn't update the `MailboxDN` field value of each Favorites folder to the new `LegacyExchangeDN` value. If the mailbox user continues to use their existing Outlook profile after migration, the Favorites folders appear as usual in the Outlook client. However, if the user creates and uses a new Outlook profile, the mismatch between the `MailboxDN` value of each folder and the `LegacyExchangeDN` value of the Exchange Online mailbox causes the Favorites folders to not appear in the Outlook client.

## Workaround

To work around this issue, mailbox users can use either of the following workarounds.

### Workaround 1 (recommended)

Manually [re-add folders to Favorites](https://support.microsoft.com/office/add-or-remove-folders-in-favorites-8913f2d0-b167-48cc-8983-86fa9b0d945f) in the Outlook client.

### Workaround 2

Use the [MFCMAPI](https://github.com/stephenegriffin/mfcmapi/releases) tool to manually update the `MailboxDN` value of each folder that should be added to Favorites.

Follow these steps:

1. Run the following command to connect to Exchange Online PowerShell:

   ```powershell
   Connect-ExchangeOnline
   ```

2. Run the following command to find the `LegacyExchangeDN` value of the Exchange Online mailbox:

   ```powershell
   Get-Mailbox <mailbox SMTP address> | FL LegacyExchangeDN
   ```

3. Determine whether your Outlook installation is a [32-bit or 64-bit](https://support.microsoft.com/office/what-version-of-outlook-do-i-have-b3a9568c-edb5-42b9-9825-d48d82b2257c) version by checking **File** \> **Office account** \> **About Outlook**.

4. Download and extract the latest 32-bit or 64-bit [MFCMAPI](https://github.com/stephenegriffin/mfcmapi/releases) release to match your Outlook installation.

   > [!IMPORTANT]
   > Although the MFCMAPI editor is supported, you should use caution when you use this tool to change mailboxes. Using the MFCMAPI editor incorrectly can cause permanent damage to a mailbox.

5. Make sure that Outlook is closed, and then run MFCMapi.exe. If the MFCMAPI startup screen appears, close it.

6. Select **Session** \> **Logon** to open the **Choose Profile** window.

7. Select the Outlook profile for the user's mailbox, and then select **OK**.

8. Double-click the mailbox SMTP address in the **Display Name** column to open the **Root Mailbox** window for the mailbox.

9. In the left pane, select **Root Mailbox** \> **Common Views**.

10. In the right-pane, double-click **PR_FOLDER_ASSOCIATED_CONTENTS** to open the **Associated contents** table.

11. For each folder that doesn't appear in the Favorites list, perform the following steps:

    1. Double-click the folder name in the **PR_SUBJECT** column to open the **Properties** window for the folder.

    2. Double-click the **PR_WLINK_STORE_ENTRYID** entry in the **Name** column to open the **Property Editor** window.

    3. In the **Smart View** section, select the **EntryID** \> **MAPI Message Store Entry ID** \> **MailboxDN** field. The field value corresponds to the `LegacyExchangeDN` value of the on-premises mailbox prior to migration.

    4. In the **Text** section, update the **MailboxDN value** to match the current `LegacyExchangeDN` value of the mailbox that you obtained in Step 2.

12. Close all MFCMAPI windows to exit the application.

13. Start Outlook and verify that the Favorites folder collection that you had prior to migration is restored.
