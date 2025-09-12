---
title: Loop workspaces are unexpectedly stored in SharePoint Online sites
description: Describes an issue in which Loop workspaces are stored in SharePoint Online sites instead of SharePoint Embedded containers.
author: Cloud-Writer
ms.reviewer: derekliddell; meerak
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.service: loop
ms.custom: 
  - sap:Loop App\Loop App Client
  - CI191532
  - CSSTroubleshoot
appliesto: 
  - Microsoft Loop
ms.date: 07/08/2024
---

# Loop workspaces are unexpectedly stored in SharePoint Online sites

This article applies to customers who were notified by Microsoft that some of their new Microsoft Loop workspaces were created by using SharePoint Online sites instead of SharePoint Embedded containers as the storage locations.

If you’re a SharePoint administrator, and the loop workspaces that were created by your users are affected, you must identify the affected workspaces and inform the associated users. Then, depending on their requirements, users can choose either to continue using SharePoint Online sites as the storage option for their Loop workspaces or migrate their workspaces to use SharePoint Embedded containers.

## Identify affected Loop workspaces

This procedure must be performed by a SharePoint administrator. Follow these steps:

1. Get the site URLs that correspond to the affected SharePoint site IDs that are provided by Microsoft:

   1. Copy and paste the affected SharePoint site IDs into a text editor, such as Notepad. Then, save the file.
   1. Download the [SiteIDtoURL.ps1](https://pnp.github.io/script-samples/spo-get-site-list-ids/README.html?tabs=pnpps) PowerShell script.
   1. Open a PowerShell window that has administrative privileges.
   1. Navigate to the location where you saved *SiteIDtoURL.ps1*, and then run the script.
   1. Follow the prompts to provide the requested inputs, such as:
      - The SharePoint Online admin URL
      - The name of the file that you saved in step 1a

   After the script finishes, it returns a .csv file that contains the metadata for each SharePoint site, including the site URL.
1. Verify that the SharePoint site URLs in the .csv file are used to store Loop workspaces. Each SharePoint site must meet the following requirements:

   - The site's default **Documents** library contains a folder that's named *LoopAppData*, a subfolder that's named *.appdata*, and a file within the subfolder that has the *`.pod`* file name extension.
   - The site URL ends in a GUID. For example, `https://contoso.sharepoint.com/sites/c2e21339-b2f4-41fe-921c-bbb7bbc0f14a`.
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
   
For workspaces that are stored on a SharePoint Online site, the Recycle bin is not available in the Loop app. To access items that were deleted from these Loop workspaces, select **Recycle bin** in the Sharepoint site in which the workspaces are stored.

## Migrate your Loop workspace to a SharePoint Embedded container

If you have to migrate an Ideas workspace together with other Loop workspaces, begin by preparing the Ideas workspace for migration, and then process the other workspaces. Follow these steps:

1. Prepare an Ideas workspace for migration. If you don’t have to migrate an Ideas workspace, go to step 2.

   1. From any page in the **Ideas** workspace, select **Share** > **Page link**. Copy and paste the link in a temporary location. From this link, separate the part that is `https://<yourtenantname>.sharepoint.com/sites/<siteID>`. This URL is the link to the **Ideas** workspace. 
   1. Delete the existing **Ideas** workspace.
   1. Restart Loop to create a new **Ideas** workspace.
   1. A SharePoint administrator must restore the deleted **Ideas** workspace by [restoring the SharePoint site](/sharepoint/restore-deleted-site-collection) that was deleted together with it in step 1b.
   1. After the SharePoint site is restored, navigate to the old **Ideas** workspace by using the URL that was determined in step 1a: `https://<yourtenantname>.sharepoint.com/sites/<siteID>`.
   1. Follow steps 6 to 9 to migrate all content from the old **Ideas** workspace to the new **Ideas** workspace.
1. Rename the existing Loop workspace. For example, rename the *Project* workspace to *ProjectOLD*.
1. Create a new Loop workspace by using the original name, such as *Project*.
1. Open the new workspace in a separate browser tab next to the existing workspace.
1. Add all members of the existing workspace to the new workspace:
   1. Under the name of the workspace, select **Workspace member(s)**.

      :::image type="content" source="./media/loop-workspace-unexpectedly-stored-in-sharepoint-online-site/select-workspace-member.png" alt-text="Screenshot of the workspace member link below the name of the workspace.":::
   1. In the **Invite members with name or email** box, enter the name or email of the members that you want to add, and then select **Invite**.

      :::image type="content" source="./media/loop-workspace-unexpectedly-stored-in-sharepoint-online-site/add-members.png" alt-text="Screenshot of the dialog box to invite members to a workspace.":::
1. Copy all the content from the existing workspace to the new workspace:
   1. In the existing workspace, expand all the pages so that they're visible.
   1. In the new workspace, create the same pages.
   1. Copy the content of each page in the existing workspace to the corresponding newly created page in the new workspace.
1. For each page in the new workspace, make sure that its sharing permissions match the permissions of the corresponding page in the existing workspace. To check or change the sharing permissions for a page, select **Share** > **Page link** > **Settings**.
1. (Optional) Identify all the pages that are in the existing workspace that were shared to other locations. Replace the content of each page with a link to the corresponding page in the new workspace.<br/><br/>
**Note**: The links to shared content in the existing workspace will stop working after the existing workspace is deleted. If you want to preserve the shared links to the content, perform this step.<br/><br/>
   To determine whether a page has been shared, select the **Shared locations** button, as shown in the following screenshot. 

   :::image type="content" source="./media/loop-workspace-unexpectedly-stored-in-sharepoint-online-site/shared-locations.png" border="false" alt-text="Screenshot of the Shared locations button.":::

   If the page is shared, you'll see other locations listed in addition to the location of the source in the Loop workspace. 
   For each page that's shared, such as Page A, verify that all content in Page A in *ProjectOLD* has been copied to Page A in *Project*. Then, follow these steps:
   1. In Page A in *Project*, select **Share** > **Page link**.
   1. In Page A in *ProjectOLD*, remove all content, and then paste the link that you copied in step 8a.
1. Replicate the links to content outside the Loop workspace that are in the existing workspace to the new workspace. For each link, follow these steps:
   1. Navigate to the page that has the link in the existing workspace.
   1. Copy the link:
       - If the page has a shortcut arrow in the lower right corner, select the **Settings and more** button (…), and then select **Copy Link**.

         :::image type="content" source="./media/loop-workspace-unexpectedly-stored-in-sharepoint-online-site/copy-link.png" alt-text="Screenshot of the context menu that shows the Copy Link option.":::
       - If the page has a hyperlink symbol in the lower right corner, select the **Settings and more** button (…), and then select **Share Page Link**.

         :::image type="content" source="./media/loop-workspace-unexpectedly-stored-in-sharepoint-online-site/share-page-link.png" alt-text="Screenshot of the context menu that shows the Share Page Link option.":::
   1. Navigate to the corresponding page in the new workspace, select the plus sign (+) that's next to the name of the workspace in the navigation menu on the left, and then select **New link**. In the **Address** field, paste the link that you copied in step 9b, and then select **Add**.
   1. Arrange the newly created link to match the structure of the page in the existing workspace.

After you complete the migration, wait for 90 days, and then delete the old workspace.
