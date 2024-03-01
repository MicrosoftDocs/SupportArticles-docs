---
title: Error-executing-cmdlet message in the EAC and you can't list or create public folders
description: Provides a resolution for an issue in which you see an error-executing-cmdlet message on the Public folders page in the EAC, and you can't list or create public folders in the EAC or by using PowerShell.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
  - CI 187536
ms.reviewer: batre, v-trisshores
appliesto: 
  - Exchange Online
search.appverid: 
  - MET150
ms.date: 03/01/2024
---

# "Error executing cmdlet" message in the EAC and you can't list or create public folders

## Symptoms

You experience all the following symptoms:

- You see an `Error executing cmdlet` message on the **Public folders** page in the Exchange admin center (EAC).

- The option to **Add a public folder** is grayed out on the **Public folders** page in the EAC.

- If you try to list public folders by using the [Get-PublicFolder](/powershell/module/exchange/get-publicfolder) cmdlet, or create a public folder by using the [New-PublicFolder](/powershell/module/exchange/new-publicfolder) cmdlet, you receive the following error message:

  > No active public folder mailboxes were found for organization \<organization identity\>. This happens when no public folder mailboxes are provisioned or they are provisioned in 'HoldForMigration' mode. If you're not currently performing a migration, create a public folder mailbox.

## Cause

### Cause 1

Your organization has no public folder mailboxes. You can't view or create public folders if your organization doesn't have a public folder mailbox.

### Cause 2

The [primary hierarchy](/exchange/collaboration-exo/public-folders/public-folders#public-folder-mailboxes) public folder mailbox in your organization is in [HoldForMigration](/powershell/module/exchange/new-mailbox#-holdformigration) mode because an on-premises public folder migration to Exchange Online is pending. That mode locks the public folder hierarchy. You can't view or create public folders if the public folder hierarchy is locked.

## Resolution

Get the root public folder mailbox configuration for your organization by running the following PowerShell cmdlet:

```powershell
(Get-OrganizationConfig).RootPublicFolderMailbox | FL HierarchyMailboxGuid, Type, LockedForMigration
```

If your organization has no public folder mailboxes, you see the following command output:

```output
HierarchyMailboxGuid : 00000000-0000-0000-0000-000000000000
Type : MailboxGuid
LockedForMigration : False
```

Note: The `HierarchyMailboxGuid` parameter value is all zeros if your organization has no public folder mailboxes.

If the primary hierarchy public folder mailbox in your organization is in `HoldForMigration` mode, you see the following command output:

```output
HierarchyMailboxGuid : \<non-zero GUID value\>
Type : InTransitMailboxGuid
LockedForMigration : True
```

Note: The `LockedForMigration` parameter value is `True` in `HoldForMigration` mode.

If your organization has no public folder mailboxes, go to the "[Resolution for Cause 1](#resolution-for-cause-1)" section of this article.

If the primary hierarchy public folder mailbox in your organization is in `HoldForMigration` mode, go to the "[Resolution for Cause 2](#resolution-for-cause-2)" section of this article.

### Resolution for Cause 1

Either [migrate on-premises public folders to Exchange Online](/exchange/collaboration/public-folders/migrate-to-exchange-online) or [set up public folders in Exchange Online](/exchange/collaboration-exo/public-folders/set-up-public-folders).

### Resolution for Cause 2

Either [migrate on-premises public folders to Exchange Online](/exchange/collaboration/public-folders/migrate-to-exchange-online) or re-create public folders in Exchange Online.

To re-create public folders, follow these steps:

1. Connect to [Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

2. List the public folder mailboxes in your organization by running the following PowerShell cmdlet:

   ```powershell
   Get-Mailbox -PublicFolder
   ```

3. Delete all public folder mailboxes except the primary hierarchy public folder mailbox by running the following PowerShell cmdlets:

   ```powershell
   $hierarchyMailboxGuid = $(Get-OrganizationConfig).RootPublicFolderMailbox.HierarchyMailboxGuid
   Get-Mailbox -PublicFolder | Where-Object {$_.ExchangeGuid -ne $hierarchyMailboxGuid} | Remove-Mailbox -PublicFolder -Confirm:$false -Force
   ```

4. Delete the primary hierarchy public folder mailbox by running the following PowerShell cmdlet:

   ```powershell
   Get-Mailbox -PublicFolder | Where-Object {$_.ExchangeGuid -eq $hierarchyMailboxGuid} | Remove-Mailbox -PublicFolder -Confirm:$false -Force
   ```

5. Permanently delete soft-deleted public folder mailboxes by running the following PowerShell cmdlet:

   ```powershell
   Get-Mailbox -PublicFolder -SoftDeletedMailbox | % {Remove-Mailbox -PublicFolder -Identity $_.PrimarySmtpAddress -PermanentlyDelete:$true -Confirm:$false -Force}
   ```

   Note: This step doesn't permanently delete soft-deleted public folder mailboxes that are orphaned conflict mailboxes. See the next step.

6. Permanently delete all soft-deleted public folder mailboxes that are orphaned conflict mailboxes by running the following PowerShell cmdlets:

   ```powershell
   $softDeletedPfMailboxes = Get-Mailbox -PublicFolder -SoftDeletedMailbox
   foreach ($mbx in $softDeletedPfMailboxes) {if ($mbx.Name -like "\*CNF:\*" -or $mbx.Identity -like "\*CNF:\*") {Remove-Mailbox -PublicFolder -Identity $mbx.ExchangeGUID.GUID -RemoveCNFPublicFolderMailboxPermanently -Confirm:$false -Force}}
   ```

7. Verify that the list of the public folder mailboxes in your organization is empty by running the following PowerShell cmdlet:

   ```powershell
   Get-Mailbox -PublicFolder
   ```

8. Configure the public folder mailbox settings for your organization to [locally deploy](/powershell/module/exchange/set-organizationconfig#-publicfoldersenabled) new public folders:

   ```powershell
   Set-OrganizationConfig -PublicFoldersEnabled Local
   ```

9. Create the primary hierarchy public folder mailbox by running the following PowerShell cmdlet:

   ```powershell
   New-Mailbox -PublicFolder -Name <name of public folder mailbox>
   ```

10. Create one or more secondary hierarchy public folder mailboxes by rerunning the command in step 9.

    > [!NOTE]
    > Create public folders only in secondary hierarchy public folder mailboxes. After you create a public folder mailbox, it might take up to one hour for the new public folder mailbox to be usable so that you can create public folders in it.
