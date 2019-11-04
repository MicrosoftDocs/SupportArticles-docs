---
title: Request approval failed when you process a pending request
description: This article describes an issue where "Access Denied" to Access Requests list or "Request approval failed" when you process a pending request, and provides a solution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: sharepoint-server-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- SharePoint Online
---

# "Access Denied" to Access Requests list or "Request approval failed" when you process a pending request

## Problem

You have a Microsoft SharePoint Online site on which the **Allow access requests** setting is enabled.

When users who have **Full Control** permissions to the site clicks **Access requests and invitations in Site Settings**, they receive the following error message:

**Access Denied.**

Also, when users browse to the **Access Requests** list and then click **Approve** or **Decline** for a pending request, they receive the following error message:

```adoc
Sending approval

Request approval failed
```

## Solution

To resolve this issue, users must be either site collection administrators or be members of the Owners group for the site. The Owners group must also have permissions to access the **Access Requests** list. Use the following solutions as appropriate for your specific configuration.

### Site collection administrator

If an affected user should be a site collection administrator, go to the following Microsoft website for more information about how to manage administrators for your sites:

[Manage site collection administrators](https://docs.microsoft.com/sharepoint/manage-site-collection-administrators)

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

1. As a user who has the **Manage Permissions Permission Level** on the affected site and who also has access to the **Access Requests** list (for example, a Site Collection administrator), browse to the **Access Requests** list in Internet Explorer.

1. Press F12 to open the F12 Developer Tools window.

1. Click the **Network** tab, and then press F5 to enable network traffic capturing.

1. Refresh the Access Requests page in Internet Explorer. After the page has loaded, press Shift+F5 to stop capturing network traffic.

1. In the Developer Tools window, double-click the first result in the URL list. This URL ends in "pendingreq.aspx."

1. In the Developer Tools window, click **Response body**.

1. In the search box, type **pagelistid:**, and then press Enter.

    > [!NOTE]
    > The search highlights the pageListId text.

1. Copy the GUID that follows the pageListId. The GUID will be between an opening brace ( { ) character and a closing brace ( } ) character as follows:

    {GUID}    

    > [!NOTE]
    > Include the opening and closing brace characters when you copy the GUID. This GUID is the identifier for the **SharePoint Online Access Requests** list for your organization.

1. In the browser address bar, enter https://<URL<URL of affected site, or site collection>/_layouts/15/ListEdit.aspx?List=<{GUID}>, and then press Enter.

    > [!NOTE]
    > In this address, <URL of affected site or site collection> represents the URL for the site collection in which you want to change the access requests (for example, https://contoso.sharepoint.com). And <{GUID}> represents the GUID that you copied in step 8.

1. On the **Settings** page, click **Permissions for this list**.

1. Make sure that the Owners group for the site is included in the list of permissions for the Access Requests list. If the Owners group for the site collection does not exist, click **Grant Permissions**, enter the name of the Owners group for the site in the **Share** dialog box, and then click **Share**.

1. Follow the steps in the "Add the user to the Owners group for the site" section to make sure that the user is included in the Owners group.

## More information

This issue occurs because only site collection administrators or users who are members of the Owners group for the site collection have permission to approve or decline pending requests in the **Access Requests** list. For situations in which users are members of the Owners group for the site, the Owners group must also have Full Control permissions to be able to access the **Access Requests** list.

For more information about how to set up and manage access requests, go to [Set up and manage access requests](https://support.office.com/article/set-up-and-manage-access-requests-94b26e0b-2822-49d4-929a-8455698654b3).

For more information about how to use the F12 developer tools, go to [Using the F12 developer tools](https://docs.microsoft.com/previous-versions/windows/internet-explorer/ie-developer/samples/bg182326(v=vs.85)).

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).

