---
title: Can't delete public folder items from OWA search results
description: You can't delete public folder items that you search from Microsoft Outlook on the web. 
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - CI 165318
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: haembab, batre, meerak
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 8/2/2022
---
# Can't delete public folder items from OWA search results

## Symptoms

Consider the following scenario:

- You have been granted sufficient permissions of a public folder (such as the [Owner](/powershell/module/exchange/add-publicfolderclientpermission) permissions).  
- You search for specific items from the public folder in Microsoft Outlook on the web (OWA), such as the items that are received from a specific sender.
- You select some items from the results or select **Results** > **Delete all** to delete the items.

  :::image type="content" source="media/owa-remove-public-folder-items-failure/search-pf-items.png" alt-text="Screenshot of the searched items in OWA. The Results and Delete all options are highlighted.":::

In this scenario, the items are deleted and disappear. However, if you close and reopen OWA, the items appear again.

If you [collect a network trace](/azure/azure-web-pubsub/howto-troubleshoot-network-trace) and search for the **DeleteItem** request for OWA, you see the following error message in the response text:

> An item in a public folder cannot be moved to the Deleted Items folder.

## Cause

This behavior is by design.

## Workaround

To work around this issue, use one of the following methods:

- Method 1: Use an Outlook client instead of using OWA to search for the public folder items, and then delete them.
- Method 2: Locate the public folder item instead of searching for it, and then delete it.  
