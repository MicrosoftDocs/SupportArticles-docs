---
title: Receive an error message when you open a presentation
description: Resolves an issue in which you receive an error message when you try to open a presentation in PowerPoint.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Microsoft Office PowerPoint 2003
- Microsoft Office PowerPoint 2007
- PowerPoint 2010
---

# You receive an error message when you try to open a presentation in PowerPoint

## Symptoms

When you try to open a presentation in PowerPoint 2002, in PowerPoint 2003, or in PowerPoint 2007, you receive the following error message:

**PowerPoint 2002 and PowerPoint 2003**

"PowerPoint can't read path\file_name.ppt."

**PowerPoint 2007**

Error message 1

"PowerPoint found unreadable content in Presentation.pptx. Do you want to recover the contects of this presentation? If you trust the source of this presentation, click Yes."

To determine the unique number that is associated with the message that you receive, press CTRL+SHIFT+I. The following number appears in the lower-right corner of this message:

"400645"

Error message 2

"There was an error accessing C:\documents and settings\username\Presentation.pptx"

To determine the unique number that is associated with the message that you receive, press CTRL+SHIFT+I. The following number appears in the lower-right corner of this message:

"400066"

## Cause

This problem occurs because the PowerPoint presentation is corrupted or has been damaged.

## Resolution

To correct this problem, try to open the PowerPoint presentation in an earlier version of PowerPoint. For example, open the presentation in PowerPoint 2000 or in an earlier version of PowerPoint. If you are successful in opening the presentation, insert the slides from the damaged presentation in a new presentation. To do this, follow these steps:

**PowerPoint 2002 and PowerPoint 2003**

1. Start the later version of PowerPoint that gave you the error message that is mentioned in the "Symptoms" section.
1. Click Insert, and then click Slides from Files.
1. In Slide Finder on the Find Presentation tab, click Browse.
1. Locate and then click the PowerPoint presentation that gave you the error message, click Open, and then click Insert All.

**Note** If the new file that you just created does not have the design of the damaged presentation, you can apply that design by following the menu path:
Format, Slide Design, and then selecting the appropriate design on the Slide Design menu.

**PowerPoint 2007 and PowerPoint 2010**

1. On the Home tab, in the Slides group, click New Slide, and then click Reuse Slides.
1. In the Reuse Slides pane, click Open a PowerPoint File.
1. In the Browse dialog box, locate and then click the presentation file that contains the slide that you want, and then click Open.

## More Information

In earlier versions of PowerPoint such as PowerPoint 2000 and earlier versions, PowerPoint could not detect all the types of invalid or damaged data in presentations that can be detected by PowerPoint 2007, by PowerPoint 2003 and by PowerPoint 2002. As a result, the earlier versions of PowerPoint open the presentation, and you may experience unexpected behavior from the corruption or damage that is contained in the file.
