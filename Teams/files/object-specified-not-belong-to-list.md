---
title: Can't access the Files tab in a Teams channel
description: Fixes an issue in which you can't access the Files tab in a Teams channel. This issue occurs when the default document library name on your SharePoint site has been changed.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro 
ms.topic: troubleshooting 
ms.service: msteams
localization_priority: Normal
ms.custom: 
- CI 143097
- CSSTroubleshoot
ms.reviewer: prbalusu
appliesto:
- Microsoft Teams
search.appverid: 
- MET150
---
# "The object specified does not belong to a list" error when selecting the Files tab in a Teams channel

## Symptoms

When you select the **Files** tab in a channel in Microsoft Teams, you receive the following error message:

> Something went wrong  
> The object specified does not belong to a list.

## Cause

This error occurs if the name of the document library on your SharePoint site was changed from its default, "Shared Documents," to another name.

## Resolution

To resolve this issue, revert the name the document library to "Shared Documents." You must have site owner permissions to make this change.

1. Install the [PnP.PowerShell](https://docs.microsoft.com/powershell/sharepoint/sharepoint-pnp/sharepoint-pnp-cmdlets?view=sharepoint-ps) module.
2. Using [Connect-PnPOnline](https://docs.microsoft.com/powershell/module/sharepoint-pnp/connect-pnponline), connect to the SharePoint Site. For example:

```powershell
Connect-PnPOnline https://contoso.sharepoint.com/sites/team -Interactive
```

3. Using [Get-PnPList](https://docs.microsoft.com/powershell/module/sharepoint-pnp/get-pnplist), place the document library into a variable using the Title of the library. In this example, the Title of the library is 'Renamed Documents'.

```powershell
$list = Get-PnPList 'Renamed Documents'
```

> [!NOTE]
> To see all Document Libraries on the site, you can run `Get-PnPList` without any parameters.

4. Change the document library name to **Shared Documents**.

```
$list.RootFolder.MoveTo('Shared Documents')
$list.Update()
```
