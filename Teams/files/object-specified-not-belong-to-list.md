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

To resolve this issue, use one of the following methods to revert the name of the document library to "Shared Documents". You must have site owner permissions to make this change.

### Method 1

1. Install the [PnP PowerShell module](/powershell/sharepoint/sharepoint-pnp/sharepoint-pnp-cmdlets?view=sharepoint-ps&preserve-view=true).
2. Run [Connect-PnPOnline](/powershell/module/sharepoint-pnp/connect-pnponline?view=sharepoint-ps&preserve-view=true) to connect to the SharePoint site. For example:

    ```powershell
    Connect-PnPOnline -Url "https://contoso.sharepoint.com/sites/team" -Interactive
    ```

3. Run [Get-PnPList](/powershell/module/sharepoint-pnp/get-pnplist?view=sharepoint-ps&preserve-view=true), place the renamed document library into a variable by using the library name. In the following example, the library name is "Renamed Documents".

    ```powershell
    $list = Get-PnPList 'Renamed Documents'
    ```

    > [!NOTE]
    > To see all document libraries on the site, run `Get-PnPList` without any parameters.

4. Change the document library name to **Shared Documents**.

    ```powershell
    $list.RootFolder.MoveTo('Shared Documents')
    $list.Update()
    ```

### Method 2

1. Open the SharePoint site in [SharePoint Designer](https://www.microsoft.com/download/details.aspx?id=35491).
2. Go to **All Files**.
3. Locate the document library folder by its new name. For example, in the following screenshot, the default name was changed to "Renamed Documents."

   :::image type="content" source="media/object-specified-not-belong-to-list/renamed-documents.png" alt-text="Screenshot of the renamed document library in All Files.":::

4. Right-click the folder, select **Rename**, and then change the name to **Shared Documents**.
