---
title: Can't delete Teams channel folders from SharePoint
description: Fixes an issue in which you can't delete the corresponding channel folder in the SharePoint library after the channel is deleted from Microsoft Teams.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
  - CI 171872
ms.reviewer: prbalusu
appliesto: 
- SharePoint Online
ms.date: 12/17/2023
---
# You can't delete the folder for a deleted Teams standard channel

## Symptoms

You can't delete the corresponding folder in the SharePoint library for standard channels in Microsoft Teams that you deleted before August 2022.

## Cause

Before August 2022, the folder for a Teams channel wasn't disconnected from Teams after the channel was deleted. Therefore, there is no available option to delete the SharePoint folder.

For folders that were deleted starting in August 2022, the option to delete the folder in SharePoint is available.

## Resolution

To fix the issue, rename the folder in the modern experience of the SharePoint library. Renaming the folder triggers the **Delete** option to appear.

1. Select the "More actions" (three dots) icon next to the folder, and select **Rename**.
2. Type a new name for the folder, and select **Rename**.
3. Select the "More actions" icon again. The **Delete** option should now appear.
3. Select **Delete** to delete the folder.

If you still can't delete the folder, the folder might be associated with an active Teams channel. To find the active channel, navigate to the folder, and then select **Go to channel**. The associated channel appears in Teams.

If you want to delete the folder, you must first delete the channel.
