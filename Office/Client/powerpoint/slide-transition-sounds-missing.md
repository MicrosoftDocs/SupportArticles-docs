---
title: Slide transition sounds missing
description: Works around an issue in which there are no slide transition sounds after you export a PowerPoint 2010 presentation to a video file.
author: helenclu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Editing\Transitions
  - CSSTroubleshoot
ms.author: luche
search.appverid: 
  - MET150
appliesto: 
  - PowerPoint 2010
  - PowerPoint Home and Student 2010
  - PowerPoint 2013
ms.date: 06/06/2024
---

# Sounds missing after a PowerPoint presentation is saved as video

## Symptoms

When you save a Microsoft PowerPoint 2010 presentation as a video, any slide transition sounds that were used in the presentation are missing. When you view the video, there are no slide transition sounds.

## Workaround

To work around this missing slide transition sound issue, remove the transition sounds, and then add the sounds directly to the slide. The sounds can then be set to play across slides and be triggered just before slide transitions to the next slide. 

> [!NOTE]
> This workaround only works if the presentation uses slide timings to advance to the next slide.

1. Open the presentation in PowerPoint 2010.

2. Locate the slides with the transition sounds. On the **Transitions** tab, set **Transition Sound** to **[No Sound]**.

3. Under **Advance Slide**, note the slide duration time in the **Automatically after** box.

4. On the **Insert** tab, in the **Media Clips** group, under **Sound**, click either **Sound from file** or **Sound from Clip Organizer**.

5. Insert the sound that you want to play across the slide transition.

6. Click **Automatically** when you are prompted.

7. Under **Sound Tools**, click the **Options** tab.

8. In the **Sound Options** group, select the **Hide During Show** check box.

9. Under the **Animations** tab, in the **Animations** group, click **Custom Animation**.

10. In the **Custom Animation** pane, right-click the sound file that is listed in the animations list, and then click **Timing**.

11. Set the **Start** drop-down list to **After Previous**.

12. In the **Delay** field, enter a value that is equal to the slide duration time minus 1 second. You noted the slide duration time in step 3. For example, if the slide advances after 40 seconds, you would set the **Delay** value to 39 seconds.

13. Click **OK**.

14. Repeat steps 2 through 13 for each slide transition that has a transition sound.

##  Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section.
