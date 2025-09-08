---
title: No active public folder mailboxes were found error
description: No active public folder mailboxes were found error occurs when you try to create a public folder in Exchange Server 2016 and Exchange Server 2013. Provides a solution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Collaboration and Public Folders\Issues with Public Folder Migration
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: russwill, batre，benwinz, v-six
appliesto: 
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# No active public folder mailboxes were found error when creating public folder

_Original KB number:_ &nbsp; 2786607

## Symptoms

Assume that you create the first public folder mailbox with the `HoldForMigration` parameter in Exchange Server 2013 or Microsoft Exchange Server 2016. You perform one of the following actions in the environment:

- You try to access the public folder hierarchy by running the `Get-PublicFolder` cmdlet in Exchange Management Shell (EMS) or by using Exchange Administration Center (EAC).
- You try to create a new public folder on the Exchange server.

In this situation, you receive the following error message:

> No active public folder mailboxes were found. This happens when no public folder mailboxes are provisioned or they are provisioned in HoldForMigration mode. If you're not currently performing a migration, create a public folder mailbox.

This is a sample screenshot of the error message in EMS:

:::image type="content" source="media/no-active-public-folder-mailboxes-were-found-error/error-message-in-ems.png" alt-text="Screenshot of the error message in E M S.":::

The following is a sample screenshot of the error message in EAC:

:::image type="content" source="media/no-active-public-folder-mailboxes-were-found-error/error-message-in-eac.png" alt-text="Screenshot of the error message in E A C.":::

> [!NOTE]
> The public folder mailbox should be created with the `HoldForMigration` parameter only if you are migrating from legacy public folders to modern public folders in Exchange Server 2013 or Exchange Server 2016. Specifying the `HoldForMigration` parameter locks the public folder hierarchy in Exchange Server 2013 or Exchange Server 2016 so that no public folders can be created by users until the migration is complete.  
The following Exchange PowerShell command is an example of the output that can be used to verify that the first public folder mailbox is created with the `HoldForMigration` parameter:

```powershell
[PS] C:\>(Get-OrganizationConfig).RootPublicFolderMailbox
IsValid : True
CanUpdate : True
HierarchyMailboxGuid : dba08a32-d51f-4c21-ae31-8f7d678ccfb1
HierarchySmtpAddress :
LockedForMigration : True
```

The **True** value of the **LockedForMigration** field indicates that the public folder hierarchy is locked.

## Cause

This issue occurs because the `HoldForMigration` parameter is specified when you create the first public folder mailbox. This behavior is by design.

## Resolution

If you have created the first public folder mailbox with the `HoldForMigration` parameter for migrating legacy public folders, complete the migration. For more information about how the `HoldForMigration` parameter is used for public folder migration, see [How to migrate public folders from Exchange Server 2010 SP3 to Microsoft Exchange Server 2013](/previous-versions/exchange-server/exchange-150/jj150486(v=exchg.150)).

If you do not have legacy public folders in the organization and you accidentally created the first public folder mailbox with the `HoldForMigration` parameter, then you must delete all public folder mailboxes that are present in the organization. Then, you must create a new public folder mailbox without specifying the `HoldForMigration` parameter. To do this, use one of these methods.

### Method 1: Delete the public folder mailbox by using EAC

1. Go to the following Microsoft website to open EAC: `Https://CASServerName/ecp`.
2. Sign in to EAC by using the administrator account.
3. Select **Public Folders**, and then select **Public Folder mailboxes**.
4. Delete all public folder mailboxes of the **Secondary Hierarchy** type.
5. Delete the public folder mailbox of the **Primary Hierarchy** type.
6. Select the **New public folder mailbox** icon to create a public folder mailbox.
7. The new mailbox is displayed as a primary hierarchy mailbox.

### Method 2: Delete the public folder mailbox by using EMS

1. Run the following cmdlet to return and delete public folder mailboxes of the **Secondary Hierarchy** type:

    ```powershell
    Get-Mailbox -PublicFolder | where {$_.IsRootPublicFolderMailbox -eq $False} | Remove-Mailbox -PublicFolder
    ```

2. Run the following cmdlet to return and delete public folder mailbox of the **Primary Hierarchy** type:

    ```powershell
    Get-Mailbox -PublicFolder | where {$_.IsRootPublicFolderMailbox -eq $true} | Remove-Mailbox -PublicFolder
    ```

3. Create a public folder mailbox without specifying the `HoldForMigration` parameter by running the following cmdlet:

    ```powershell
    New-Mailbox -PublicFolder -Database "Mailbox Database Name" -Name "Public Folder Mailbox Name"
    ```

## More information

For more information about how to remove public folders in an Exchange Server 2013 environment, see [How to remove public folders](/exchange/collaboration-exo/public-folders/remove-public-folder).

For more information about the `HoldForMigration` parameter, see [General information about the New-Mailbox cmdlet together with the HoldForMigration parameter](/powershell/module/exchange/new-mailbox).
