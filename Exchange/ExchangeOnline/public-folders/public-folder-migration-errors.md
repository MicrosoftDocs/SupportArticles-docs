---
title: Errors during a public folder migration
description: Fix errors when you roll back a public folder migration or create a migration endpoint. The errors occur due to the orphaned public folder mailboxes.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 160145
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: haembab, batre
appliesto: 
  - Exchange Online
search.appverid: MET150
---
# Errors during a public folder migration

## Symptoms

In a public folder migration, you may experience one of the following issues:

- **Unable to remove a primary public folder mailbox**

    When you try to [roll back a public folder migration](/exchange/collaboration/public-folders/roll-back-exchange-online-migration), you're stuck in the step of removing the primary public folder mailbox. Additionally, you receive one of the following error messages:

    > The operation couldn't be performed because 'Mailbox1' matches multiple entries.

    > The mailbox "Mailbox1" is the primary public folder mailbox for the users. To remove this mailbox, first remove all other public folder mailboxes.

- **Unable to create a public folder migration endpoint**

    When you try to create a public folder migration endpoint, you receive the following error message:

    > An item with the same key has already been added.

## Cause

These issues occur if either the primary public folder mailbox or the secondary public folder mailbox has an orphaned object.

## Resolution

To resolve this issue, find and remove all existing orphaned public folder mailboxes by following these steps:

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
2. Find orphaned public folder mailboxes by running the following cmdlets:

    ```powershell
    Get-Mailbox –PublicFolder | fl Name,Identity,ExchangeGuid,Guid
    Get-Mailbox -PublicFolder -SoftDeletedMailbox | fl Name,Identity,ExchangeGuid,Guid
    ```

    If the cmdlets don't report any orphaned public folder mailboxes, you can run the following cmdlet:

    ```powershell
    Get-Recipient -RecipientTypeDetails PublicFolderMailbox -IncludeSoftDeletedRecipients | fl Name,Identity,ExchangeGuid,Guid
    ```

    Here's an example of the output:

     :::image type="content" source="media/public-folder-migration-errors/command-output.png" alt-text="Screenshot of the command output in which ExchangeGuid is highlighted.":::

3. Remove an individual orphaned public folder mailbox by running the following cmdlet:

    ```powershell
    Remove-Mailbox -PublicFolder -RemoveCNFPublicFolderMailboxPermanently <ExchangeGuid> 
    ```

    **Note:** Replace \<ExchangeGuid> with the value that you get from the cmdlet output in step 2 for mailbox objects that have the CNF value in **Name** and **Identity**.

    If the cmdlet in the step 2 reports multiple orphaned public folder mailboxes, you can also find and remove them in a batch by running the following cmdlet:

    ```powershell
    $soft= Get-Recipient -RecipientTypeDetails PublicFolderMailbox –IncludeSoftDeletedRecipients ; foreach ($mbx in $soft){if ($mbx.Name -like "*CNF:*" -or $mbx.identity -like "*CNF:*") {Remove-Mailbox -PublicFolder $mbx.ExchangeGUID.GUID -RemoveCNFPublicFolderMailboxPermanently}}
    ```
