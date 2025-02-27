---
title: Cannot update calendar items from OWA or Outlook on Mac
description: When a mailbox is on hold and the Versions folder is full, you can't update calendar items from OWA or Outlook. Provides a resolution.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Litigation Hold
  - CSSTroubleshoot
ms.reviewer: gapart, munatara
appliesto: 
  - Exchange Online Archiving
search.appverid: MET150
ms.date: 06/24/2024
---
# Couldn't update the following event error when editing calendar items from OWA or Outlook

_Original KB number:_ &nbsp; 4459263

## Symptoms

Consider the following scenario:

- A user has a mailbox in Microsoft 365.
- In-place hold or litigation hold is enabled for the mailbox.
- The user tries to edit calendar items from Microsoft Outlook Web App (OWA) or Microsoft Outlook.

In this scenario, the user receives the following error message:

> Couldn't update the following event:  
> \<EventName>

:::image type="content" source="media/cannot-update-calendar-items-from-owa-or-outlook-on-mac/error-message.png" alt-text="Screenshot of the error message, showing Couldn't update the following event.":::

## Cause

This issue occurs because the Versions folder (that is part of the Recoverable Items folder) is full.

> [!NOTE]
> To check the Recoverable Items folder statistics, run the following command:  
> `Get-MailboxFolderStatistics -Identity cloudtest -FolderScope recoverableitems | ft name,*size*`

## Resolution

Because the user's mailbox is on hold, the items in the Versions folder are very important. To resolve this issue, you have to enable the archive mailbox for the affected user, and then move all items of the Versions folder to the archive mailbox. To do this, follow these steps:

1. Enable the archive mailbox. To do this, run `Enable-Mailbox -IdentityUserName-Archive`.
2. Turn on the auto-expanding archiving feature. To do this, run `Enable-Mailbox <UserMailbox> -AutoExpandingArchive`.

    > [!NOTE]
    >
    > - Enabling the auto-expanding archiving for the mailbox increases the storage quota for the Recoverable Items folder in the user's primary mailbox by 10 GB (from 100 GB to 110 GB). Also, this step increases the archive mailbox size to **unlimited**.
    > - A user's archive mailbox must be enabled before you can enable auto-expanding archiving. A user must be assigned an Exchange Online Plan 2 license to enable the archive mailbox. If a user is assigned an Exchange Online Plan 1 license, you have to assign to them a separate Exchange Online Archiving license to enable their archive mailbox.

3. Create a custom retention policy for mailboxes on hold, and then move the items from the Versions folder to the archive mailbox. To do this, follow the steps that are mentioned in the **Step 1: Create a custom retention tag for the Recoverable Items folder** section of the following Docs article:

   [Increase the Recoverable Items quota for mailboxes on hold](/microsoft-365/compliance/increase-the-recoverable-quota-for-mailboxes-on-hold?redirectSourcePath=%252fen-us%252farticle%252fincrease-the-recoverable-items-quota-for-mailboxes-on-hold-a8bdcbdd-9298-462f-b889-df26037a990c&view=o365-worldwide#step-1-create-a-custom-retention-tag-for-the-recoverable-items-folder&preserve-view=true)

## More information

When a user's mailbox is on in-place hold or litigation hold, original items and changed items are copied to the Versions folder. If the Versions folder is full, the changed copy of the original items can't be stored in the folder. Therefore, the user can't save changes to the original items.

For information about issues that might prevent retention policies from deleting email messages, see [Resolve email archive and deletion issues when using retention policies](/microsoft-365/troubleshoot/retention/troubleshoot-mrm-email-archive-deletion).
