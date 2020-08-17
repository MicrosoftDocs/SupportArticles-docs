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
- PowerPoint 2010
- PowerPoint 2013
- PowerPoint 2016
- PowerPoint 2019
- PowerPoint for Microsoft 365
ms.reviewer: johnlan
---
# Some fonts are not embedded when you save a PowerPoint 2010 or above presentation in an earlier format

This article documents an issue in which some fonts are not embedded when you save a PowerPoint presentation.

_Original KB number:_ &nbsp; 922958

## Symptoms

Consider the following scenario. You create a presentation in Microsoft PowerPoint 2010 and above. Additionally, you perform one of the following actions:

- You save the presentation in **PowerPoint 97-2003 Presentation** format with embedded fonts.

When you open the presentation on a different computer, the original fonts are replaced by other fonts.

## Cause

This issue occurs because the fonts that you used are restricted fonts. Additionally, the fonts cannot be embedded.

## Workaround

On the computer on which the presentation was created, follow these steps to replace the restricted fonts with fonts that can be embedded:

1. Open the PowerPoint presentation.
2. In PowerPoint, click **File**, then click **Save As**.
3. In the **Save as type** list, click **PowerPoint Presentation** and save the file.
4. Click **Files** > **Options**, and then click **Save**.
5. Under **Preserve fidelity when sharing this presentation**, click to select the **Embed fonts in the file** check box.
6. Click **OK**, and then click **Save**.
7. A warning message appears if the presentation contains fonts that have embedding restrictions. Replace the restricted fonts with fonts that do not generate a warning message when you save the presentation. To do this, follow these steps:
   1. On the **Home** tab, click the arrow next to **Replace** in the **Editing** group, and then click **Replace Fonts**.
   1. Select a font in the **Replace** list, and then select a similar font in the **With** list.
   1. Click **Replace**.
   1. Repeat steps 7b and 7c as needed to replace other fonts, and then click **Close**. Repeat steps 2 through 6 until you can save the presentation without receiving a warning message about embedded fonts.
