---
title: Unable to reach the server when sharing files
description: This article fixes an issue in which you receive an Unable to reach the server message when you share files or folders.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - sap:Sharing\Sharing links
  - CSSTroubleshoot
  - CI 160069
ms.reviewer: salarson
appliesto: 
  - SharePoint Online
  - OneDrive
ms.date: 12/17/2023
---

# "Unable to reach the server" error when sharing files or folders in SharePoint or OneDrive

When you try to share files or folders in Microsoft SharePoint Online or Microsoft OneDrive, you receive the following error message:

> Sorry, we're unable to reach the server right now.

This issue occurs for various reasons. To resolve this issue, try the following solutions in the given order. 

## Check the access request settings

This issue might occur if the access request settings of the SharePoint site don't allow members to share files and folders.  

To change the settings, follow the steps at [Change access requests settings](https://support.microsoft.com/office/set-up-and-manage-access-requests-94b26e0b-2822-49d4-929a-8455698654b3#bk_enableallow_sponline).

## Check the settings in Internet Options

This issue might occur if the **Do not save encrypted pages to disk** option is selected in Internet Options. To clear the option, follow these steps:

1. Open Internet Explorer, and then select **Tools** > **Internet Options** > **Advanced**.
1. In the **Settings** field, scroll to the **Security** section.
1. Clear the **Do not save encrypted pages to disk** check box.

   :::image type="content" source="media/share-file-unable-reach-server/change-security-setting.png" alt-text="Screenshot of the security settings on the Internet Options Advanced tab. The setting that's labeled Do not save encrypted pages to disk is highlighted.":::

1. Select **Apply**, and then select **OK**.
1. Restart your browser for the settings to take effect.

## Make sure the items being shared don't reach a limit

There is a limit of 50,000 items that can be shared in a folder or any subfolders.

If the items that you try to share in any folder reach the capacity limit, move some items out of the folder, or select individual files to share.

To learn more about large lists and libraries, see [Manage large lists and libraries](https://support.microsoft.com/office/manage-large-lists-and-libraries-b8588dae-9387-48c2-9248-c24122f07c59).

## Check the site storage

This issue might occur if the site has insufficient storage space.  

To change the site storage limits, see [Manage individual site storage limits](/sharepoint/manage-site-collection-storage-limits#manage-individual-site-storage-limits).

## Check the unique security scopes per list or library

In some situations, when you share files or folders with users in the classic experience of a SharePoint site, you might receive the following error message:

> You cannot break inheritance for this item because there are too many items with unique permissions in this list.

This message indicates that the list or library reaches the limit of the unique permissions. To learn more, see [Unique security scopes per list or library](/office365/servicedescriptions/sharepoint-online-service-description/sharepoint-online-limits#unique-security-scopes-per-list-or-library).

To fix this error, follow the resolution at ["You can't share this folder because there are too many items in the folder" error when trying to share or break inheritance](../lists-and-libraries/error-share-break-inheritance.md).

## Run the Check User Access Diagnostic

> [!NOTE]
> This feature requires a Microsoft 365 administrator account. This feature isn't available for Microsoft 365 Government, Microsoft 365 operated by 21Vianet, or Microsoft 365 Germany.

Microsoft 365 admin users have access to diagnostics that can be run within the tenant to verify possible issues with user access.

Select **Run Tests** below, which will populate the diagnostic in the Microsoft 365 Admin Center.

> [!div class="nextstepaction"]
> [Run Tests: Check SharePoint User Access](https://aka.ms/PillarCheckUserAccess)

The diagnostic performs a large range of verifications for internal users or guests who try to access SharePoint and OneDrive sites.

## More information

["The number of items in this list exceeds the list view threshold" when you view lists in Microsoft 365](../lists-and-libraries/items-exceeds-list-view-threshold.md)

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
