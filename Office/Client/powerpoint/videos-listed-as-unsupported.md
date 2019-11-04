---
title: Videos are listed as "Unsupported" when you optimize a presentation
description: Provides a workaround for an issue in PowerPoint 2010 in which some videos are listed as "Unsupported" in the Compress Media dialog box when you try to optimize a presentation.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
ms.custom: CSSTroubleshoot
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.reviewer: stung, arykhus, kemille, richpo, debbiery
appliesto:
- PowerPoint 2010
---

# When you try to optimize a presentation, some videos are listed as "Unsupported" in the Compress Media dialog box in PowerPoint 2010

## Symptoms

When you try to optimize a presentation that contains one or more videos in Microsoft PowerPoint 2010, the **Compress Media** dialog box lists the status of the videos as "Unsupported."

## Cause

This issue occurs when a video's width or height is not evenly divisible by 4. For example, a video that has a width of 640 pixels and a height of 489 pixels cannot be compressed in PowerPoint 2010.

If the video already satisfies the previous criteria, you may need additional third-party codecs to compress or play the video.

## Workaround

To work around this issue, you must use videos that have width and height dimensions that are evenly divisible by 4.

If the presentation was created on a different computer, you can try to compress the presentation on that computer before you open the presentation on the current computer. If that computer is not available, or the current computer's configuration has changed, you have to install the video codecs that were used on the original computer from a third-party source.
