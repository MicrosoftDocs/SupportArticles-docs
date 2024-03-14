---
title: Fit to Drawing command does not resize the page to fit the drawing's dimensions
description: Describes the issue in Visio 2010 / 2013 in which the Fit to Drawing command does not resize the page to fit the drawing's dimensions.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: timda, arykhus, kevinmil, barbway
search.appverid: 
  - MET150
appliesto: 
  - Visio 2013
  - Visio 2010
ms.date: 03/31/2022
---

# In Visio, the "Fit to Drawing" command does not resize the page to fit the drawing's dimensions

## Symptoms

In Microsoft Visio 2010 or Visio 2013, when you click **Fit to Drawing** in the **Size** group on the **Design** tab, the page resizes. But a small margin remains between the edge of the page and the drawing. 

## Cause

This issue occurs because of a design change in Visio. The **Fit to Drawing** command takes the margin settings of the page into consideration when the command resizes the page to fit the drawing.

## Resolution

To resolve this issue, follow these steps:

1. On the **File** tab, click **Options**, and then in the navigation pane, click **Customize Ribbon**.   
2. In the **Main Tabs** pane, click to select the **Developer** check box, and then click **OK**.   
3. On the **Developer** tab, click **Show ShapeSheet**, and then click **Page**.   
4. In the **Print Properties** section of the **ShapeSheet**, set the following values to 0: 
   - **PageLeftMargin**   
   - **PageRightMargin**   
   - **PageTopMargin**   
   - **PageBottomMargin**     
5. Use the **Fit to Drawing** command again. The page now resizes to fit the same dimensions of the drawing, and there is no margin.   
