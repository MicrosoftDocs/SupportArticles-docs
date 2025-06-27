---
title: '"Multiple entries" error when a remote move migration fails'
description: Describes an issue in which a remote move migration fails because the email address that specifies a mailbox doesn't uniquely identify it.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Migration
  - Exchange Hybrid
  - CSSTroubleshoot
  - CI 165704
ms.reviewer: haembab, ninob, meerak, v-trisshores
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# "Multiple entries" error when a remote move migration fails

## Symptoms

In a hybrid Exchange Server deployment, when you initiate a remote move migration either in the [Exchange admin center](/exchange/mailbox-migration/manage-migration-batches) (EAC) or by using the PowerShell cmdlet [`New-MigrationBatch`](/powershell/module/exchange/new-migrationbatch) or [`New-MoveRequest`](/powershell/module/exchange/new-moverequest), the migration fails, and you receive the following error message:

> The operation couldn't be performed because '\<mailbox display name\>' matches multiple entries.

## Cause

The remote move migration fails because a soft-deleted or inactive mailbox has the same email address as the mailbox that's identified in the error message.

## Resolution

Specify a mailbox by its GUID instead of its email address. When you specify a mailbox for migration by its GUID, you must use the [`New-MoveRequest`](/powershell/module/exchange/new-moverequest) PowerShell cmdlet. The following steps describe how you can get the GUID of an active mailbox and then migrate the mailbox by specifying its GUID:

1. Run the `Get-Mailbox` cmdlet for the mailbox that's identified in the error message:

   > [Get-Mailbox](/powershell/module/exchange/get-mailbox) -Identity \<conflicting email address\> \| fl Name, Alias, DistinguishedName, GUID

   This command doesn't return soft-deleted or inactive mailboxes.

2. Migrate the active mailbox by using the `New-MoveRequest` cmdlet and the GUID from step 1:

   > [New-MoveRequest](/powershell/module/exchange/new-moverequest) -Identity \<active mailbox GUID\>

## More information

If you want to identify soft-deleted or inactive mailboxes by email address, you can run the following cmdlet:

> Get-Mailbox -Identity \<email address\> -SoftDeletedMailbox -IncludeInactiveMailbox \| fl Name, Alias, DistinguishedName, GUID, IsSoftDeletedByRemove, \*Hold\*

If the preceding search doesn't report any soft-deleted or inactive mailboxes, you can run the following cmdlet to check for other soft-deleted recipients:

> Get-Recipient -Identity \<email address\> -IncludeSoftDeletedRecipients \| fl Name, Alias, DistinguishedName, GUID

**Note:** A soft-deleted or inactive mailbox in the output of `Get-Mailbox` or `Get-Recipient` will have a distinguished name (DN) that includes the organizational unit (OU) key-value pair OU=Soft Deleted Objects. An inactive mailbox is a type of soft-deleted mailbox. Therefore, it has the same OU value. An example DN for a soft-deleted or inactive mailbox is as follows:

> CN=dakota.sanchez,OU=Soft Deleted Objects,OU=contoso.onmicrosoft.com,OU=Microsoft Exchange Hosted Organizations,DC=EURPR07A005,DC=prod,DC=outlook,DC=com
