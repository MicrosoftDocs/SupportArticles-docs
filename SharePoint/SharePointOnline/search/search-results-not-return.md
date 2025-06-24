---
title: SharePoint Online doesn't return search results
description: This article describes how to resolve an issue that SharePoint Online doesn't return search results
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - sap:Search\Syntex, Queries and Results
  - CSSTroubleshoot
appliesto: 
  - SharePoint Online
ms.date: 12/17/2023
---

# SharePoint Online doesn't return search results

## Problem

Consider the following scenario:

- You browse to a Microsoft SharePoint Online site.

- You perform a search by using one of the following methods:

    - You select the **This Site** scope in the **Search this site** box.
    
    - You use the **Find a file** box to search for a library.

In this scenario, you experience one of the following symptoms:

- No search results are returned for existing content.

- You receive the following error message:

    - **Sorry, something went wrong.**

- The search results are from an incorrect source, such as tags only or the Internet.

> [!NOTE]
> If in the first method in this scenario you select the **Everything** scope for your search, your results are returned as expected.

## Solution

To resolve this issue, make sure that your result sources (both at the site collection and at the site level) are configured by using the same out-of-the-box result source, such as Local SharePoint Results, or that you use the same custom result source that's copied from an out-of-the-box result source. We recommend that you do this because this issue is usually observed when you use certain custom result sources, such as Bing Result Source. 

To resolve this issue, follow these steps. 

### Check the Search Result Sources configuration for the site collection

1. Browse to the affected SharePoint Online site.

1. Click the gear icon for the **Settings** menu, and then click **Site settings**.

1. Under **Site Collection Administration**, click **Search Result Sources**, and then confirm that **Local SharePoint Results** has the check mark for **Default** assigned to it.

1. If the check mark isn't next to **Local SharePoint Results**, click the drop-down arrow for **Local SharePoint Results**, and then click **Set as Default**.

### If this issue occurs for a subsite, check the Result Sources configuration for the subsite

1. Browse to the affected SharePoint Online subsite.

1. Click the gear icon for the **Settings** menu, and then click **Site settings**.

1. Under **Search**, click **Result Sources**, and confirm that **Local SharePoint Results** has the check mark for **Default** assigned to it.

1. If the check mark isn't next to **Local SharePoint Results**, click the drop-down arrow for **Local SharePoint Results**, and then click **Set as Default**.

    :::image type="content" source="media/search-results-not-return/set-as-default.png" alt-text="Screenshot of the Set as Default option in the drop-down menu of Local SharePoint Results.":::

## More information

This issue occurs when SharePoint Online is configured to obtain search results from a source other than Local SharePoint Results. When the **Local SharePoint Results** setting isn't the default, results are returned from other sources instead. This issue doesn't affect Enterprise Search. (This is the option when you search by using the Everything scope.)

Still need help? Go to [SharePoint Community](https://techcommunity.microsoft.com/t5/sharepoint/ct-p/SharePoint).
