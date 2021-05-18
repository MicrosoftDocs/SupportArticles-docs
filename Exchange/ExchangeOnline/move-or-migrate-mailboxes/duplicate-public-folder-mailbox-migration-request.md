---
title: Duplicate public folder mailbox migration request
description: Fixes an issue in which you can't remove a failed public folder mailbox migration request because it's duplicate or orphaned.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm 
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Online
- CI 149097
- CSSTroubleshoot
ms.reviewer: haembab
appliesto:
- Exchange Online 
search.appverid: MET150
---
# "DestinationADNotUpToDatePermanentException" error in a public folder mailbox migration request

## Symptoms

In a public folder migration batch, you see a public folder mailbox migration request fails with the "DestinationADNotUpToDatePermanentException" failure type.

:::image type="content" source="media/duplicate-public-folder-mailbox-migration-request/pf-migration-job-error.png" alt-text="Screenshot of the detailed failures.":::

When you remove the failed public folder mailbox migration request, you receive the following error message:

> Couldn't find a unique request with the provided information.

## Cause

This issue occurs if the public folder mailbox migration request is either duplicate or orphaned.

## Resolution

To resolve this issue, identify and remove the duplicate or orphaned public folder mailbox migration requests by running the [script](https://techcommunity.microsoft.com/t5/exchange-team-blog/giving-you-more-control-over-public-folder-migration-requests/ba-p/608924) or by following these steps:

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
1. Identify duplicate public folder mailbox migration requests by running the following cmdlet:

    ```powershell
    Get-PublicFolderMailboxMigrationRequest|Sort-Object targetmailbox|fl targetmailbox,requestguid,name,status
    ```

    **Note:** For more information about the cmdlet, see [Get-PublicFolderMailboxMigrationRequest](/powershell/module/exchange/get-publicfoldermailboxmigrationrequest).

    Here's an example of the output:

    :::image type="content" source="media/duplicate-public-folder-mailbox-migration-request/duplicate-migration-requests.png" alt-text="Screenshot of duplicate migration requests.":::

1. Remove the failed public folder mailbox migration request by running the following cmdlet:

    ```powershell
    Remove-PublicFolderMailboxMigrationRequest -Identity "<RequestGuid>" -Force
    ```

    **Note:** Replace \<RequestGuid> with the actual result that you get from the cmdlet in the step 2. For more information about the cmdlet, see [Remove-PublicFolderMailboxMigrationRequest](/powershell/module/exchange/remove-publicfoldermailboxmigrationrequest).

## Why do we use the RequestGuid parameter to remove duplicate or orphaned jobs?

Both healthy and duplicate jobs have the same name that consists of the target mailbox GUID. The formatting of the name is *PublicFolderMailboxMigration\<TargetMailboxGuid>*, such as *PublicFolderMailboxMigration058553ac-200f-4fba-91c4-300e4fa0e8e5*. Both healthy and duplicate jobs points to the same target mailbox, and their identities are same.

However, the completion of a migration batch isn't related to duplicate jobs because the batch don't consider duplicate jobs as part of the migration. Only those jobs that have corresponding active migration users are considered as part of a migration. Both an active migration user and a migration request are connected through the `RequestGuid` parameter. So duplicate jobs don't have corresponding active migration users which are part of a migration.

In this case, it's best to remove the duplicate or orphaned jobs by using the `RequestGuid` parameter.

Here's an example that can help you illustrate this point. In the output of the [Get-PublicFolderMailboxMigrationRequest](/powershell/module/exchange/get-publicfoldermailboxmigrationrequest) cmdlet (as shown in the screenshot 1), you can view the status of individual jobs in a public folder migration batch, and you can see duplicate jobs that point to the same target mailboxes as the healthy jobs. In the output of the [Get-MigrationUser](/powershell/module/exchange/get-migrationuser) cmdlet (as shown in the screenshot 2), you can see the information of migration users, but you don't see any failed status for the target mailboxes which the duplicate jobs point to.

**Screenshot 1:**

:::image type="content" source="media/duplicate-public-folder-mailbox-migration-request/duplicate-jobs.png" alt-text="Screenshot of duplicate migration jobs.":::

**Screenshot 2:**

:::image type="content" source="media/duplicate-public-folder-mailbox-migration-request/migration-users.png" alt-text="Screenshot of migration user status.":::
