---
title: Embedded videos do not play
description: Describes an issue in which you export a PowerPoint 2010 presentation as a video and only the first video plays in any slide that contains two or more embedded videos. The rest of the videos on the slide do not play in the exported video presentation.
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
- PowerPoint 2010
- PowerPoint Home and Student 2010
- PowerPoint 2013
---

# Embedded videos don't play when you export a presentation as a video 

## Symptoms

Consider the following scenario:

- You create a presentation in Microsoft Office PowerPoint.   
- On a slide, you insert a video.   
- On the **Animations** tab, you click **Add Animation**.   
- In the **Media** area, you click **Pause**.   
- In the **Timing** group, in the **Start** drop-down list, you click **With Previous**.   
- In the **Delay** field, you set a delay time for playing the video.   
- On the **File** tab, you click **Save & Send**, and then you click **Create a Video**.   
- You do not change the default settings, you click **Create Video**, and then you save the movie file.   

In this scenario, when you play the exported video file, the movie starts playing. However, the slide transitions before the video finishes playing.

## Cause

This issue occurs because the **Pause** animation effect starts the video and then pauses the video for the **Delay** time. This does not affect the duration of the slide when you export the presentation as a video. The default setting for slide duration when you export a video is 5 seconds. The slide transitions before the video finishes playing. 

## Workaround

To work around this issue, use one of the following methods.

### Change the Animation settings

1. Select the video that you want to play after a short delay.   
2. On the **Animations** tab, in the **Animation** group, click **Play**.   
3. In the **Timing** group, in the **Start** drop-down list, click **With Previous**.   
4. Set the **Delay** to the time that you want.   
5. Export the presentation as a video.   

### Set the slide duration

1. On the **Transitions** tab, in the **Timing** group, under **Advance Slide**, click to select the **After** check box.   
2. Set the slide duration so that it is longer than the length of both videos combined. This allows for any delay in the playing of the videos.   

When you export the presentation as a video, make sure that you select **Use Recorded Times and Narrations** before you click **Create Video**.
