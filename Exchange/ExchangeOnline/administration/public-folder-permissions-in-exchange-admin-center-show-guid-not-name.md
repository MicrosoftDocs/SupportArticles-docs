---
title: Public folder permissions in Exchange admin center show GUID instead of name
description: Provides methods for getting the names of users who are identified by a GUID in a public folder permissions window in the Exchange Online admin center.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom:
  - Exchange Online
  - CSSTroubleshoot
  - CI 171142
ms.reviewer: batre, meerak, v-trisshores
appliesto:
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---

# Public folder permissions in Exchange admin center show GUID instead of name

When you view the list of users in a public folder permissions window in the Exchange Online admin center (EAC), you notice that some users are identified by a GUID in the **Name** field.

The following example shows a GUID in the **Name** field of a public folder permissions window.

:::image type="content" source="media/public-folder-permissions-in-exchange-admin-center-show-guid/public-folder-permissions-window.png" alt-text="Screenshot of a public folder permissions window that shows a GUID in the Name field.":::

## Cause

To ensure the uniqueness of new recipient objects that are synced from Microsoft Entra ID, Exchange Online replaces the object **Name** property value with the object [ExternalDirectoryObjectId](/powershell/module/exchange/get-exomailbox#-externaldirectoryobjectid) (EDOID) property value. New recipient objects include mailboxes, users, groups, and contacts. For more information, see [Change in naming convention of user's Name parameter](https://techcommunity.microsoft.com/t5/exchange-team-blog/change-in-naming-convention-of-user-s-name-parameter/ba-p/3284733).

## Workaround

To get the names of users who are identified by a GUID in an EAC public folder permissions window, use one of the following methods.

### Method 1: Use Exchange Online PowerShell

1. [Connect to Exchange Online PowerShell](/powershell/exchange/connect-to-exchange-online-powershell).

2. Use the [Get-PublicFolderClientPermission](/powershell/module/exchange/get-publicfolderclientpermission) cmdlet to get the names of users:

   ```powershell
   Get-PublicFolderClientPermission -Identity "<public folder name>" | Format-List User,AccessRights
   ```

   For example, the `Get-PublicFolderClientPermission -Identity "\Public Folder 1" | Format-List User,AccessRights` command might generate the following output:

   ```output
   User : Default
   AccessRights : {Author}
   User : Anonymous
   AccessRights : {None}
   User : mina.amiri
   AccessRights : {PublishingEditor}
   User : dakota.sanchez
   AccessRights : {Owner}
   ```

### Method 2: Use the Outlook client

Open the properties window for a public folder, and then select the **Permissions** tab to view the names of users. The following screenshot shows an example of the **Permissions** tab for a public folder.

:::image type="content" source="media/public-folder-permissions-in-exchange-admin-center-show-guid/outlook-public-folder-properties.png" alt-text="Screenshot of a public folder properties window that displays the names of users.":::
