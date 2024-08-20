---
title: You cannot use videos as slide backgrounds in PowerPoint
description: Describes a problem in which you cannot use videos as slide backgrounds in PowerPoint. A workaround is provided.
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Editing
  - CSSTroubleshoot
appliesto: 
- PowerPoint 2013
- PowerPoint 2010
- PowerPoint Home and Student 2010
search.appverid: MET150
ms.reviewer: 
author: simonxjx
ms.author: v-six
ms.date: 06/06/2024
---
# You cannot use videos as slide backgrounds in PowerPoint

## Symptoms

Consider the following scenario:

In Microsoft PowerPoint, you try to set a video file as the background of a slide. When you close the **Format Background** dialog box, the video does not appear as the background of the slide. Instead, you see a red letter X in the upper right-corner of the slide together with the following error message:

> This image cannot currently be displayed.

:::image type="content" source="media/cannot-use-videos-as-slide-backgrounds/this-image-cannot-currently-be-displayed-error.png" alt-text="Screenshot of this image cannot currently be displayed error message.":::

## Cause

This problem occurs because PowerPoint doesn't support videos as slide backgrounds. This is true for all versions of PowerPoint.

## Workaround

PowerPoint supports the playing of videos behind other slide objects during a slide show. You can use this feature in PowerPoint to work around this problem. To do so, follow these steps:

> [!NOTE]
> This workaround does not work for earlier versions of PowerPoint. However, you can use the PowerPoint Viewer to run a slide show. The most current version of the PowerPoint Viewer supports the playing of videos behind other objects on a slide.

1. Browse to the slide for which you want to play the video as a background.
2. On the **Insert** tab, in the **Media** group, select **Video**, and then select **Video from file**.
3. Select the video that you want to use, and then select **Insert**.
4. Under **Video Tools**, on the **Playback** tab, in the **Video Options** group, select either **On Click** or **Automatically** on the **Start** list.
5. If you want the video to loop continuously on the slide, select **Loop until Stopped**.
6. On the **Slide Show** tab, in the **Set Up** group, clear the **Show Media Controls** check box. This prevents the video controls from appearing if you move your mouse pointer over the video during playback.
7. On the **Home** tab, in the **Drawing** group, select **Arrange**, and then select **Send to Back**.

You can also add the video to the Slide Master for the presentation if you want the video to appear on every slide. However, when the slide show advances to the next slide, the video restarts from the beginning.

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.
