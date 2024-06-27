---
title: Loop workspaces are unexpectedly stored in SharePoint Online sites
description: Resolves an issue in which Loop workspaces are stored in SharePoint Online sites instead of SharePoint Embedded containers.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.service: loop
ms.custom: 
  - CI191532
  - CSSTroubleshoot
appliesto: 
  - Microsoft Loop
ms.date: 06/27/2024
---

# Loop workspaces are unexpectedly stored in SharePoint Online sites

When you create Microsoft Loop workspaces, they're stored in SharePoint Online sites instead of SharePoint Embedded containers.

To fix this issue, follow these steps.

## Step 1: Identify affected Loop workspaces

**Note**: This step must be performed by a SharePoint administrator.

Follow these steps:

1. Convert affected SharePoint site IDs to site URLs.

   1. Copy the affected SharePoint site IDs that are provided by Microsoft and paste them into a text editor, such as Notepad. Then, save the file.
   1. Download the [SiteIDtoURL.ps1](https://github.com/pnp/powershell/blob/dev/samples/Site.Metadata.CSV/SiteIDtoURL.ps1) PowerShell script.
   1. Open a PowerShell window with administrator privileges.
   1. Navigate to the location where you saved *SiteIDtoURL.ps1* and run the script.
   1. Follow the prompt to enter your SharePoint Online admin URL, such as `https://contoso-admin.sharepoint.com`.
   1. When the open file dialog pops up, select the file you saved in step a.

   When the script finishes, it returns a CSV file that contains metadata for each SharePoint site, including the site URL.
1. Identify the SharePoint sites that are used to store Loop workspaces. For each SharePoint site:

   - Check whether the site's default **Documents** library contains a *LoopAppData* folder and a *`.pod`* file.
   - Check whether the site URL ends with a GUID, for example, `https://contoso.sharepoint.com/sites/c2e21339-b2f4-41fe-921c-bbb7bbc0f14a`.
1. Determine the site owners:

   1. In the [SharePoint admin center](https://go.microsoft.com/fwlink/?linkid=2185219), select **Sites** > **Active sites**.
   1. For each affected site that's identified in step 2, select the site, select the **Membership** tab, and then select **Site owners**.

## Step 2: Keep the workspaces on SharePoint sites or migrate the workspaces

Depending on your business needs, Loop users can keep the workspaces on SharePoint Online sites or migrate them to SharePoint Embedded containers.

### Option 1: Keep the workspace on SharePoint Online sites

To access the SharePoint site where the workspace is stored, follow these steps:

1. From a page in the Loop workspace, select **Share** > **Page link** to create a sharing link that's similar to the following example:

   `https://microsoft.sharepoint.com/:fl:/s/6405bb1e-d41b-4df2-a433-e7e3d60d7a2a`

   The last part of this URL is the SharePoint site ID, such as `6405bb1e-d41b-4df2-a433-e7e3d60d7a2a` in the example.
1. Access the SharePoint site by using the following URL:

   `https://<yourtenantname>.sharepoint.com/sites/<siteID from step 1>`

   For example, `https://microsoft.sharepoint.com/sites/6405bb1e-d41b-4df2-a433-e7e3d60d7a2a`.
1. To access items that are deleted from the Loop app, select **Recycle bin**.

### Option 2: Migrate the workspace to SharePoint Embedded containers

To migrate a workspace, follow these steps:

1. If you need to migrate the **Ideas** workspace, use the following steps. Otherwise, go to step 2.

   1. Determine the link to the **Ideas** workspace. To do so, from any page in the **Ideas** workspace, select **Share** > **Page link**. Paste the link somewhere and keep the `https://<yourtenantname>.sharepoint.com/sites/<siteID>` part, which is the link to the workspace.
   1. Delete the existing **Ideas** workspace.
   1. Restart Loop to create a new **Ideas** workspace.
   1. Ask the administrator to restore the deleted **Ideas** workspace by [restoring the deleted site](/sharepoint/restore-deleted-site-collection).
   1. Access the SharePoint site by using the URL that's determined in step a.
   1. Follow step 6 to 9 to migrate all content from the old **Ideas** workspace to the new **Ideas** workspace.
1. Rename the existing workspace. For example, rename the *Project* workspace to *ProjectOLD*.
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
