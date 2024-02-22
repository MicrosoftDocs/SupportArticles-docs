---
title: Public folder items are deleted automatically after batch migration
description: Fixes an issue in which items in a public folder are automatically deleted after a public folder batch migration.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 155655
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: gmuntean, meerak, batre, v-chazhang
appliesto: 
  - Exchange Online
  - Exchange Server 2013
  - Exchange Server 2016
  - Exchange Server 2019
search.appverid: MET150
ms.date: 01/24/2024
---
# Items are deleted after a public folder batch migration

## Symptoms

After a public folder batch migration is completed, items in the public folder are automatically deleted. The items are moved to the Recoverable Items folder (dumpster) of the public folder.

## Cause

This issue occurs because one of the following conditions is true:

- The `DefaultPublicFolderAgeLimit` parameter is set to a value that exceeds the default age limit that's set for the organization.
- The `AgeLimit` parameter is set to a value that exceeds the age limit that's set for the public folder.

## Resolution

You can use the Exchange admin center (EAC) to check the age limit that's set for a public folder.

:::image type="content" source="media/items-deleted-public-folder-batch-migration/age-limits-in-eac.png" alt-text="Screenshot of how to check age limit in Exchange admin center.":::

To prevent the items in a public folder from being deleted automatically, set the value of the `DefaultPublicFolderAgeLimit` parameter or the `AgeLimit` parameter to *`$null`* by running one of the following PowerShell cmdlets:

```powershell
Set-OrganizationConfig -DefaultPublicFolderAgeLimit $null
Set-PublicFolder <Folder path> -AgeLimit $null
```

## More information

Deleted public folders are stored in the public folder dumpster. You can recover the deleted items from a previous backup or directly from the public folder dumpster. For more information, see [Restore a deleted public folder](/exchange/collaboration-exo/public-folders/restore-deleted-public-folder).

To retrieve statistical information or attributes about the public folder dumpster, run the following [Get-PublicFolder](/powershell/module/exchange/get-publicfolder)
 and [Get-PublicFolderStatistics](/powershell/module/exchange/get-publicfolderstatistics) cmdlets:

- `Get-PublicFolder <Dumpster path> | Get-PublicFolderStatistics`
- `Get-PublicFolder <Dumpster EntryID> | Get-PublicFolderStatistic`
- `Get-PublicFolder <Dumpster path> | Format-List`
- `Get-PublicFolder <Dumpster EntryID>`
