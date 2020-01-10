---
title: Sync to Outlook button and Tasks link are missing
description: This article describes an issue where the Sync to Outlook button and the Tasks link are missing in SharePoint Online, and provides a solution.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: sharepoint-server-itpro
ms.custom: CSSTroubleshoot
ms.topic: article
ms.author: v-six
appliesto:
- SharePoint Online
---

# The "Sync to Outlook" button and the "Tasks" link are missing in SharePoint Online

## Problem

In Microsoft SharePoint Online, the following options are missing:

- The **Sync to Outlook** button in any SharePoint Online tasks list.
   
  ![sync to outlook](./media/sync-to-outlook-tasks-link-missing/sync-to-outlook.png)

- The **Tasks** link in the **About me** section of the user profile page.

  ![Tasks link in the About me section](./media/sync-to-outlook-tasks-link-missing/tasks-link-about-me-section.jpg)

- The **Sync to Outlook** button is present on the personal site tasks list but the control is disabled.

## Solution

If you want to continue using your **Tasks** page, you have to manually restore the link to your personal site. To do this, follow these steps:

1. In Office 365, click your profile picture, and then click **About me**.

   ![About me in Office 365](./media/sync-to-outlook-tasks-link-missing/about-me.jpg)

1. On the **Quick Launch** bar, click **EDIT LINKS**.

   ![Edit Links link on the Quick Launch bar](./media/sync-to-outlook-tasks-link-missing/edit-link.jpg)

1. Click **link**.

   ![Link for adding a link](./media/sync-to-outlook-tasks-link-missing/add-link.png)

1. In the **Text to display** box, type Tasks.

1. In the Address box, type the following URL. Replace the placeholder text by using information that's specific to your account.

    https://**CompanyName**-my.sharepoint.com/personal/UserName_**CompanyName**_onmicrosoft_com/AllTasks.aspx
    
    For example, the URL for user SaraD at Contoso will resemble the following:
    
    https://contoso-my.sharepoint.com/personal/sarad_contoso_onmicrosoft_com/AllTasks.aspx
    
    ![Add a link dialog box](./media/sync-to-outlook-tasks-link-missing/add-link-dialog.png)

1. Click **OK**, and then click **Save** to save your changes.

   ![Save button](./media/sync-to-outlook-tasks-link-missing/save-link.png)

## More information

The **Tasks** menu option has been removed from SharePoint Online. Additionally, the **Sync to Outlook** button on the personal site **Tasks** page is no longer available. The button may be present in the ribbon but the control is unavailable and doesn't function.

The personal **Tasks** page will also continue to be available for one year following the announcement that was made on September 4, 2014. After that time, this functionality will be removed and will no longer be available or supported. 

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
