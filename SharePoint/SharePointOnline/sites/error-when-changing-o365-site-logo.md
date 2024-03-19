---
title: Error when changing O365 site logo in SharePoint
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 12/17/2023
audience: Admin
ms.topic: troubleshooting
localization_priority: Normal
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
description: What to do if you get an error when trying to change a Microsoft 365 site logo in SharePoint.
---

# Error when trying to change site logo on O365 group SharePoint site

## Symptoms

When trying to change the site logo on a Microsoft 365 group's SharePoint site, you see one of the following errors:

- An error occurred while processing this request
- "Check to see if group property HiddenFromAddressListsEnabled is set to true, or if Address Book Policies are set on the group. Otherwise please try again later."
- The Site Information panel pauses while loading

## Workaround

To resolve this issue, try one of the following workarounds:

- Update the group logo from the [Outlook Web](https://outlook.office.com/) UI:
    1. Go to Outlook web. 
    2. Under  **Groups**, select your O365 group.
    3. Select **Group Icon** > **Edit**.
    4. Select the icon to change.

- Upload the image to the Site Assets Library:
    1. Go to your SharePoint site of O365 group.
    2. In the top right corner, select **Settings** and then **Site Contents**.
    3. Navigate to "Site Assets" Library
    4. Rename the image "\__siteIcon__.png".
    5. Upload the new image as "\__siteIcon__.png" from your computer.

## More information

Listed below are other recommendations that may help resolve the issue.

1. To make changes to the logo, title, description, and other settings, you must have owner or designer permissions on the SharePoint site. For more information, see [Manage site permissions](https://support.office.com/article/manage-your-sharepoint-site-settings-8376034d-d0c7-446e-9178-6ab51c58df42?ui=en-US&rs=en-US&ad=US#__bkmkmngsitepermissions).
2. Make sure the O365 group property "HiddenFromAddressListsEnabled" is not set to True. Exchange or Global administrators should use [Set-UnifiedGroup](/powershell/module/exchange/users-and-groups/set-unifiedgroup?view=exchange-ps&preserve-view=true) to set HiddenFromAddressListsEnabled to False.
3. Make sure that Address Book Policies (ABP) are set on the group mailbox. Check with your Exchange admins if [Removing an address book policy](/exchange/address-books/address-book-policies/remove-an-address-book-policy) for a group mailbox is an option. 
4. If the O365 group is deleted but the SharePoint site still exists, the Site Information Panel might show a spinning icon. If so, [restore the O365 group from the recycle bin](/microsoft-365/admin/create-groups/restore-deleted-group?view=o365-worldwide&preserve-view=true) if it was deleted within the past 30 days. 

For more information, see [Manage your SharePoint site settings](https://support.office.com/article/manage-your-sharepoint-site-settings-8376034d-d0c7-446e-9178-6ab51c58df42?ui=en-US&rs=en-US&ad=US).


Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
