---
title: Can't delete Teams channel folders from SharePoint
description: Fixes an issue in which you can't delete the corresponding channel folder in the SharePoint library after the channel is deleted from Microsoft Teams.
author: MaryQiu1987
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: v-maqiu
ms.custom: 
- CSSTroubleshoot
- CI 171872
ms.reviewer: prbalusu
appliesto: 
- SharePoint Online
ms.date: 2/15/2023
---
# Unable to delete the folder for a deleted Teams standard channel

## Symptoms

For standard channels in Microsoft Teams that you deleted before August 2022, you're not able to delete the corresponding folder in the SharePoint library.

## Cause

Prior to August 2022, the folder for a Teams channel wasn't disconnected from Teams after the channel was deleted. So there was no option available to delete the folder.

For folders that were deleted from August 2022 onward, the option to delete the folder in SharePoint is available.

## Resolution

To fix the issue, rename the folder in the modern experience of the SharePoint library. The renaming will trigger the **Delete** option to display.

1. Select the three dots next to the folder and select **Rename**.
2. Type a new name for the folder and select **Rename**.
Now when you select the three dots next to the folder, you'll see the **Delete** option displayed.
3. Select **Delete** to delete the folder.

If you're still unable to delete the folder, it might be associated with an active Teams channel. To find the active channel, navigate to the folder and select **Go to channel**. The associated channel will display in Teams.

If you want to delete the folder, you'll need to delete the channel first.
