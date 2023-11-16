---
title: Dropdown list does not load items in triggers or actions in Microsoft Flow
description: Provides steps to solve the issue where dropdown doesn't load items in triggers or actions in Microsoft Flow.
ms.reviewer: evsung
ms.topic: troubleshooting
ms.date: 03/31/2021
ms.subservice: power-automate-flows
---
# Dropdown list does not load items in a trigger or an action in Microsoft Flow

This article provides a resolution for the issue that dropdown doesn't load items.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4527556

## Symptoms

In Microsoft Flow, you can select a SharePoint site, OneDrive path, and a SQL Server or Dataverse table in certain triggers or actions from the dropdown list. However, when you open the dropdown list, you may not be able to find a specific item, for example, a SharePoint site, a SQL Server table and so on.

## Cause

You may not be able to see items listed in the dropdown list in Flow. Sometimes, when you have too many SharePoint items on a SharePoint site or too many files in a OneDrive folder path, the dropdown will time out after 35 seconds when trying to fetch all the items and won't load any items for you to select one from.

## Resolution

Before you run the flow, you can use the **Enter custom value** option to manually type the SharePoint list name, SQL Server table name, or OneDrive file name as follows.

### Step 1 - Select Enter custom value

In the **Site Address** text box dropdown list, select the **Enter custom Value** option.

:::image type="content" source="media/sharepoint-site-not-listed-in-trigger-or-action/enter-custom-value.png" alt-text="Screenshot to select the Enter custom value item." border="false":::

### Step 2 - Get the SharePoint site URL

You can find the SharePoint site URL by going to the desired site in SharePoint and copying the url from the browser. Make sure you have access to the SharePoint site.

You can also use any URL from your SharePoint site. The Flow designer will clean up the URL once it's pasted in.

### Step 3 - Type the SharePoint site URL into Site Address

In the **Site Address** text box, type the SharePoint site URL.

:::image type="content" source="media/sharepoint-site-not-listed-in-trigger-or-action/type-url.png" alt-text="Screenshot to type the SharePoint U R L directly into the dropdown text box." border="false":::

The Flow designer will clean up any URL and point it directly to the SharePoint site.

:::image type="content" source="media/sharepoint-site-not-listed-in-trigger-or-action/clean-url-sharepoint-site.png" alt-text="Screenshot shows the Flow designer points the U R L directly to the SharePoint site." border="false":::

The dropdown list should fill in the SharePoint site automatically. Make sure you have access to the SharePoint site. You can follow the similar steps for other connectors such as OneDrive, SQL Server, and Dataverse.
