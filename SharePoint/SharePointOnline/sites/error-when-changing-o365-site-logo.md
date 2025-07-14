---
title: Error when changing site logo on Microsoft 365 group SharePoint site
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 08/09/2024
audience: Admin
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - ADD PRODUCT
ms.custom: 
  - sap:Sites\Site Designs
  - CI 116548
  - CSSTroubleshoot
ms.reviewer: prbalusu
description: Provides workarounds when you get an error trying to change the site logo of a Microsoft 365 group.
---

# Error when changing site logo on Microsoft 365 group SharePoint site

## Symptoms

When trying to change the site logo on a Microsoft 365 group's SharePoint site, you see one of the following errors:

> - An error occurred while processing this request
> - "Check to see if group property HiddenFromAddressListsEnabled is set to true, or if Address Book Policies are set on the group. Otherwise please try again later."
> - The Site Information panel pauses while loading

## Workaround

To work around this issue, try one of the following methods:

- Update the group logo from [Outlook on the Web](https://outlook.office.com/):
    1. Navigate to Outlook on the web.
    2. Under  **Groups**, select your O365 group.
    3. Select **Group Icon** > **Edit**.
    4. Select the icon to change.

- Upload the image to the Site Assets library:
    1. Navigate to the SharePoint site of O365 group.
    2. In the top right corner, select **Settings** and then **Site Contents**.
    3. Navigate to the "Site Assets" library.
    4. Rename the image "\__siteIcon__.png".
    5. Upload the new image as "\__siteIcon__.png" from your computer.

## More information

The following recommendations may also help resolve the issue.

1. You must have Owner or Designer permissions on the SharePoint site to make changes to the logo, title, description, and other settings. For more information, see [Manage site permissions](https://support.office.com/article/manage-your-sharepoint-site-settings-8376034d-d0c7-446e-9178-6ab51c58df42?ui=en-US&rs=en-US&ad=US#__bkmkmngsitepermissions).
2. Make sure that the O365 group property "HiddenFromAddressListsEnabled" isn't set to True. Exchange administrators should use [Set-UnifiedGroup](/powershell/module/exchange/users-and-groups/set-unifiedgroup?view=exchange-ps&preserve-view=true) to set HiddenFromAddressListsEnabled to False.
3. Make sure that Address Book Policies (ABP) are set on the group mailbox. Check with your Exchange admin whether [Removing an address book policy](/exchange/address-books/address-book-policies/remove-an-address-book-policy) for a group mailbox is an option.
4. If the O365 group is deleted but the SharePoint site still exists, the Site Information Panel might show a spinning icon. In this scenario, [restore the O365 group from the recycle bin](/microsoft-365/admin/create-groups/restore-deleted-group?view=o365-worldwide&preserve-view=true) if it was deleted within the past 30 days.

For more information, see [Manage your SharePoint site settings](https://support.office.com/article/manage-your-sharepoint-site-settings-8376034d-d0c7-446e-9178-6ab51c58df42?ui=en-US&rs=en-US&ad=US).
