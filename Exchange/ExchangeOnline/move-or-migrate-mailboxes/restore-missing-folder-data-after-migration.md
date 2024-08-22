---
title: Restore missing folder data after a remote move migration
description: Restore folder data that's missing after a remote move migration in an Exchange hybrid environment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Migration
  - Exchange Online
  - CSSTroubleshoot
  - CI 192106
ms.reviewer: shtahir, lusassl, meerak, v-shorestris
appliesto:
  - Exchange Online
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 08/05/2024
---

# Restore missing folder data after a remote move migration

## Symptoms

After a remote move migration of mailboxes from Microsoft Exchange Server to Microsoft Exchange Online in a hybrid Exchange environment, a migrated user reports that data is missing from one or more of their Microsoft Outlook folders. For example, their _Notes_ folder is empty.

## Cause

During a remote move migration, data might not migrate to Exchange Online because of transient network errors or if folders are corrupted.

**Note**: For information about how to detect and fix mailbox corruption issues, see [New-MailboxRepairRequest](/powershell/module/exchange/new-mailboxrepairrequest).

## Resolution

> [!IMPORTANT]
> For data recovery, when you migrate users to Exchange Online, the users' on-premises mailboxes are only [soft-deleted](/exchange/recipients/disconnected-mailboxes/disconnected-mailboxes#working-with-soft-deleted-mailboxes). Exchange Server permanently deletes soft-deleted mailboxes when their retention period expires, if they aren't on hold. The default retention period for soft-deleted mailboxes is 30 days.

If the retention period hasn't expired, and the soft-deleted mailbox for a migrated user still exists, use the following steps to restore any missing data in the user's cloud mailbox.

> [!NOTE]
> Run all PowerShell cmdlets in the Exchange Management Shell (EMS).

1. Run the following PowerShell cmdlets to get information about the user's soft-deleted mailbox:

   ```PowerShell
   Get-MailboxDatabase| ForEach-Object { Get-MailboxStatistics -Database $_.DistinguishedName } | Where-Object { ($_.DisconnectReason -match "SoftDeleted") -and ($_.DisplayName -match "<migrated mailbox name>") } | FL DisplayName, Database, DisconnectDate, MailboxGUID
   ```

   Note the following information from the PowerShell output:

   - Name of the database that hosts the soft-deleted mailbox
   - GUID of the soft-deleted mailbox

2. Run the following PowerShell cmdlets to create a temporary on-premises mailbox (name it differently than the migrated mailbox):

   ```PowerShell
   $password = Read-Host "Enter password" -AsSecureString
   New-Mailbox -Name "<temp mailbox name>" -UserPrincipalName <UPN> -Password $password | FL ExchangeGuid
   ```

   Note the GUID of the temporary mailbox in the PowerShell output.

3. Run the [New-MailboxRestoreRequest](/powershell/module/exchange/new-mailboxrestorerequest) PowerShell cmdlet to create a restore request to copy data from a folder in the soft-deleted mailbox to a folder in the temporary mailbox:

   ```PowerShell
   New-MailboxRestoreRequest -Name "<request name>" -SourceDatabase "<name of database that contains soft-deleted mailbox>" -SourceStoreMailbox "<GUID of soft-deleted mailbox>" -SourceRootFolder "<folder name>" -TargetMailbox "<GUID of temporary mailbox>" -TargetRootFolder "<folder name>" -AllowLegacyDNMismatch
   ```

   When you run the command, pass in the information that you noted in the preceding steps and the name of the folder that's missing data. For example, to restore the _Notes_ folder, set the value of the `SourceRootFolder` and `TargetRootFolder` parameters to `Notes`.

   > [!NOTE]
   > To restore the entire mailbox, run the New-MailboxRestoreRequest cmdlet without the `SourceRootFolder` and `TargetRootFolder` parameters.

4. Wait for the restore request to finish. To check the request status, use the [Get-MailboxRestoreRequest](/powershell/module/exchange/get-mailboxrestorerequest) PowerShell cmdlet, as follows:

   ```PowerShell
   Get-MailboxRestoreRequest -Name "<request name>"
   ```

5. [Export](/exchange/recipients/mailbox-import-and-export/export-procedures#use-the-exchange-management-shell-to-create-a-mailbox-export-request) the restored data that's in the temporary mailbox to a PST file.

6. Instruct the affected user to [import the PST file](https://support.microsoft.com/office/import-email-contacts-and-calendar-from-an-outlook-pst-file-431a8e9a-f99f-4d5f-ae48-ded54b3440ac) that you created in step 5 into their Outlook app to restore the missing data.

