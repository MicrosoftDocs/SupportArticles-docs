---
title: Duplicate public folder mailbox migration request
description: Fixes an issue in which you can't remove a failed public folder mailbox migration request because it's orphaned or a duplicate.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CI 149097
  - CSSTroubleshoot
ms.reviewer: haembab
editor: v-jesits
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# "DestinationADNotUpToDatePermanentException" error in a public folder mailbox migration request

## Symptoms

In a public folder migration batch, you see a failed public folder mailbox migration request that has the "DestinationADNotUpToDatePermanentException" failure type.

:::image type="content" source="media/duplicate-public-folder-mailbox-migration-request/pf-migration-job-error.png" alt-text="Screenshot of the detailed failures.":::

When you try to remove the failed public folder mailbox migration request, you receive the following error message:

> Couldn't find a unique request with the provided information.

## Cause

This issue occurs if the public folder mailbox migration request is either orphaned or a duplicate.

## Resolution

To resolve this issue, identify and remove the orphaned or duplicate public folder mailbox migration requests by running [this script](https://techcommunity.microsoft.com/t5/exchange-team-blog/giving-you-more-control-over-public-folder-migration-requests/ba-p/608924). If the script doesn't work, follow these steps:

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
1. Identify duplicate public folder mailbox migration requests by running the following cmdlet:

    ```powershell
    Get-PublicFolderMailboxMigrationRequest|Sort-Object targetmailbox|ft targetmailbox,requestguid,name,status
    ```

    **Note:** For more information about this cmdlet, see [Get-PublicFolderMailboxMigrationRequest](/powershell/module/exchange/get-publicfoldermailboxmigrationrequest).

    Here's an example of the output:

    :::image type="content" source="media/duplicate-public-folder-mailbox-migration-request/duplicate-migration-requests.png" alt-text="Screenshot of duplicate migration requests.":::

1. Remove the failed public folder mailbox migration request by running the following cmdlet:

    ```powershell
    Remove-PublicFolderMailboxMigrationRequest -Identity "<RequestGuid>" -Force
    ```

    **Note:** Replace \<RequestGuid> with the actual result that you get from the cmdlet in the step 2. For more information about the cmdlet, see [Remove-PublicFolderMailboxMigrationRequest](/powershell/module/exchange/remove-publicfoldermailboxmigrationrequest).

## More information

Both healthy and duplicate jobs have the same name that contains the target mailbox GUID. The formatting of the name is *PublicFolderMailboxMigration\<TargetMailboxGuid>*. For example, *PublicFolderMailboxMigration058553ac-200f-4fba-91c4-300e4fa0e8e5*. Both healthy and duplicate jobs point to the same target mailbox, and their identities are the same.

However, completing a migration batch isn't related to duplicate jobs because the batch doesn't consider duplicate jobs to be part of the migration. Only those jobs that have corresponding active migration users are considered to belong to a migration. Both an active migration user and a migration request are connected through the `RequestGuid` parameter. Therefore, duplicate jobs don't have corresponding active migration users that are part of a migration.

In this case, it's best to remove the orpahned or duplicate jobs by using the `RequestGuid` parameter.

Here's an example to illustrate this point. In the output of the [Get-PublicFolderMailboxMigrationRequest](/powershell/module/exchange/get-publicfoldermailboxmigrationrequest) cmdlet (as shown in the screenshot 1), you view the status of individual jobs in a public folder migration batch, and you see duplicate jobs that point to the same target mailboxes as the healthy jobs. In the output of the [Get-MigrationUser](/powershell/module/exchange/get-migrationuser) cmdlet (as shown in the screenshot 2), you see the information of migration users, but you don't see any failed status for the target mailboxes that the duplicate jobs point to.

**Screenshot 1:**

:::image type="content" source="media/duplicate-public-folder-mailbox-migration-request/duplicate-jobs.png" alt-text="Screenshot of duplicate migration jobs.":::

**Screenshot 2:**

:::image type="content" source="media/duplicate-public-folder-mailbox-migration-request/migration-users.png" alt-text="Screenshot of migration user status.":::
