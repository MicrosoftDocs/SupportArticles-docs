---
title: SharePoint site not listed in trigger or action
description: Resolution for SharePoint site not listed in trigger or action in Microsoft Flow.
ms.reviewer:  
ms.topic: troubleshooting
ms.date: 
---
# SharePoint site not listed in trigger or action in Microsoft Flow

This article provides resolutions for the issue that a SharePoint site is not listed in trigger or action in Microsoft Flow.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4527556

## Symptoms

In Flow, you can select a SharePoint site for certain SharePoint triggers or actions. You may open this dropdown and not be able to find your specific SharePoint site.

## Cause

Users may not be able to see their specific SharePoint site listed in the SharePoint operation dropdown list in Flow. The list is generated from the user's most frequently used SharePoint sites. You can see your most frequently used SharePoint sites [here](https://microsoft.sharepoint.com) under **Sites**, under the tab **Frequent**.

Therefore, if the user does not frequently use this SharePoint site, it will not show up in this list.

## Resolution

Users can still use SharePoint sites not listed by typing in the using the desired SharePoint site URL as a custom value.

### Resolution 1 - Select Enter custom value

:::image type="content" source="media/sharepoint-site-not-listed-in-trigger-or-action/create-item.png" alt-text="SharePoint screenshot in Flow":::

### Resolution 2 - Get the SharePoint site URL

You can find the SharePoint site URL by going to the desired site in SharePoint and copying the url from the browser. Make sure you have access to the SharePoint site.

You can also use any URL from your SharePoint site. The Flow designer will clean up the URL once it is pasted in.

### Resolution 3 - Type the SharePoint URL directly into the dropdown text box

:::image type="content" source="media/sharepoint-site-not-listed-in-trigger-or-action/long-site-address.png" alt-text="SharePoint screenshot dropdown long url":::

The Flow designer will clean up any URL and point it directly to the SharePoint site.

:::image type="content" source="media/sharepoint-site-not-listed-in-trigger-or-action/short-site-address.png" alt-text="SharePoint screenshot dropdown short url":::

The dropdown should fill in the SharePoint site automatically. Make sure you have access to the SharePoint site.
