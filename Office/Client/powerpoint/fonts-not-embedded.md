---
title: Some fonts not embedded when a PowerPoint 2010 or above presentation is saved in an earlier format
description: Describes an issue with font embedding when you save a presentation in .PPT format.
author: Cloud-Writer
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Office Suite (Access, Excel, OneNote, PowerPoint, Publisher, Word, Visio)\Performance, Usability & Features
  - Editing\Fonts
  - CSSTroubleshoot
ms.author: meerak
appliesto: 
  - PowerPoint for Microsoft 365
  - PowerPoint 2019
  - PowerPoint 2016
  - PowerPoint 2013
  - PowerPoint 2010
ms.reviewer: johnlan
ms.date: 06/06/2024
---
# Some fonts are not embedded when you save a PowerPoint 2010 or later presentation in an earlier format

## Symptoms

When you open a PowerPoint 2010 or later presentation that was created on a different computer and saved in the "PowerPoint 97-2003 Presentation" format with the fonts embedded, you find that the original fonts are replaced by other fonts.

## Cause

This problem occurs because the fonts that you used are either restricted fonts or cannot be embedded.

## Workaround

Using the computer on which the presentation was created, follow these steps to replace the restricted fonts with fonts that can be embedded:

1.	Open the PowerPoint presentation.
2.	In PowerPoint 2010, Select **File** > **Save As**. In PowerPoint 2007, select the **Microsoft Office** button, and then select **Save As**. 
3.	In the **Save as type** list, select **PowerPoint Presentation**, and save the file.
4.	Select **Files** > **Options**, and then select **Save**.
5.	Under **Preserve fidelity when sharing this presentation**, select the **Embed fonts in the file** check box.
6.	Select **OK**, and then select **Save**.
7.	Repeat steps 2 through 6 as many times as necessary until you can save the presentation without receiving a warning message about embedded fonts.

If you are not the original creator of the file, but have a font that must be changed in an existing file, use the following steps to replace all instances of that particular font in the file.

1.	On the **Home** tab, navigate to the **Editing** group, select the arrow next to **Replace**, and then select **Replace Fonts**.
2.	In the **Replace** list, select a font, and then select a similar font from the **With** list.
3.	Select **Replace**.


## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
