---
title: No active public folder mailboxes were found error
description: No active public folder mailboxes were found error occurs when you try to create a public folder in Exchange Server.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Collaboration and Public Folders\Issues with Public Folder Migration
  - Exchange Server
  - CSSTroubleshoot
  - CI 9823
  - CI 10027
ms.reviewer: russwill, batre，benwinz, v-six
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 07/28/2026
---

# No active public folder mailboxes error when creating public folder

_Original KB number:_ &nbsp; 2786607

## Summary

This article describes an error that occurs when you create mailboxes in Exchange Server by using the `HoldForMigration` parameter. This error occurs when you use the `HoldForMigration` parameter incorrectly. The article describes the process for fixing the error.

## Symptoms

Assume that you create the first public folder mailbox in Exchange Server by using the `HoldForMigration` parameter. You perform one of the following actions in the environment:

- You try to access the public folder hierarchy by running the [Get-PublicFolder](/powershell/module/exchangepowershell/get-publicfolder) cmdlet in Exchange Management Shell (EMS) or by using Exchange admin center (EAC).
- You try to create a new public folder on the Exchange server.

In this situation, you receive the following error message:

> No active public folder mailboxes were found. This error happens when no public folder mailboxes are provisioned or they're provisioned in `HoldForMigration` mode. If you're not currently performing a migration, create a public folder mailbox.

> [!NOTE]
> Create the public folder mailbox by using the `HoldForMigration` parameter only if you're migrating from legacy public folders to modern public folders. When you specify the `HoldForMigration` parameter, it locks the public folder hierarchy in Exchange Server 2013 or Exchange Server 2016 so that users can't create public folders until the migration is complete.  

Use the [Get-OrganizationConfig](/powershell/module/exchangepowershell/get-organizationconfig) Exchange PowerShell cmdlet to verify that the first public folder mailbox was created with the `HoldForMigration` parameter as shown in the following example:

```powershell
[PS] C:\>(Get-OrganizationConfig).RootPublicFolderMailbox
IsValid : True
CanUpdate : True
HierarchyMailboxGuid : dba08a32-d51f-4c21-ae31-8f7d678ccfb1
HierarchySmtpAddress :
LockedForMigration : True
```

If the `LockedForMigration` attribute shows a value of `True`, the public folder hierarchy is locked and the first public folder mailbox was created by using the `HoldForMigration` parameter.

## Cause

This issue occurs because you specify the `HoldForMigration` parameter when you create the first public folder mailbox. This behavior is by design.

## Resolution

If you create the first public folder mailbox by using the `HoldForMigration` parameter because you're migrating legacy public folders, complete the migration.
For more information about how the `HoldForMigration` parameter is used for public folder migration, see [Use batch migration to migrate Exchange Server public folders to Exchange Online](/exchange/collaboration/public-folders/migrate-to-exchange-online).

If your organization doesn't have legacy public folders and you accidentally create the first public folder mailbox by using the `HoldForMigration` parameter, you must delete all public folder mailboxes that are present in the organization. Then, create a new public folder mailbox without specifying the `HoldForMigration` parameter. To complete this task, use one of the following methods.

### Method 1: Delete the public folder mailbox by using EAC

1. Using an account that has sufficient permissions on your Exchange Server, sign in to the Exchange admin center (EAC).
1. Select **Public Folders**, and then select **Public Folder mailboxes**.
1. Delete all public folder mailboxes of the **Secondary Hierarchy** type.
1. Delete the public folder mailbox of the **Primary Hierarchy** type.
1. Select the **New public folder mailbox** icon to create a public folder mailbox.

### Method 2: Delete the public folder mailbox by using Exchange PowerShell

1. Use an account that has [sufficient permissions](/exchange/permissions/permissions) on your Exchange Server to open the [Exchange Management Shell (EMS)](/powershell/exchange/open-the-exchange-management-shell) or [connect to your Exchange server by using remote PowerShell](/powershell/exchange/connect-to-exchange-servers-using-remote-powershell).

1. To return and delete public folder mailboxes of the Secondary Hierarchy type, run the [Get-Mailbox](/powershell/module/exchangepowershell/get-mailbox) cmdlet as shown in the following example:

   ```powershell
   Get-Mailbox -PublicFolder | where {$_.IsRootPublicFolderMailbox -eq $False} | Remove-Mailbox -PublicFolder
   ```

1.To return and delete public folder mailboxes of the Primary Hierarchy type, run the [Get-Mailbox](/powershell/module/exchangepowershell/get-mailbox) cmdlet as shown in the following example:

  ```powershell
  Get-Mailbox -PublicFolder | where {$_.IsRootPublicFolderMailbox -eq $true} | Remove-Mailbox -PublicFolder
  ```

1.To create a public folder mailbox without specifying the `HoldForMigration` parameter, run the [New-Mailbox](/powershell/module/exchangepowershell/new-mailbox) cmdlet as shown in the following example:

```powershell
   New-Mailbox -PublicFolder -Database "Mailbox Database Name" -Name "Public Folder Mailbox Name"
```

## More information

For more information about how to remove public folders in an Exchange Server environment, see [How to remove public folders](/exchange/collaboration-exo/public-folders/remove-public-folder).

For more information about the `HoldForMigration` parameter, see [General information about the New-Mailbox cmdlet with the HoldForMigration parameter](/powershell/module/exchangepowershell/new-mailbox).
