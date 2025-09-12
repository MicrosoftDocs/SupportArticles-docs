---
title: The Read status of email messages isn't updated
description: Describes a known issue in Microsoft 365 in which the Read status of email messages may not be updated between Exchange ActiveSync on a user's mobile device and the user's mailbox in Exchange Online.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administrator Tasks
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: chrisbur, v-six
appliesto: 
- Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# The Read status of email messages may not be updated between Exchange ActiveSync

_Original KB number:_ &nbsp; 2804607

## Problem

The Read status of email messages may not be updated between Exchange ActiveSync on a user's mobile device and the user's Microsoft Exchange Online mailbox in Microsoft 365.

## Workaround

To work around this issue, re-create the user mailbox. To do this, follow these steps:

### Step 1: Prepare to replace the existing mailbox

Export the contents of the existing mailbox to a .pst file for backup. To do this, follow these steps:

1. Ask the user to make sure that any items that were created on mobile devices or other mail clients are synchronized to the mailbox.
2. Export the whole contents of the mailbox to a .pst file for backup.

    > [!NOTE]
    > This may require some time for larger mailboxes. The time that is required varies based on mailbox size, network conditions, and local computer performance.

3. In Microsoft Outlook, on the **File** menu, select **Account Settings**, and then select the **Data Files** tab. Select the backup .pst file, and then select **Remove**.
4. Exit all Outlook clients that access the user's mailbox.

### Step 2: Rename the existing mailbox

> [!IMPORTANT]
> These steps will not work if directory synchronization is enabled.

To rename the existing mailbox, follow these steps:

1. Sign in to the Microsoft 365 portal ([https://portal.office.com](https://portal.office.com)) as an administrator.
2. In the header, select **Admin**, and then, under **Management** in the left navigation pane, select **Users**.
3. In the list of users, select the user whose mailbox you want to re-create, and then select **Details**. In this example, the user name is *John Smith*.
4. In the **Display name** box, change the display name of the user, and then click **Save**. For example, change *John Smith* to *John Smith2*.

    > [!NOTE]
    > Changing the user name in the portal also changes all other values for the user except the proxy email addresses.

5. Select **More**, and then select **Change mailbox settings**.
6. Expand **E-Mail Options**.
7. In the **Other e-mail addresses** box, delete or change the other email addresses as needed, and then select **Save**.
8. Select **Save** again to return to the Users page.

### Step 3: Create a new mailbox

Create a new user account. This new user account replaces the existing user account. To do this, follow these steps:

1. In the header, select **Admin**, and then, under **Management** in the left navigation pane, select **Users**.
2. On the Users page of the Office 3365 portal, select **New**, select **User**, and then follow the instructions to create a new user account.

    For example, create a new user account that's named *John Smith*. This is considered a new user account because the original user account that was named *John Smith* was renamed to *John Smith2* in step 2.

    > [!NOTE]
    > You may receive an "A user with this name already exists. Use a different name" error message. If you do receive this error message, you have to wait for the changes that were made to the original account to replicate throughout the service before you can create the new user account. Also, make sure that the proxy addresses are updated, because you may receive this error message if there's a conflict with a proxy address.

### Step 4: Assign permissions to the new mailbox

To assign permissions to the new mailbox, follow these steps:

1. Connect to Exchange Online by using remote PowerShell. For more information about how to do this, see [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

2. Assign the user Full Access permissions to the new mailbox. For example, to assign *John Smith* **Full Access** permissions to the *John Smith2* mailbox, run the following command.

    ```powershell
    Add-MailboxPermission -Identity "John Smith 2" -User "John Smith" -AccessRights FullAccess -InheritanceType All
    ```

### Step 5: Copy the contents of the original mailbox to the new mailbox

To copy the contents of the original mailbox to the new mailbox, follow these steps:

1. Create a new Outlook profile that opens the new mailbox by using an Exchange (MAPI) account.
2. Start Outlook, and then open the new mailbox.
3. Add the original mailbox as an IMAP email account to the profile.

    For example, add the *John Smith 2* mailbox as an IMAP email account to the profile.
4. When Outlook is open and both mailboxes can be accessed, select all the messages in the Inbox folder of the IMAP account, and copy them to the Inbox folder of the Exchange (MAPI) account.

    > [!NOTE]
    > This action causes a MIME-to-MAPI conversion to occur. This should fix most item-level corruption of the messages.

5. Repeat step 4 for each folder in the mailbox.
6. When you finish copying all folders to Exchange (MAPI) account, remove the IMAP account from the profile.
7. In the same profile, open the original mailbox that was renamed in step 2 as an Exchange mailbox, and then drag the Calendar, Contact, Notes, and any other non-mail items from the original mailbox to the new mailbox.

    For example, open the *John Smith 2* mailbox, and then drag non-mail items from the *John Smith 2* mailbox to the *John Smith* mailbox.

> [!IMPORTANT]
> Any recurring meeting request in the original mailbox *could* potentially become orphaned if it leaves the Exchange store and if it's copied or moved to a .pst file. If the user has many meeting requests in Calendar, the user may want to test the process by using some meetings and then confirm that the meetings can be updated correctly before continuing. If the links to the original meeting request are orphaned, an update from the organizer will create a new item in the recipient's calendar. However, the original item remains at the original date and time.

## Status

This is a known issue. Microsoft is currently investigating the issue and will post more information in this article when it becomes available.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
