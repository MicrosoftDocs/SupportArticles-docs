---
title: Loop workspaces are unexpectedly stored in SharePoint Online sites
description: Describes an issue in which Loop workspaces are stored in SharePoint Online sites instead of SharePoint Embedded containers.
author: helenclu
ms.reviewer: derekliddell; meerak
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.service: loop
ms.custom: 
  - sap: Loop App Client
  - CI191532
  - CSSTroubleshoot
appliesto: 
  - Microsoft Loop
ms.date: 06/27/2024
---

# Loop workspaces are unexpectedly stored in SharePoint Online sites

This article is relevant to customers who were notified by Microsoft that some of their new Microsoft Loop workspaces were created with the storage locations as SharePoint Online sites instead of SharePoint Embedded containers. 

If you’re an administrator and the loop workspaces created by your users were impacted, you need to identify the affected workspaces and inform the associated users. Then depending on their requirements, users can choose either to continue using SharePoint Online sites as the storage option for their Loop workspaces or migrate their workspaces to use SharePoint Embedded containers.

## Identify affected Loop workspaces

Use the following steps. They must be performed by a SharePoint administrator.

1. Convert the affected SharePoint site IDs provided by Microsoft to site URLs.

   1. Copy and paste the affected SharePoint site IDs into a text editor, such as Notepad. Then, save the file.
   1. Download the [SiteIDtoURL.ps1](https://github.com/pnp/powershell/blob/dev/samples/Site.Metadata.CSV/SiteIDtoURL.ps1) PowerShell script.
   1. Open a PowerShell window with administrator privileges.
   1. Navigate to the location where you saved *SiteIDtoURL.ps1* and run the script.
   1. As the script runs, follow the prompts to provide the requested inputs such as:
      1. The SharePoint Online admin URL.
      1. The file you saved in step 1a.

   After the script finishes running, it returns a .CSV file that contains the metadata for each SharePoint site, including the site URL.
1. Verify that the SharePoint site URLs in the .csv file are used to store Loop workspaces. Each SharePoint site must meet the following requirements:

   - The site's default **Documents** library contains a folder named *LoopAppData*, a subfolder with in named *.appdata*, a file within the subfolder with the *`.pod`* file extension.
   - The site URL ends with a GUID. For example, `https://contoso.sharepoint.com/sites/c2e21339-b2f4-41fe-921c-bbb7bbc0f14a`.
1. Determine the owners of each SharePoint site:

   1. In the [SharePoint admin center](https://go.microsoft.com/fwlink/?linkid=2185219), select **Sites** > **Active sites**.
   1. For each affected site, select the site, select the **Membership** tab, and then select the **Site owners** section. 

## Keep your Loop workspace on the SharePoint site 

You can continue to use the SharePoint Online site as the storage location for your Loop workspace. To access the site, use the following steps:

1. From a page in the Loop workspace, select **Share** > **Page link** to create a sharing link that's similar to the following example:

   `https://microsoft.sharepoint.com/:fl:/s/6405bb1e-d41b-4df2-a433-e7e3d60d7a2a`

   The last part of this URL is the site ID of the SharePoint site, such as `6405bb1e-d41b-4df2-a433-e7e3d60d7a2a`.
1. Navigate to the following URL to open the SharePoint site:

   `https://<yourtenantname>.sharepoint.com/sites/<siteID from step 1>`

   For example, `https://microsoft.sharepoint.com/sites/6405bb1e-d41b-4df2-a433-e7e3d60d7a2a`.
For workspaces that are stored on a SharePoint Online site, the Recycle bin is not available in the Loop app. To access items that were deleted from these Loop workspaces, select **Recycle bin** in the Sharepoint site where the workspaces are stored.

## Migrate your Loop workspace to a SharePoint Embedded container

If you need to migrate an Ideas workspace in addition to other Loop workspaces, begin by preparing the Ideas workspace for migration and then proceed with the other workspaces. Follow these steps:

1. Prepare an **Ideas** workspace for migration. If you don’t need to migrate an Ideas workspace, go to step 2.

   1. From any page in the **Ideas** workspace, select **Share** > **Page link**. Copy and paste the link in a temporary location. From this link, separate the part which is `https://<yourtenantname>.sharepoint.com/sites/<siteID>`. This URL is the link to the Ideas workspace. 
   1. Delete the existing **Ideas** workspace.
   1. Restart Loop to create a new **Ideas** workspace.
   1. A SharePoint administrator needs to restore the deleted **Ideas** workspace by [restoring the SharePoint site](/sharepoint/restore-deleted-site-collection) that was deleted along with it in step 1b.
   1. After the SharePoint site is restored, navigate to the old Ideas workspace by using the URL that was determined in step 1a: `https://<yourtenantname>.sharepoint.com/sites/<siteID>`.
   1. Follow steps 6 to 9 to migrate all content from the old **Ideas** workspace to the new **Ideas** workspace.
1. Rename the existing Loop workspace. For example, rename the *Project* workspace to *ProjectOLD*.
1. Create a new Loop workspace by using the original name, such as *Project*.
1. Open the new workspace in a separate browser tab next to the existing workspace.
1. Add all members of the existing workspace to the new workspace. To add members to a workspace, follow these steps:
   1. Under the name of the workspace, select **Workspace member(s)**.

      :::image type="content" source="./media/loop-workspace-unexpectedly-stored-in-sharepoint-online-site/select-workspace-member.png" alt-text="Screenshot of the workspace member link under the name of the workspace.":::
   1. In the dialog that pops up, enter the name or email of the members that you want to add, and then select **Invite**.

      :::image type="content" source="./media/loop-workspace-unexpectedly-stored-in-sharepoint-online-site/add-members.png" alt-text="Screenshot of the dialog of inviting members to a workspace.":::
1. Copy all content from the existing workspace to the new workspace:
   1. In the existing workspace, expand all pages to make sure that they're visible.
   1. In the new workspace, create the same pages.
   1. Copy the content of each corresponding page in the existing workspace to the newly created page in the new workspace.
1. For each page in the new workspace, make sure that its sharing permissions match the permissions of the corresponding page in the existing workspaces. To check or change the sharing permissions for a page, select **Share** > **Page link**, and then select **Settings**.
1. (Optional) If any links to pages in the existing workspace were shared, replace the content with a link to the corresponding page in the new workspace. For example, after you verify that all content of Page A in *ProjectOLD* has been copied to Page A in *Project*, follow these steps:
   1. In Page A in *Project*, select **Share** > **Page link**.
   1. In Page A in *ProjectOLD*, remove all content and paste the link you copied in step a.
1. Replicate the links in the existing workspace to the new workspace. Follow these steps for each page:
   1. Navigate to the page in the existing workspace.
   1. Copy the link:
       - If the page has a shortcut arrow in the lower right corner, select the ellipsis (…) icon, and then select **Copy Link**.

         :::image type="content" source="./media/loop-workspace-unexpectedly-stored-in-sharepoint-online-site/copy-link.png" alt-text="Screenshot of the context menu that shows the Copy Link option.":::
       - If the page has a hyperlink symbol in the lower right corner, select the ellipsis (…) icon, and then select **Share Page Link**.

         :::image type="content" source="./media/loop-workspace-unexpectedly-stored-in-sharepoint-online-site/share-page-link.png" alt-text="Screenshot of the context menu that shows the Share Page Link option.":::
   1. Navigate to the corresponding page in the new workspace, select the plus sign (+), and then select **New link**. In the **Address** field, paste the link that's copied in step b, and then select **Add**.
   1. Arrange the links to match the same structure as in the page of the existing workspace.

After you complete the migration, wait for 90 days or whatever time you consider appropriate, then delete the old workspace.

**Note**: After you delete the old workspace, any shared links to content in the old workspace will no longer work.
