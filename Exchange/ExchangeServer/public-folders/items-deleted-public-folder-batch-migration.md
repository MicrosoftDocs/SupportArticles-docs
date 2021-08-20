---
title: Public folder items are deleted automatically after batch migration
description: Fixes an issue in which items in the public folder are automatically deleted after a public folder batch migration.
author: v-charloz
ms.author: v-chazhang
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom:
- CI 155655
- Exchange Server
- CSSTroubleshoot
ms.reviewer: gmuntean; meerak; batre
appliesto: 
- Exchange Online
- Exchange Server 2013
- Exchange Server 2016
- Exchange Server 2019
search.appverid: MET150
---
# Items are deleted after a public folder batch migration

## Symptoms

After a public folder batch migration is completed, items in the public folder are automatically deleted. The items are moved to the Recoverable Items folder (dumpster) of the public folder.

## Cause

This issue occurs because the `DefaultPublicFolderAgeLimit` parameter is set to a specific value at the organizational level.

The `DefaultPublicFolderAgeLimit` parameter specifies the default age limit for the contents of public folders across the entire organization. Items in a public folder are automatically deleted when this age limit is exceeded. This attribute applies to all public folders in the organization that don't have their own Age Limit setting.

To specify a value, enter it as a time span: *dd.hh:mm:ss*, where d = days, h = hours, m = minutes, and s = seconds. Or, enter the default value *$null*.

## Resolution

To prevent the items in a public folder from being deleted automatically, set the value of the `DefaultPublicFolderAgeLimit` parameter to *$null* by running the following PowerShell cmdlet:

```powershell
Set-OrganizationConfig -DefaultPublicFolderAgeLimit $null
```

## More information

Deleted public folders are stored in the public folder dumpster. You can recover the deleted items from a previous backup, or from the public folder dumpster. See [Restore a deleted public folder](/exchange/collaboration-exo/public-folders/restore-deleted-public-folder)
 for more information.

To retrieve statistical information or attributes about the public folder dumpster, run the following [Get-PublicFolder](/powershell/module/exchange/get-publicfolder?view=exchange-ps)
 and [Get-PublicFolderStatistics](/powershell/module/exchange/get-publicfolderstatistics?view=exchange-ps) cmdlets:

- `Get-PublicFolder <Dumpster path> | Get-PublicFolderStatistics`
- `Get-PublicFolder <Dumpster EntryID> | Get-PublicFolderStatistic`
- `Get-PublicFolder <Dumpster path> | Format-List`
- `Get-PublicFolder <Dumpster EntryID>`
