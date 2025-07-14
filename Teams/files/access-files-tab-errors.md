---
title: Can't access the Files tab on a Teams channel
description: Fixes error messages that you receive when you access the Files tab in a Teams channel.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Teams Files\Files Tab
  - CI 149476
  - CI 143097
  - CI 161519
  - CSSTroubleshoot
ms.reviewer: prbalusu
appliesto: 
  - Microsoft Teams
search.appverid: 
  - MET150
ms.date: 10/30/2023
---
# Errors when selecting the Files tab on a Teams channel

This article lists some common error messages that you receive when you select the **Files** tab on a team's channel in Microsoft Teams, and it provides resolutions that you can try.

## Error: The object specified does not belong to a list

This error occurs if the name of the document library on your SharePoint site was changed from its default, "Shared Documents," to another name.

To resolve this issue, use one of the following methods to revert the name of the document library to "Shared Documents." You must have site owner permissions to make this change.

### Method 1

1. Install the [PnP PowerShell module](/powershell/sharepoint/sharepoint-pnp/sharepoint-pnp-cmdlets).
2. Run `Connect-PnPOnline` to connect to the SharePoint site. For example:

    ```powershell
    Connect-PnPOnline -Url "https://contoso.sharepoint.com/sites/team" -Interactive
    ```

3. Run `Get-PnPList`, and place the renamed document library into a variable by using the library name. In the following example, the library name is "Renamed Documents."

    ```powershell
    $list = Get-PnPList 'Renamed Documents'
    ```

    **Note:** To see all document libraries on the site, run `Get-PnPList` without any parameters.

4. Change the document library name to **Shared Documents**.

    ```powershell
    $list.RootFolder.MoveTo('Shared Documents')
    $list.Update()
    ```

### Method 2

1. Open the SharePoint site in [SharePoint Designer](https://www.microsoft.com/download/details.aspx?id=35491).
2. Go to **All Files**.
3. Locate the document library folder by its new name. For example, in the following screenshot, the default name was changed to "Renamed Documents."

   :::image type="content" source="media/access-files-tab-errors/renamed-documents.png" alt-text="Screenshot that shows the renamed document library in All Files.":::

4. Right-click the folder, select **Rename**, and then change the name to **Shared Documents**.

## Error: There was a problem reaching this app

This error occurs if the ownership information for the Microsoft 365 group that's associated with the team is missing from Teams. If an assigned owner leaves the company, the group becomes orphaned.

### Resolution

Assign an owner to the Microsoft 365 group that's associated with the team. For more information, see [Assign a new owner to an orphaned group](https://support.microsoft.com/topic/assign-a-new-owner-to-an-orphaned-group-86bb3db6-8857-45d1-95c8-f6d540e45732).

**Note:** Only a Microsoft 365 administrator in your organization can make this change.

## Error: We can't get your files, we're working on getting them back

This error could be a temporary issue.

### Resolution

Try to access the Files tab after some time. If the issue persists for a longer period of time, [run a self-diagnostics tool](#run-a-self-diagnostics-tool) to resolve any known issues.

### Run a self-diagnostics tool

Microsoft 365 admin users have access to diagnostics that can be run within the tenant to verify possible issues with accessing files to Teams.

> [!NOTE]
> This feature isn't available for Microsoft 365 Government, Microsoft 365 operated by 21Vianet, or Microsoft 365 Germany.

Select **Run Tests** below, which will populate the diagnostic in the Microsoft 365 Admin Center.

> [!div class="nextstepaction"]
> [Run Tests: Unable to access files in a team](https://aka.ms/TeamsAccessFilesInChat)

The diagnostic performs a large range of verifications.

### Need More Help?

Get help from the [Microsoft Community](https://answers.microsoft.com/) online community, search for more information on [Microsoft Support](https://support.microsoft.com/) or [Office Help and How To](https://office.microsoft.com/support/), or learn more about [Assisted Support](https://support.microsoft.com/contactus/) options.
