---
title: Cell shading continually darkens
description: Describes a change in Excel 2013 or Excel 2016 behavior in which the shading of a cell becomes darker if you hold down Ctrl and repeatedly select the cell.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.reviewer: Jenl, anitao
ms.custom: CSSTroubleshoot
search.appverid: 
- MET150
appliesto:
- Excel 2016
- Excel 2013
---

# Cell shading continually darkens when you hold down Ctrl and repeatedly select the cell in Excel

## Symptoms

Assume that you select multiple cells in a Microsoft Excel 2013 or Microsoft Excel 2016 worksheet. You mistakenly select some cells that you do not want to include in the selection. When you hold down Ctrl and then click those cells in order to remove them from the selection, the cell shading becomes darker, and the cells are not unselected. Additionally, the cell shading continues to darken if you repeatedly click the cells.

## Cause

This behavior is by design because of a change in the Excel 2013 or Excel 2016 graphics engine. This change enables you to highlight overlapping selections. If you repeatedly select the same cells, the cell shading eventually becomes too dark, and you cannot see the text in the cell.

## Workaround

To work around the issue, cancel the selection of cells, and start the selection process again.
