---
title: Error 404 File/Page not found in OneDrive or SharePoint
description: How to troubleshoot Error 404 when you try to view content in OneDrive or SharePoint.
ms.author: luche
author: helenclu
manager: dcscontentpm
ms.date: 12/17/2023
audience: Admin
ms.topic: troubleshooting
search.appverid: 
  - SPO160
  - MET150
appliesto: 
  - SharePoint Online
ms.custom: 
  - sap:Pages\Error 404: Page Unavailable
  - CI 153762
  - CI 154562
  - CSSTroubleshoot
ms.reviewer: salarson
---

# "Error: 404 File/Page not found" in OneDrive or SharePoint

## Symptoms

When you try to access a site, file, or group in Microsoft SharePoint or OneDrive, you receive the following error message:
> Error 404: File/Page not found

## Cause

This error occurs because the site, file, or group was renamed, moved, or deleted.

## Resolution

If you can't find the content that you're looking for, check with your SharePoint administrator. For more information, see [How do I find my Microsoft 365 admin?](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b).

## Actions for administrators

Try to locate the site or file by using the following methods:
<br/><br/>
<details>
<summary><b>Restore a deleted home page</b></summary>

If the site home page was deleted, follow these steps:

1. Browse to the site recycle bin by pasting this URL into the browser: `https://<tenantname>.sharepoint.com/sites/<sitename>/_layouts/15/RecycleBin.aspx?view=5`

   > **Important**: In the path, replace *tenantname* with your organization's name and *sitename* with the name of the site that's missing a home page.

   > **Note:** The default name of the page is *Home.aspx*. However, it might be something different if you've replaced the default home page.

1. Highlight the file, and select **Restore**.

If you did not find the file in the recycle bin, it may have moved to the **Second-stage recycle bin**.

1. You should see **Can't find what you're looking for? Check the Second-stage recycle bin** at the bottom of the recycle bin page. Select **Second-stage recycle bin**.
1. Highlight the file, and select **Restore**.

If you did not find the page in the second stage recycle bin, this indicates that it was permanently deleted.

For files or other pages that might have been deleted, see [Restore items in the recycle bin that were deleted from SharePoint or Teams](https://support.microsoft.com/office/restore-items-in-the-recycle-bin-that-were-deleted-from-sharepoint-or-teams-6df466b6-55f2-4898-8d6e-c0dff851a0be).

For more information, see the following pages:
- [Manage the Recycle Bin of a SharePoint site](https://support.microsoft.com/office/manage-the-recycle-bin-of-a-sharepoint-site-8a6c2198-910e-42dc-9a9c-bc5bc4f327da)
- [Use a different home page for your SharePoint home page](https://support.microsoft.com/office/use-a-different-page-for-your-sharepoint-site-home-page-35a5022c-f84a-455d-985e-c691ab5dfa17)
</details>
<br/>
<details>
<summary><b>Check whether the site was deleted</b></summary>

**For SharePoint**

The site might have been deleted. If so, restore the deleted site from the new SharePoint admin center.

1. Go to the [Deleted sites](https://admin.microsoft.com/sharepoint?page=recycleBin&modern=true) page.
1. Select the site to restore.
1. Select **Restore**.

**Important**: If the deleted site was the root (top-level) SharePoint site, you'll have to first restore the site and then replace it by using the steps in [Replace your root site](../sites/url-that-resides-under-root-site-collection-is-broken.md).

**For OneDrive**

For more information, see [Restore a deleted OneDrive](/onedrive/restore-deleted-onedrive).
</details>

<br/>
<details>
<summary><b>Check whether the site was redirected</b></summary>

If the user is trying to access the site from a saved site URL or a link to a specific site URL, it's possible that the site URL was changed or that the site was moved or deleted.

If the Site URL was changed, a site redirect page should have been created. For more information, see [Manage site redirects](/sharepoint/manage-site-redirects).

**Important:**
- If the site was removed by using the steps in [To remove a redirect](/sharepoint/manage-site-redirects#to-remove-a-redirect), a "404" error can occur.
- To determine which sites have new URLs, see the "To get a list of all redirects" section of [Manage site redirects](/sharepoint/manage-site-redirects).

If the site was deleted, you can restore it from the SharePoint admin center. For more information, see [Restore deleted sites](/sharepoint/restore-deleted-site-collection).
</details>
