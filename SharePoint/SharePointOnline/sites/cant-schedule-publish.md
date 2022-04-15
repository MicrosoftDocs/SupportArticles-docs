---
title: Unable to schedule page publishing after changing a content type
description: The scheduling section of a page is blank after you edit its content type in the SharePoint admin center.
author: paotten
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
  - CI 162694
ms.author: v-matthamer
appliesto: 
  - SharePoint Online
ms.date: 4/15/2022
---

# Unable to schedule page publishing after changing a content type

When [page scheduling](https://support.microsoft.com/office/schedule-a-sharepoint-page-or-news-post-to-go-live-at-a-specific-time-4b81873c-9bbc-4307-b7ea-7b6662ff1af2) is enabled in your SharePoint Online Pages library, a list field called *PublishStartDate*  is added to all content types in the Pages library.

If a content type is updated in the Content type gallery from the [SharePoint admin center](https://go.microsoft.com/fwlink/?linkid=2185219) and published to the site, the *PublishStartDate* field will no longer be present in the content type. Making changes to content types from the Content type gallery will overwrite any changes that have been made to those content types at the site level.  

When *PublishStartDate* isn’t present in the content type, you won’t be able to schedule publishing of pages of that content type. If you go to the page and select edit mode, the **Scheduling** section will be blank; instead of having elements such as the button to turn scheduling on or off or the **Publish at this time** option.

To restore the ability to schedule pages, use the following steps.

**Note** You'll need administrator privileges to resolve this issue. If you aren’t an administrator, contact your [Microsoft 365 Administrator](/microsoft-365/admin/add-users/about-admin-roles).

1. Go to your Content type hub. For example, `https://contoso.sharepoint.com/sites/contentTypeHub`

1. In the site navigation, select **Pages**.

1. In the Pages library, select **Scheduling**. In the **Scheduling** panel, change **Enable scheduling** to **On**.

1. Navigate to the [SharePoint admin center](https://go.microsoft.com/fwlink/?linkid=2185219).

1. Under **Content services**, select **Content type gallery**.

1. Select the **Site Page** content type.

1. Select **Publish**.

1. In **Manage Publishing**, select **Republish**, and then select **Save**.

1. Repeat steps 5 through 8 for any other content types that are affected.

After following the above steps, publishing of the pages with the affected content types can be scheduled.