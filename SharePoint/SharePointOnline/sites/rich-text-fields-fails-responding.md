---
title: Rich Text fields don't respond when using IE to access a SharePoint site
description: When you use Internet Explorer to access a SharePoint Online or SharePoint Server 2013 site that contains a Rich Text field, the Rich Text field doesn't respond.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: CSSTroubleshoot
appliesto: 
  - SharePoint Online
  - SharePoint Server
ms.date: 12/17/2023
---

# Rich Text fields don't respond when you use Internet Explorer to access a SharePoint site

## Problem

When you use Internet Explorer to access a SharePoint Online or SharePoint Server 2013 site that contains a Rich Text field, the Rich Text field doesn't respond.

## Solution

To resolve this issue, add your SharePoint site or sites to the **Trusted sites** zone in Internet Explorer. Also make sure that the **HtmlDlgSafeHelper Class** add-on is enabled.

To add your SharePoint Online site to the trusted zone, follow these steps:

1. Start Internet Explorer.
1. Depending on your version of Internet Explorer, do one of the following:

   - On the **Tools** menu, click **Internet options**.
   - Click the gear icon, and then click **Internet options**.

   :::image type="content" source="media/rich-text-fields-fails-responding/internet-options.png" alt-text="Screenshot of the Internet options item in the Setting menu of Internet Explorer.":::

1. Click the **Security** tab, click **Trusted sites**, and then click **Sites**.

   :::image type="content" source="media/rich-text-fields-fails-responding/trusted-sites.png" alt-text="Screenshot of the Trusted Sites setting in the Security tab of Internet Options.":::

1. In the Add this website to the zone box, type the URL for the SharePoint Online site that you want to add to the Trusted sites zone, and then click Add. For example, type https://*contoso*.sharepoint.com. (Here, the *contoso* placeholder represents the domain that you use for your organization.) Repeat this step for any additional sites that you want to add to this zone.

   :::image type="content" source="media/rich-text-fields-fails-responding/adding-site.png" alt-text="Screenshot of adding the example website to the Trusted sites zone." border="false":::

1. After you have added each site to the **Websites** list, click **Close**, and then click **OK**.

To enable the **HtmlDlgSafeHelper Class** add-on, follow these steps:

1. In Internet Explorer, click the gear icon for the **Tools** menu, and then click **Manage add-ons**.
1. In the list of add-ons, locate **HtmlDlgSafeHelper Class**.
1. If the **Status** for this add-on is set to **Disabled**, select the add-on, and then click **Enable**.

## More information

Be aware that the first time the **Font** control is clicked, it may not display anything, and you might have to click it again. After the client-side cache contains the Rich Text controls, it should work consistently. This behavior is caused by a disabled ActiveX control in Internet Explorer that prevents ActiveX controls from running. Or, it may occur after the cache for Internet Explorer is cleared.

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
