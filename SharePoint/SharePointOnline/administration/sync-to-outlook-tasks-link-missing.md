---
title: Sync to Outlook button and Tasks link are missing
description: This article describes an issue where the Sync to Outlook button and the Tasks link are missing in SharePoint Online, and provides a solution.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# The "Sync to Outlook" button and the "Tasks" link are missing in SharePoint Online

## Problem

In Microsoft SharePoint Online, the following options are missing:

- The **Sync to Outlook** button in any SharePoint Online tasks list.
   
  :::image type="content" source="media/sync-to-outlook-tasks-link-missing/sync-to-outlook.png" alt-text="Screenshot of the Sync to Outlook button in the SharePoint Online tasks list." border="false":::

- The **Tasks** link in the **About me** section of the user profile page.

  :::image type="content" source="media/sync-to-outlook-tasks-link-missing/tasks-link-about-me-section.png" alt-text="Screenshot of the Tasks link in the About me section." border="false":::

- The **Sync to Outlook** button is present on the personal site tasks list but the control is disabled.

## Solution

If you want to continue using your **Tasks** page, you have to manually restore the link to your personal site. To do this, follow these steps:

1. In Microsoft 365, click your profile picture, and then click **About me**.

   :::image type="content" source="media/sync-to-outlook-tasks-link-missing/about-me.png" alt-text="Screenshot to select the About me item after selecting the profile picture." border="false":::

1. On the **Quick Launch** bar, click **EDIT LINKS**.

   :::image type="content" source="media/sync-to-outlook-tasks-link-missing/edit-links.png" alt-text="Screenshot to select the Edit Links option on the Quick Launch bar." border="false":::

1. Click **link**.

   :::image type="content" source="media/sync-to-outlook-tasks-link-missing/add-link.png" alt-text="Screenshot to click the link option in Microsoft 365." border="false":::

1. In the **Text to display** box, type Tasks.

1. In the Address box, type the following URL. Replace the placeholder text by using information that's specific to your account.

    `https://CompanyName-my.sharepoint.com/personal/UserName_CompanyName_onmicrosoft_com/AllTasks.aspx`
    
    For example, the URL for user SaraD at Contoso will resemble the following:
    
    `https://contoso-my.sharepoint.com/personal/sarad_contoso_onmicrosoft_com/AllTasks.aspx`
    
    :::image type="content" source="media/sync-to-outlook-tasks-link-missing/add-a-link-example.png" alt-text="Screenshot shows an example in the Add a link dialog box." border="false":::

1. Click **OK**, and then click **Save** to save your changes.

   :::image type="content" source="media/sync-to-outlook-tasks-link-missing/save-link.png" alt-text="Screenshot to select the Save button to save the changes." border="false":::

## More information

The **Tasks** menu option has been removed from SharePoint Online. Additionally, the **Sync to Outlook** button on the personal site **Tasks** page is no longer available. The button may be present in the ribbon but the control is unavailable and doesn't function.

The personal **Tasks** page will also continue to be available for one year following the announcement that was made on September 4, 2014. After that time, this functionality will be removed and will no longer be available or supported. 

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
