---
title: PowerPoint cannot insert a video from the selected file
description: Describes the issue in which you receive the error PowerPoint cannot insert a video from the selected file when you try to insert an MPEG-4 or QuickTime Movie file into a PowerPoint 2013 or 2010 presentation.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
ms.reviewer: khutch, arykhus, kemille, richpo, debbiery
search.appverid: 
- MET150
appliesto:
- PowerPoint 2013
- PowerPoint 2010
- PowerPoint Home and Student 2010
---

# "PowerPoint cannot insert a video from the selected file" when you insert an MPEG-4 or QuickTime Movie file into a presentation

## Symptoms

On a slide in the 64-bit version of Microsoft PowerPoint 2013 or 2010, you try to insert a movie that uses one of following Apple QuickTime video and audio formats: 

- MPEG-4 video (*.mp4)

- MPEG-4 audio (*.m4a)

- QuickTime Movie (*.mov)

When you try to insert one of these formats, you receive the following error message: 

"PowerPoint cannot insert a video from the selected file. Verify that the necessary 64-bit codec for this media format is installed, and then try again."

## Cause

This issue occurs because currently the Windows operating system does not have a 64-bit video or audio codec for the three QuickTime media formats. 

## Workaround

To work around this issue, you can convert these video or audio files to the Windows Media Video file format (*.wmv) by using a third-party video or audio file converter.

The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.
