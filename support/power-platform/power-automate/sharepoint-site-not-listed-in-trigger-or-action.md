---
title: Dropdown does not load items
description: Resolution for dropdown not loading items in trigger and actions.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 3/31/2021
ms.subservice: power-automate-flows
---
# SharePoint site not listed in trigger or action in Microsoft Flow

This article provides resolutions for the issue that dropdown is not loading items.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4527556

## Symptoms

In Flow, you can select a SharePoint site, Onedrive path, SQL/Dataverse table in certain triggers or actions. You may open this dropdown and not be able to find your specific item for eg SharePoint site, SQL table, etc.

## Cause

Users may not be able to see items listed in the dropdown list in Flow. Sometimes, when you have too many SharePoint items on a SharePoint site or too many files in a Onedrive folder path, the dropdown will timeout after 35 seconds trying to fetch all the items and will not load any items for you to select one from.

## Resolution

Users can still use _Enter Custom Value_ option to manually type the SharePoint list name, or SQL table name or Onedrive file name and run the flow.

### Resolution 1 - Select Enter custom value

:::image type="content" source="media/sharepoint-site-not-listed-in-trigger-or-action/enter-custom-value.png" alt-text="Screenshot to select the Enter custom value item.":::

### Resolution 2 - Get the SharePoint site URL

You can find the SharePoint site URL by going to the desired site in SharePoint and copying the url from the browser. Make sure you have access to the SharePoint site.

You can also use any URL from your SharePoint site. The Flow designer will clean up the URL once it is pasted in.

### Resolution 3 - Type the SharePoint URL directly into the dropdown text box

:::image type="content" source="media/sharepoint-site-not-listed-in-trigger-or-action/type-url.png" alt-text="Screenshot to type the SharePoint U R L directly into the dropdown text box.":::

The Flow designer will clean up any URL and point it directly to the SharePoint site.

:::image type="content" source="media/sharepoint-site-not-listed-in-trigger-or-action/clean-url-sharepoint-site.png" alt-text="Screenshot shows the Flow designer points the U R L directly to the SharePoint site.":::

The dropdown should fill in the SharePoint site automatically. Make sure you have access to the SharePoint site. Follow similar steps for other connectors like Onedrive, SQL, Dataverse, etc. 
