---
title: Errors during a public folder migration
description: Fix errors that occur because of orphaned public folder mailboxes when you roll back a public folder migration or create a migration endpoint.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Groups, Lists, Contacts, Public Folders
  - CI 160145
  - CI 161474
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: haembab, batre
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Errors during a public folder migration

## Symptoms

During a public folder migration, you experience one of the following issues:

- **Can't remove a primary public folder mailbox**

    When you try to [roll back a public folder migration](/exchange/collaboration/public-folders/roll-back-exchange-online-migration), you become stuck in the step to remove the primary public folder mailbox. Additionally, you receive one of the following error messages:

    > The operation couldn't be performed because 'Mailbox1' matches multiple entries.

    > The mailbox "Mailbox1" is the primary public folder mailbox for the users. To remove this mailbox, first remove all other public folder mailboxes.

- **Can't create a public folder migration endpoint**

    When you try to create a public folder migration endpoint, you receive one of the following error messages:

    > An item with the same key has already been added.

    > Multiple mailbox users match identity "Mailbox1". Specify a unique value.

- **Public folder migration failed**

  When you analyze the migration report for the failed public folder mailbox migration requests, you see the following error entry:

  > Multiple mailbox users match identity "Mailbox1". Specify a unique value.

## Cause

This issue occurs if one or both of the following conditions are true:

- Public folder mailboxes that are soft deleted have the same names as active mailboxes.
- Either the primary public folder mailbox or the secondary public folder mailbox has an orphaned CNF (conflict) object.

## Resolution

To resolve this issue, follow these steps:

### Step 1: Remove soft-deleted public folder mailboxes that have the same names as active mailboxes

To find and remove soft-deleted public folder mailboxes that have the same names as active mailboxes, follow these steps:

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
2. Get the mailboxes (including soft-deleted public folder mailboxes) by running the following cmdlet:

   ```powershell
   Get-Recipient  -IncludeSoftDeletedRecipients -RecipientTypeDetails publicfoldermailbox |fl Name, OrganizationalUnit, DistinguishedName, ExchangeGuid
   ```

   Search on "Soft Deleted Objects" in the output, and then check whether the corresponding soft-deleted mailbox name is the same as that of any active mailbox.

   Here's an example of the output:

   > Name: Mailbox1  
   > OrganizationalUnit: <Domain_name>.prod.outlook.com/Microsoft Exchange Hosted Organizations/contoso.onmicrosoft.com/**Soft Deleted Objects**  
   > DistinguishedName: CN=**Mailbox1**,OU=**Soft Deleted Objects**,OU=contoso.onmicrosoft.com,OU=Microsoft Exchange Hosted Organizations,DC=<Domain_name>,DC=PROD,DC=OUTLOOK,DC=COM  
   > ExchangeGuid: \<Guid_number>  
   >
   > Name: Mailbox1  
   > OrganizationalUnit: <Domain_name>.prod.outlook.com/Microsoft Exchange Hosted Organizations/contoso.onmicrosoft.com  
   > DistinguishedName: CN=**Mailbox1**,OU= contoso.onmicrosoft.com,OU=Microsoft Exchange Hosted Organizations,DC=<Domain_name>,DC=PROD,DC=OUTLOOK,DC=COM  
   > ExchangeGuid: \<Guid_number>  

   **Note:** If no soft-deleted public folder mailboxes are found in the output, go to ["Step 2: Remove all existing orphaned public folder mailboxes"](#step-2-remove-all-existing-orphaned-public-folder-mailboxes).

3. Remove the soft-deleted public folder mailbox by running the following cmdlet:

   ```powershell
   Remove-Mailbox -PublicFolder "<ExchangeGuid>" -PermanentlyDelete
   ```

   **Notes:**

   - In this cmdlet, replace \<ExchangeGuid> with the GUID that you got from the cmdlet output in the previous step.
   - Repeat this cmdlet until all soft-deleted public folder mailboxes are hard deleted.

### Step 2: Remove all existing orphaned public folder mailboxes

To find and remove all existing orphaned public folder mailboxes, follow these steps:

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).
2. Find orphaned CNF public folder mailboxes by running the following cmdlets:

    ```powershell
    Get-Mailbox –PublicFolder | fl Name,Identity,ExchangeGuid,Guid
    Get-Mailbox -PublicFolder -SoftDeletedMailbox | fl Name,Identity,ExchangeGuid,Guid
    ```

    If the cmdlets don't report any CNF orphaned public folder mailboxes, run the following cmdlet:

    ```powershell
    Get-Recipient -RecipientTypeDetails PublicFolderMailbox -IncludeSoftDeletedRecipients | fl Name,Identity,ExchangeGuid,Guid
    ```

    Here's an example of the output from this cmdlet in which the object has the CNF value in the name and identity.

     :::image type="content" source="media/public-folder-migration-errors/command-output.png" alt-text="Screenshot of the command output in which ExchangeGuid is highlighted.":::

3. To remove an individual orphaned public folder mailbox, run the following cmdlet:

    ```powershell
    Remove-Mailbox -PublicFolder -RemoveCNFPublicFolderMailboxPermanently <ExchangeGuid> 
    ```

    **Note:** In this cmdlet, replace \<ExchangeGuid> with the value that you got from the cmdlet output in step 2 for mailbox objects that have the "CNF" value in **Name** and **Identity**.

    If the cmdlet in step 2 reports multiple orphaned public folder mailboxes, you can find and remove them in a batch by running the following cmdlet:

    ```powershell
    $soft= Get-Recipient -RecipientTypeDetails PublicFolderMailbox –IncludeSoftDeletedRecipients ; foreach ($mbx in $soft){if ($mbx.Name -like "*CNF:*" -or $mbx.identity -like "*CNF:*") {Remove-Mailbox -PublicFolder $mbx.ExchangeGUID.GUID -RemoveCNFPublicFolderMailboxPermanently}}
    ```
