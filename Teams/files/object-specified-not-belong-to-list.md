---
title: Can't access the Files tab in a Teams channel
description: Fixes an issue in which you can't access the Files tab in a Teams channel. This issue occurs when the default document library name on your SharePoint site has been changed.
author: MaryQiu1987
ms.author: v-maqiu
manager: dcscontentpm
audience: ITPro 
ms.topic: troubleshooting 
ms.service: msteams
localization_priority: Normal
ms.custom: 
- CI 143097
- CSSTroubleshoot
ms.reviewer: prbalusu
appliesto:
- Microsoft Teams
search.appverid: 
- MET150
---
# "The object specified does not belong to a list" error when selecting the Files tab in a Teams channel

## Symptoms

When you select the **Files** tab in a channel in Microsoft Teams, you receive the following error message:

> Something went wrong  
> The object specified does not belong to a list.

## Cause

This error occurs if the name of the document library on your SharePoint site was changed from its default, "Shared Documents," to another name.

## Resolution

To resolve this issue, revert the name the document library to "Shared Documents." You must have administrator permissions to make this change.

1. Open the SharePoint site in [SharePoint Designer](https://www.microsoft.com/download/details.aspx?id=35491).
2. Go to **All Files**.
3. Locate the document library folder by its new name. For example, in the following screenshot, the default name was changed to "Renamed Documents."

   :::image type="content" source="media/object-specified-not-belong-to-list/renamed-documents.png" alt-text="Screenshot of the renamed document library in All Files.":::

4. Right-click the folder, select **Rename**, and then change the name to **Shared Documents**.
