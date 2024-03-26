---
title: Can't schedule page publishing after changing a content type
description: The scheduling section of a page is blank after you edit its content type in the SharePoint admin center.
author: helenclu
ms.author: luche
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Pages\Publish Page
  - CSSTroubleshoot
  - CI 162694
ms.reviewer: paotten
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# Can't schedule page publishing after changing a content type

When [page scheduling](https://support.microsoft.com/office/schedule-a-sharepoint-page-or-news-post-to-go-live-at-a-specific-time-4b81873c-9bbc-4307-b7ea-7b6662ff1af2) is enabled in your SharePoint Online Pages library, a list field that's named *PublishStartDate* is added to all content types in the Pages library.

If a content type is updated in the Content type gallery from the [SharePoint admin center](https://go.microsoft.com/fwlink/?linkid=2185219), and if it's published to the site, the **PublishStartDate** field will no longer be present in the content type. If you make changes to content types from the Content type gallery, this will overwrite any changes that were made to those content types at the site level.  

If **PublishStartDate** isn't present in the content type, you can't schedule page publishing of that content type. If you go to the page and select the edit mode, the **Scheduling** section will be blank. You expect that the section would contain such elements as the button to turn scheduling on or off and the **Publish at this time** option.

To restore the ability to schedule pages for the affected content types, follow these steps.

**Note** You must have administrator privileges to resolve this issue. If you aren't an administrator, contact your [Microsoft 365 administrator](/microsoft-365/admin/add-users/about-admin-roles).

1. Go to your Content type hub. For example, go to `https://contoso.sharepoint.com/sites/contentTypeHub`.

1. In the site navigation pane, select **Pages**.

1. In the Pages library, select **Scheduling**. In the **Scheduling** panel, change **Enable scheduling** to **On**.

1. Navigate to the [SharePoint admin center](https://go.microsoft.com/fwlink/?linkid=2185219).

1. Under **Content services**, select **Content type gallery**.

1. Select the **Site Page** content type.

1. Select **Publish**.

1. In **Manage Publishing**, select **Republish**, and then select **Save**.

1. Repeat steps 5 through 8 for any other content types that are affected.

**Note** It might take 15 minutes or more for the change to appear on all sites.
