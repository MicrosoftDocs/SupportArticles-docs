---
title: Can't open an InfoPath Filler form published to a SharePoint Online site
description: InfoPath cannot open the selected form because of an error in the form's code error when trying to open an InfoPath Filler form that's published to a SharePoint Online site with the error.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Sites\Classic Publishing
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# "InfoPath cannot open the selected form" error when you try to open an InfoPath Filler form that is published to a SharePoint Online site

## Problem

When you try to open an InfoPath Filler form that's published to a SharePoint Online site, you receive the following error message:

**InfoPath cannot open the selected form because of an error in the form's code. Policy settings prevent opening Internet forms with managed code. To fix this problem, contact your system administrator.**

This problem occurs when the following conditions are true:

- The form contains code.
- The trust level is set to **Full Trust** in InfoPath Designer. To check this setting in InfoPath Designer 2013, click the **File** tab, click **Form Options**, click **Security and Trust**, and then review the **Security Level** section.

## Solution

To resolve this issue, add the SharePoint site that contains the InfoPath Filler form to your Trusted Sites in Internet Explorer. To do this, follow these steps:

1. Start Internet Explorer.
1. Depending on your version of Internet Explorer, take one of the following actions:

   - Click the **Tools** menu, and then click **Internet options**.
   - Click the gear icon, and then click **Internet options**.

   :::image type="content" source="media/fails-opening-infopath-filler-form/internet-options.png" alt-text="Screenshot to select the Internet options item." border="false":::

1. Click the **Security** tab, click **Trusted sites**, and then click **Sites**.

   :::image type="content" source="media/fails-opening-infopath-filler-form/trusted-sites.png" alt-text="Screenshot shows steps to select the Sites option under the Security tab." border="false":::

1. In the **Add this website to the zone** box, type the URL for the SharePoint Online site that you want to add to the **Trusted sites** zone, and then click **Add**. For example, type https://**contoso**.sharepoint.com. (Here, the placeholder **contoso** represents the domain that you use for your organization.) Repeat this step for any additional sites that you want to add to this zone.

   :::image type="content" source="media/fails-opening-infopath-filler-form/adding-site.png" alt-text="Screenshot shows an example to add the U R L to the Trusted sites zone." border="false":::

1. After you have added each site to the **Websites** list, click **Close**, and then click **OK**.

## More information

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
