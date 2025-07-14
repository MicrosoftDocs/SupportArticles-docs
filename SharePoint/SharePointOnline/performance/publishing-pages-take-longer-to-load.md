---
title: SharePoint Online publishing pages take longer than expected to load
description: This article describes an issue where SharePoint Online publishing pages take longer than expected to load, and provides a solution.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Pages\Performance
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# SharePoint Online publishing pages take longer than expected to load

## Problem

Consider the following scenario:

- You have a SharePoint Online publishing page that was created by using either the **Publishing Portal** or **Enterprise Wiki** template.

- When you browse to a publishing page, the page takes longer than expected to load.

## Solution

To resolve this problem use the Term Store Management tool to remove unnecessary pages from the navigation menu. To do this, follow these steps:

Browse to the affected SharePoint Online site collection.

1. Click the gear icon for the **Settings** menu, and then click **Site settings**.

1. In the **Site Administration** section, click **Term store management**.

1. In the **TAXONOMY TERM STORE** section, expand the taxonomy for **Site Collection**, and then expand the **Site Navigation** section.

1. Click the affected page that you want to remove navigation for, and then click the **NAVIGATION** tab.

1. Clear the **Show in Global Navigation Menu** and **Show in Current Navigation Menu** check boxes, and then click **Save**.

    :::image type="content" source="media/publishing-pages-take-longer-to-load/select-visibility-in-menus-option.png" alt-text="Screenshot of the Navigation tab. The Show in Global Navigation Menu and Show in Current Navigation Menu boxes are unchecked.":::

> [!NOTE]
> You may also use the EDIT LINKS feature on the page to remove the navigation links. For more information, go to [Customize the navigation on your team site](https://support.office.com/article/customize-the-navigation-on-your-sharepoint-site-3cd61ae7-a9ed-4e1e-bf6d-4655f0bf25ca?ocmsassetID=HA103532378&CorrelationId=f200f54d-a47d-472e-8356-49934f9b1222).

You can also clear the setting to add new pages to navigation automatically from the Navigation Settings page. This prevents the issue from recurring in the future. To do this, follow these steps:

1. Browse to the affected SharePoint Online site collection.

1. Click the gear icon for the **Settings** menu, and then click **Site settings**.

1. In the **Site Administration** section, click **Navigation**.

1. In the **Managed Navigation: Default Page Settings** section, clear the **Add new pages to navigation automatically** option, and then click **OK**.

## More information

This issue may occur if you have many Publishing Pages in your Pages Library. By default, new Publishing Pages are added to the Pages Library, and user permissions for all pages in the Pages Library are validated for the navigation menu when a page loads. The page may be performing many unnecessary security checks for pages that you don't have to include on the navigation menu.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
