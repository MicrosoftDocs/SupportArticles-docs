---
title: Near-duplicate items aren't listed in SharePoint Online or SharePoint Server 2013 on-premises search results
description: Describes an issue in which near-duplicate items aren't listed in SharePoint Online or SharePoint Server 2013 on-premises search results.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.custom: 
  - sap:Search\Syntex, Queries and Results
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
  - SharePoint Server 2013
ms.date: 12/17/2023
---

# Near-duplicate items aren't listed in SharePoint Online or SharePoint Server 2013 on-premises search results

## Problem

In SharePoint Online or SharePoint Server 2013 on-premises, you search for an item that has a near-duplicate file. Both files are located in SharePoint. When you view the search results, only one of the items is returned.

## Solution

To resolve this issue, enable the **Show View Duplicates link** option, or change the query rules to show duplicates on the search center page. To do this, follow these steps:

1. Browse to the search center by searching the **Everything** scope.

2. Click the gear icon, and then click **Edit** page.

3. Click the drop-down arrow in the upper-right corner of the **Search Results** Web Part, and then click **Edit Web Part**.

4. Use one of the following methods, depending on your preference:

   - To show the **View Duplicates** link: In the **Search Results** Web Part properties box, expand the **Settings** section in the **Properties for Search Results** section. Then, select the **Show View Duplicates link** check box, and then click **OK**.

   - To enable **Don't Remove Duplicates**: In the **Search Results** Web Part properties box, click **Change query** in the **Properties for Search Results**. Click the **SETTINGS** tab. In the **Remove Duplicates** section, set the value to **Don't Remove Duplicates**, and then click **OK**. Then, click **OK** in the Web Part properties box.

5. After you change the search results page, click **Check it in** on the ribbon, and then click **Continue**.

6. Click **Publish this draft** on the ribbon to publish the page to users.

**NOTE** You cannot change the site collection search page by using these steps in SharePoint Online. These steps apply only to the Search Center site.

## More information

For more information about the Search Center in SharePoint Online, see [Manage the Search Center in SharePoint Online](https://support.office.com/article/manage-the-search-center-in-sharepoint-online-174d36e0-2f85-461a-ad9a-8b3f434a4213).

For more information about the Search Center in SharePoint Server 2013, see [Set up a Search Center in SharePoint Server](/SharePoint/search/set-up-a-search-center).

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
