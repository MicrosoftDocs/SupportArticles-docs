---
title: Some fonts are not embedded when you save a PowerPoint 2010 or above presentation in an earlier format
description: Describes an issue with font embedding when you save a presentation in .PPT format.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: troubleshoot
ms.custom: CSSTroubleshoot
ms.author: v-six
appliesto:
- PowerPoint for Microsoft 365
- PowerPoint 2019
- PowerPoint 2016
- PowerPoint 2013
- PowerPoint 2010
ms.reviewer: johnlan
---
# Some fonts are not embedded when you save a PowerPoint 2010 or later presentation in an earlier format

## Symptoms

Under the following circumstances:

- You create a presentation in Microsoft PowerPoint 2010 or later.
- You save the presentation in the “PowerPoint 97-2003 Presentation” format and specify embedded fonts.

When you open the presentation on a different computer, the original fonts are replaced by other fonts.

## Cause

This issue occurs because the fonts that you used are restricted fonts. Additionally, the fonts cannot be embedded.

## Workaround

On the computer on which the presentation was created, follow these steps to replace the restricted fonts with fonts that can be embedded:

1.	Open the PowerPoint presentation.
2.	In PowerPoint 2010, Select **File** > **Save As**. In PowerPoint 2007, select the **Microsoft Office** button, and then select **Save As**. 
3.	In the **Save as type** list, select **PowerPoint Presentation**, and save the file.
4.	Select **Files** > **Options**, and then select **Save**.
5.	Under **Preserve fidelity when sharing this presentation**, select the **Embed fonts in the file** check box.
6.	Select **OK**, and then select **Save**.
7.	A warning message appears if the presentation contains fonts that have embedding restrictions. Replace the restricted fonts with fonts that do not generate a warning message when you save the presentation. To do this, follow these steps:

    1. On the Home tab, navigate to the Editing group, select the arrow next to **Replace**, and then select **Replace Fonts**.
    2. In the **Replace** list, select a font, and then select a similar font in the **With** list.
    3. Select **Replace**.
    4. Repeat steps 7b and 7c as many times as necessary to replace any other fonts, and then select **Close**.
    
8.	Repeat steps 2 through 6 as many times as necessary until you can save the presentation without receiving a warning message about embedded fonts.

## More information

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).