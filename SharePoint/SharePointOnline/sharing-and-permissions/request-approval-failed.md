---
title: Request approval failed when you process a pending request
description: This article describes an issue where Access Denied to Access Requests list or Request approval failed when you process a pending request, and provides a solution.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - sap:Sharing\Access requests
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
  - SharePoint Server 2019
  - SharePoint Server 2016
  - SharePoint Server 2010
ms.date: 12/17/2023
---

# "Access Denied" to Access Requests list or "Request approval failed" when you process a pending request

## Problem

You have a Microsoft SharePoint Online site on which the **Allow access requests** setting is enabled.

When users who have **Full Control** permissions to the site clicks **Access requests and invitations in Site Settings**, they receive the following error message:

**Access Denied.**

Also, when users browse to the **Access Requests** list and then click **Approve** or **Decline** for a pending request, they receive the following error message:

>Sending approval<br>
Request approval failed


## Solution

To resolve this issue, users must be either site collection administrators or be members of the Owners group for the site. The Owners group must also have permissions to access the **Access Requests** list. Use the following solutions as appropriate for your specific configuration.

### Site collection administrator

If an affected user should be a site collection administrator, go to the following Microsoft website for more information about how to manage administrators for your sites:

[Manage site collection administrators](/sharepoint/manage-site-collection-administrators)

### Add the user to the Owners group for the site

If the user should be a site owner, you must add the user to the Owners group for the site. To do this, follow these steps:

1. As a user who can change site permissions, browse to the affected site or site collection. Click the gear icon for the **Settings** menu, and then click **Site settings**.

1. Click **Site permissions**.

1. Click the **Owners** group for the site.

1. Click **New**.

1. In the **Share** dialog box, enter the user account of the user who you want to add to the group. Then, click **Share**.

1. Test to verify that the user can now access the list and approve or decline requests.

### Make sure that the Owners group has permissions to the Access Requests list

If the Owners group is changed or was removed from the **Access requests** list, you must add the Owners group permissions for the list. You must also make sure that the affected user is included in the Owners list. To do this, follow these steps:

1. As a user who has the **Manage Permissions Permission Level** on the affected site and who also has access to the **Access Requests** list (for example, a Site Collection administrator), browse to the **Access Requests** list in **Internet Explorer**.

1. Press F12 to open the F12 Developer Tools window.

1. Press Ctrl + F5 to refresh the page.

1. Click the **Debugger tab**.

    :::image type="content" source="media/request-approval-failed/debugger-tab.png" alt-text="Screenshot of the Debugger tab of F12 Developer Tools window.":::

1. In the search box on the right hand side of the page, type **pagelistid:**, and then press Enter.

    :::image type="content" source="media/request-approval-failed/pagelistid.png" alt-text="Screenshot of the search box when you type PageListId.":::

1. Copy the GUID that follows the pageListId located in the listedit.aspx page. The GUID will be between an opening brace ( { ) character and a closing brace ( } ) character as follows:

    :::image type="content" source="media/request-approval-failed/guid.png" alt-text="Screenshot of an example of GUID that follows the pageListId.":::

1. In the browser address bar, enter **https://contoso.sharepoint.com>/_layouts/15/ListEdit.aspx?List=<{GUID}>**.

    Example: `https://contoso.sharepoint.com/_layouts/15/listedit.aspx?List=d078a4df-3c52-4b23-8c28-e9561a243f0c`

    > [!NOTE]
    > In this address, represents the URL for the site collection in which you want to change the access requests (for example, `https://contoso.sharepoint.com`). And <{GUID}> represents the GUID that you copied in step 6.

1. On the **Settings** page, click **Permissions for this list**.

1. Make sure that the Owners group for the site is included in the list of permissions for the Access Requests list. If the Owners group for the site collection does not exist, click **Grant Permissions**, enter the name of the Owners group for the site in the **Share** dialog box, and then click **Share**.

1. Follow the steps in the "Add the user to the Owners group for the site" section to make sure that the user is included in the Owners group.

## More information

This issue occurs because only site collection administrators or users who are members of the Owners group for the site collection have permission to approve or decline pending requests in the **Access Requests** list. For situations in which users are members of the Owners group for the site, the Owners group must also have Full Control permissions to be able to access the **Access Requests** list.

For more information about how to set up and manage access requests, go to [Set up and manage access requests](https://support.office.com/article/set-up-and-manage-access-requests-94b26e0b-2822-49d4-929a-8455698654b3).

For more information about how to use the F12 developer tools, go to [Using the F12 developer tools](/previous-versions/windows/internet-explorer/ie-developer/samples/bg182326(v=vs.85)).

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
