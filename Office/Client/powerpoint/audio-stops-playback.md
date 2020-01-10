---
title: Audio stops playback after you leave the original slide
description: Provides workarounds for an issue in which an audio file that is set to repeat and play across a set number of slides stops playback after you leave the original slide in PowerPoint 2010.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.custom: CSSTroubleshoot
ms.author: v-six
ms.reviewer: jdang, arykhus, kemille, richpo, debbiery
search.appverid: 
- MET150
appliesto:
- PowerPoint 2010
- PowerPoint Home and Student 2010
- PowerPoint 2013
---

# An audio file that is set to repeat and play across a set number of slides in PowerPoint stops playback after you leave the original slide

## Symptoms

Consider the following scenario. In Microsoft PowerPoint, you add an audio file to a slide. Then, you set this audio file to repeat multiple times and only play for a set number of slides. For example, you set an audio file to repeat five times and only play for two slides. Then, you run the presentation and play the audio file. The audio file plays and may repeat itself before you transition to the next slide. However, in this scenario, the audio file stops playing as soon as you leave the slide it was started on and the next slide opens. 

> [!NOTE]
> This issue does not occur if the audio file is set to repeat infinitely and to play across all slides in the presentation, or if the audio file is set to play one time across all slides.

## Workaround

### Method 1: Duplicate the audio file

To work around this issue, you can use third-party audio or audio/video editing software to edit the audio file and to physically repeat the audio file the number of times that you want the audio file to play. This workaround lets you control exactly how many times the audio file repeats itself. 

For example, you have an audio track that lasts 30 seconds. You want the track to play five times. You copy the audio track and append it to itself four more times. This makes the audio track 2.5 minutes long, with the audio portion repeating itself five times.

For more information about how to edit audio files, see the documentation that is included with the third-party audio editing software.

After you add the edited audio file to the PowerPoint slide, set the audio file to stop playing after a set number of slides. To insert and configure the audio file, follow these steps:

1. On the slide, click the **Insert** tab, and then in the **Media Clips** group, under **Sound**, click **Sound from File**.   
2. Select the edited audio file, and then click **OK**.   
3. Click **Automatically** when you are prompted.   
4. Click the **Animations** tab, and then click **Custom Animation**.   
5. In the **Custom Animation** pane, right-click the audio file entry, and then click **Effect Options**.   
6. In the **Stop playing** section, click **After**, and then set the number of slides that you want the sound to play on.   
7. Click **OK**.   

### Method 2: Loop the audio file continuously

To work around this issue, you can set the audio file to loop continuously for a set number of slides. This workaround does not let you control the number of repetitions. This workaround only lets you control how many slides the audio track repeats across. To do this, follow these steps:

1. On the slide, click the **Insert** tab, and then in the **Media Clips** group, under **Sound**, click **Sound from File**.   
2. Select the audio file, and then click **OK**.   
3. Click **Automatically** when you are prompted.   
4. On the **Sound Tools Options** tab, in the **Sound Options** group, click to select the **Loop Until Stopped** check box.   
5. Click the **Animations** tab, and then click **Custom Animation**.   
6. In the **Custom Animation** pane, right-click the audio file entry, and then click **Effect Options**.   
7. In the **Stop playing** section, click **After**, and then set the number of slides that you want the sound to play on.   
8. Click **OK**.   

### Method 3: Play the audio file across all slides

To work around this issue, you can set the audio file to play across slides in the presentation, starting on the slide the file is inserted on. This workaround does not let you control the number of repetitions or how many slides the sound plays on. To do this, follow these steps:

1. On the slide, click the **Insert** tab, and then in the **Media Clips** group, under **Sound**, click **Sound from File**.   
2. Select the audio file, and then click **OK**.   
3. Click **Automatically** when you are prompted.   
4. On the **Sound Tools Options** tab, in the **Sound Options** group, click to select the **Loop Until Stopped** check box.   
5. In the **Play Sound** drop-down list, click **Play across slides**.   
