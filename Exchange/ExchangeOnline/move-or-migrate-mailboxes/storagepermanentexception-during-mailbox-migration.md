---
title: StoragePermanentException transient failures during a mailbox migration
description: Provides a workaround for an issue in which mailbox migration fails because of StoragePermanentException transient failures during a mailbox migration.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Online
  - CSSTroubleshoot
  - CI 180017
ms.reviewer: deenaelkadim, ninob, meerak, v-trisshores
appliesto:
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---

# StoragePermanentException transient failures during a mailbox migration

## Symptoms

You use the Microsoft Exchange admin center (EAC) or the [New-MoveRequest](/powershell/module/exchange/new-moverequest) cmdlet to initiate mailbox migration to or from Microsoft Exchange Online. However, the migration fails.

When you run the [Get-MoveRequestStatistics](/powershell/module/exchange/get-moverequeststatistics) cmdlet to get detailed failure information, the command output contains the following error message:

```output
The job encountered too many transient failures (<transient failure count>) and is quitting.
The most common failure is StoragePermanentException with the hit count <hit count>.
```

## Cause

The source mailbox contains corrupted items. Typically, the error message indicates corruption in any of the following items:

- Folder properties

- Folder views

- Folder restrictions (search folder query filters)

## Workaround

To work around the issue, use either of the following methods.

### Method 1

Use the [Set-MoveRequest](/powershell/module/exchange/set-moverequest) cmdlet together with the `MoveOptions` parameter to exclude potentially corrupted items from the migration. For example, run the following command to recover the migration:

```PowerShell
Set-MoveRequest -Identity <mailbox ID> -MoveOptions:SkipFolderPromotedProperties,SkipFolderViews,SkipFolderRestrictions
```

### Method 2

Use the [New-MoveRequest](/powershell/module/exchange/new-moverequest) cmdlet together with the `MoveOptions` parameter to exclude potentially corrupted items in a new migration. For example, run the following command to initiate a new migration of the mailbox:

```PowerShell
New-MoveRequest -Identity <mailbox ID> -MoveOptions:SkipFolderPromotedProperties,SkipFolderViews,SkipFolderRestrictions
```
