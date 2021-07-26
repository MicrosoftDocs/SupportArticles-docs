---
title: Error 404 File/Page not found in OneDrive or SharePoint
description: How to troubleshoot Error 404 when trying to view content in OneDrive or SharePoint.
ms.author: Bryan Petersen
author: v-matham
manager: dcscontentpm
ms.date: 7/26/2021
audience: Admin
ms.topic: article
ms.service: sharepoint-online
localization_priority: Normal
search.appverid:
- SPO160
- MET150
appliesto:
- SharePoint Online
ms.custom: 
- CI 153762
- CSSTroubleshoot 
ms.reviewer: salarson
---

# Error: 404 File/Page not found in OneDrive or SharePoint

## Symptom

When you try to access a site, file, or group in SharePoint or OneDrive, you encounter the following error:
> Error 404: File/Page not found

## Cause

The error occurs because the site, file, or group has been renamed, moved, or deleted.

## Resolution

Use the Search feature to check if the file or site has been moved.

If you can’t find it using Search, check with your SharePoint administrator. See [How do I find my Microsoft 365 admin?](https://support.microsoft.com/office/how-do-i-find-my-microsoft-365-admin-59b8e361-dbb6-407f-8ac3-a30889e7b99b) for more information.

## Actions for administrators

Try to locate the site or file by using the following methods:
<br/><br/>
<details>
<summary><b>Check the site recycle bin</b></summary>

If the site home page was deleted, follow these steps:
1. Browse to the site recycle bin by pasting this url into your browser: `https://tenantname.sharepoint.com/sites/sitename/_layouts/15/RecycleBin.aspx?view=5`

**Important**: Remember to replace *tenantname* with your organization's name and *sitename* with the name of the site missing a home page.

1. The default name of the page is *Home.aspx*, but it may be something different if you've replaced the default home page.
1. Highlight the file and select **Restore**.

If you were not able to find the file in the recycle bin, it may have moved to the **Second-stage recycle bin**.

1. You should see **Can't find what you're looking for? Check the Second-stage recycle bin** at the bottom of the recycle bin page.
1. Select **Second-stage recycle bin**.
1. Highlight the file and select **Restore**. 

If the page is not found in the second stage recycle bin, it has been permanently deleted.

For files or other pages that might have been deleted, see [Restore items in the recycle bin that were deleted from SharePoint or Teams](https://support.microsoft.com/office/restore-items-in-the-recycle-bin-that-were-deleted-from-sharepoint-or-teams-6df466b6-55f2-4898-8d6e-c0dff851a0be).

For more information, see the following pages:
- [Manage the Recycle Bin of a SharePoint site](https://support.microsoft.com/office/manage-the-recycle-bin-of-a-sharepoint-site-8a6c2198-910e-42dc-9a9c-bc5bc4f327da)
- [Use a different home page for your SharePoint home page](https://support.microsoft.com/office/use-a-different-page-for-your-sharepoint-site-home-page-35a5022c-f84a-455d-985e-c691ab5dfa17)
</details>
<br/>
<details>
<summary><b>Check the Deleted sites page</b></summary>

**For SharePoint**

The site might have been deleted. If so, restore the deleted site from the new SharePoint admin Center.

1. Go to the [Deleted sites](https://admin.microsoft.com/sharepoint?page=recycleBin&modern=true) page.
1. Select the site to restore.
1. Select **Restore**.

**Important**: If the deleted site was the root (top-level) SharePoint site, you’ll need restore the site and then replace the site using the steps in Replace your root site.

**For OneDrive**

For more information, see [Restore a deleted OneDrive](/onedrive/restore-deleted-onedrive).
</details>

<br/>
<details>
<summary><b>Check if the site was redirected</b></summary>

If the user is trying to access the site from a saved Site URL or link to a specific Site URL, it’s possible the Site URL was either changed/moved or the site was deleted.

1. If the Site URL was changed, then a site redirect should’ve been created. For more information, see [Manage site redirects](/sharepoint/manage-site-redirects).

**Important:** 
- If the site was removed using the steps [To remove a redirect](/sharepoint/manage-site-redirects#to-remove-a-redirect) the Error: 404 can occur.
- See the “To get a list of all redirects” section of [Manage site redirects](/sharepoint/manage-site-redirects) to determine which sites have changed URLs.

1. If the Site was deleted, it can be restored from the SharePoint admin center. For more info, see [Restore deleted sites](/sharepoint/restore-deleted-site-collection).
</details>
<br/>
<details>
<summary>Check if the Home Page is checked out</summary>

If the Home Page is checked out, you might encounter Error 404. Check the Home Page back in, and see if the error stops.
</details>