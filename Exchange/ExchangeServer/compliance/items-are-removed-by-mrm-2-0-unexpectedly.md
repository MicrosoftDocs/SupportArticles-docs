---
title: Items are removed by MRM 2.0 unexpectedly
description: Discusses that items that you do not want removed are removed by MRM 2.0 in Microsoft Exchange Server. Provides a resolution.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: dpaul, v-six
appliesto: 
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2010 Service Pack 3
search.appverid: MET150
---
# Items that you want to retain are removed by MRM 2.0 in Exchange Server

_Original KB number:_ &nbsp; 3036736

## Symptoms

A recently applied MRM 2.0 policy removes items that you do not want removed in Exchange Server. After this problem occurs, you want to restore the missing items as quickly as possible by using a method that has a minimal effect on users.

## Cause

This problem occurs because an incorrect Retention Policy Tag (RPT) was applied to the policy. This incorrect tag removes items that you did not intend to have removed.

## Resolution - Method 1: Restore from a backup

Restore the database from a backup, and then merge the saved data with the current data. All saved messages are restored to the location from which they were backed up. For more information about this process, see the Recovery database section of the [Backup, restore, and disaster recovery](/exchange/backup-restore-and-disaster-recovery-exchange-2013-help).

## Resolution - Method 2: Run an export request on the user's dumpster

Run an export request on the user's dumpster to recover only the items from the RPT that are causing the problem. To do this, follow these steps.

> [!IMPORTANT]
> This method works only if the value of the retention action is not **Permanently Delete**. If the value is set as **Permanently Delete**, you must use Method 1.

1. Follow the prerequisites of the article [Create a Mailbox Export Request](/previous-versions/office/exchange-server-2010/ff459227(v=exchg.141)).

    > [!NOTE]
    > Make sure that you sign in as a user who has the Mailbox Import Export role group added to your role-based access control (RBAC) permissions.

2. Locate the retention policy that is applied to the mailbox.
3. Determine which tag removed the messages from the mailbox. To do this, follow these steps.

    > [!NOTE]
    > The problem might be caused by multiple RPTs that are assigned to default folders or by a Default Policy Tag (DPT). You must determine which in this policy does not work as you expect.

   1. Select the RPT that is applied to the affected mailbox. To do this, run the following command:

        ```powershell
        Get-Mailbox <Alias> | Select RetentionPolicy
        ```

        > [!NOTE]
        > In this command, \<Alias> represents the actual mailbox alias.

   2. Get the Tags for the RPT. To do this, run the following command:

        ```powershell
        Get-RetentionPolicy <Retention Policy Name> | Select RetentionPolicyTagLinks
        ```

        > [!NOTE]
        > In this command, \<Retention Policy Name> represents the actual name retention policy name.

   3. Determine the correct tags, then obtain the RetentionID. To do this, run the following command:

        ```powershell
        Get-RetentionPolicyTag "Retention Tag Name" | Select RetentionId
        ```

        > [!NOTE]
        > In this command, \<Retention Tag Name> represents the actual name tag name.

4. Export the items that match the criteria that is determined in step 3. To do this, run the following cmdlet, depending on whether you have a single tag or multiple tags.
   - Single retention tag

        ```powershell
        New-MailboxExportRequest -Mailbox "Alias" -IncludeFolders:Dumpster -ContentFilter {(policytag -eq "RetentionID" ) -and (messagekind -eq 'email')} -FilePath \\Server\Recovery\Alias.pst
        ```

   - Multiple retention tags

        ```powershell
        New-MailboxExportRequest -Mailbox "Alias" -IncludeFolders:Dumpster -ContentFilter {((policytag -eq "RetentionID") -or (policytag -eq "RetentionID")) -and (messagekind -eq 'email')} -FilePath \\Server\Recovery\Alias.pst
        ```

5. To restore the user data that was removed, either have the user manually add their personal items folder (.pst) to the mailbox, or run the following import request command to have the items imported.

    ```powershell
    New-MailboxImportRequest -Mailbox "Alias" -FilePath \\Server\Recovery\Alias.pst -TargetRootFolder "Recovery"
    ```

    > [!IMPORTANT]
    >
    > - You should change or remove the policy before you import items. This is because if you have the same RPTs applied to the mailbox that you are trying to restore data to, the messages are removed again by MRM 2.0 after the Exchange Mailbox Assistants service reprocesses the mailbox.
    > - You must provide a Target Root Folder value. Otherwise, the items will be restored to the dumpster again. Although you can use the Inbox folder, this will restore the items to the Recoverable Items\Deletions subfolder under Inbox.
