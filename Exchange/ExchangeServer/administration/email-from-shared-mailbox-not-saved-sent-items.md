---
title: Emails aren't saved in the Sent Items folder
description: Describes an issue in which email messages that are sent in Outlook for Mac aren't saved in the Sent Items folder as expected. Provides a resolution for this issue.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: djball, tasitae, djball, nasira, v-six
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Enterprise
  - Exchange Server 2010 Standard
  - Exchange Server 2007
  - Outlook 2016 for Mac
  - Outlook for Microsoft 365 for Mac
ms.date: 01/24/2024
---
# Email messages that you send from a shared mailbox aren't saved in the Sent Items folder in Outlook for Mac

_Original KB number:_ &nbsp; 2928846

## Symptoms

Consider the following scenario:

- You have a primary mailbox that has Full Access and Send As permissions to a shared mailbox.

- You configure Microsoft Outlook 2016 for Mac or Outlook for Mac 2011 to open a primary mailbox that is hosted on Microsoft Exchange Server 2013, Exchange Server 2010, or Exchange Server 2007.

- In the same Outlook profile or identity, you open a secondary shared mailbox that is hosted on Exchange Server 2013, Exchange Server 2010, or Exchange Server 2007.

- You use the credentials of the primary mailbox to access the shared mailbox.

- You send email messages from the shared mailbox.

In this scenario, email messages that you send from the shared mailbox are not saved in the Sent Items folder of the shared mailbox. Instead, the messages are saved in the Drafts folder of the primary mailbox on the Exchange Server. Additionally, the messages in the primary mailbox's Drafts folder are not synchronized to the Outlook for Mac client, and they are visible only when you use Outlook Web Access or a Windows Outlook client.

## Cause

This issue occurs because the Exchange Web Services `GetMessageParentFolderIdAndSession` function incorrectly uses the `SendAndSaveCopy` method.

## Resolution

This issue was resolved in [Cumulative Update 5 for Exchange Server 2013](https://support.microsoft.com/help/2936880).

After you install this cumulative update, the messages will be saved in the **Sent Items** folder of the Shared mailbox.

## Workarounds for Exchange Server 2010 and 2007

If you run Exchange Server 2010 or Exchange Server 2007, the following workarounds are applicable.

### Workaround 1

1. In Outlook for Mac, click **Tools** > **Accounts**.

    > [!NOTE]
    > If you have the shared account added here, select it and then click the minus sign (-) to remove it. Click **Delete** to confirm.

1. Click **Advanced**, and then click **Delegates**.
1. In the **Open these additional mailboxes** section, click the plus sign (+).

    > [!NOTE]
    > You don't have to be a delegate for the shared account in order to add it here, you only need permissions to access this mailbox.

1. Enter the alias of the Shared Account, and then click **Find**. Select the correct account, and then click **OK**.
1. Click **OK**, and then close the Accounts window.
1. Allow for time for the shared account to appear in the folder list in Outlook for Mac 2011. Now, when an email is sent from the Shared mailbox, the message will be saved in the **Sent Items** folder of the Primary mailbox.

If you prefer the messages to be saved in both the Primary and Shared mailbox **Sent Items** folders and you are running Exchange Server 2010 Service Pack 2 (SP2) RU4 or a later version, you can run one of the following Windows PowerShell commands depending on whether you use the Send As or Send On Behalf permission.

- Send As

    ```powershell
    Set-MailboxSentItemsConfiguration <SharedAccountAlias> -SendAsItemsCopiedTo SenderAndFrom
    ```

- Send On Behalf

    ```powershell
    Set-MailboxSentItemsConfiguration <SharedAccountAlias> -SendOnBehalfOfItemsCopiedTo SenderAndFrom
    ```

### Workaround 2

1. In Outlook for Mac, click **Tools** > **Accounts**.
2. Select the shared account, and then click the minus sign **(-)** to remove it. Click **Delete** to confirm.
3. Close the Accounts window.
4. Click **File**, click **Open**, and then click **Other User's Folder**.
5. Enter the name of the shared mailbox, select **Inbox** as the folder type, and then click **OK**.

> [!NOTE]
> When you use this method, only the **Inbox** folder of the shared mailbox is available. If you must have access to other folders, use the [workaround 1](#workaround-1).
