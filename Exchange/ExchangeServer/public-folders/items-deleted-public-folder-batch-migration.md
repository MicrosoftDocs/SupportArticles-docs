---
title: Public folder items are deleted automatically after batch migration
description: Fixes an issue in which items in a public folder are automatically deleted after a public folder batch migration.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Migration\Issues with Public Folder Migration
  - CI 155655
  - CI 9823
  - CI 12260
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: gmuntean, meerak, batre, v-chazhang, v-kccross
appliesto: 
  - Exchange Online
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 06/29/2026
---

# Items are deleted after a public folder batch migration

## Summary

Items in public folders are automatically moved to the dumpster after a public folder batch migration when age limit settings are configured incorrectly. This issue occurs when the organization or folder-level age limit exceeds the intended retention settings. This misconfiguration causes Microsoft Exchange Server to treat existing items as expired and delete them during or after migration. Adjusting or clearing the age limit settings prevents unintended item deletion.

## Symptoms

After a public folder batch migration completes, items in the public folder are automatically deleted. The items are moved to the Recoverable Items folder (dumpster) of the public folder.

## Cause

This issue occurs because one of the following conditions is true:

- The `DefaultPublicFolderAgeLimit` parameter is set to a value that exceeds the default age limit that's set for the organization.
- The `AgeLimit` parameter is set to a value that exceeds the age limit that's set for the public folder.

## Resolution

You can use the Exchange admin center (EAC) to check the age limit that's set for a public folder.

:::image type="content" source="media/items-deleted-public-folder-batch-migration/age-limits-in-eac.png" alt-text="Screenshot of how to the check age limit in Exchange admin center.":::

To prevent the items in a public folder from being deleted automatically, set the value of the `DefaultPublicFolderAgeLimit` parameter or the `AgeLimit` parameter to *`$null`* by running one of the following PowerShell cmdlets:

```powershell
Set-OrganizationConfig -DefaultPublicFolderAgeLimit $null
Set-PublicFolder <Folder path> -AgeLimit $null
```

## More information

Deleted public folders are stored in the public folder dumpster. You can recover the deleted items from a previous backup or directly from the public folder dumpster. For more information, see [Restore a deleted public folder](/exchange/collaboration-exo/public-folders/restore-deleted-public-folder).

To retrieve statistical information or attributes about the public folder dumpster, run the following [Get-PublicFolder](/powershell/module/exchange/get-publicfolder) and [Get-PublicFolderStatistics](/powershell/module/exchange/get-publicfolderstatistics) cmdlets:

- `Get-PublicFolder <Dumpster path> | Get-PublicFolderStatistics`
- `Get-PublicFolder <Dumpster EntryID> | Get-PublicFolderStatistic`
- `Get-PublicFolder <Dumpster path> | Format-List`
- `Get-PublicFolder <Dumpster EntryID>`
