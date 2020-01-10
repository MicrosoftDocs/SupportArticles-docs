---
title:  An error message when you sort a range that contains merged cells in Excel
description: Discusses a problem in which you may receive an error message when you sort a range that contains merged cells in Excel.
author: simonxjx
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
- MET150
audience: ITPro
ms.service: office-perpetual-itpro
ms.topic: article
ms.author: v-six
ms.custom: CSSTroubleshoot
appliesto:
- Excel 2007
- Excel 2003
---

# You may receive an error message when you sort a range that contains merged cells in Excel

## Symptoms

When you try to sort a range in a Microsoft Excel worksheet, Excel does not sort the range. Additionally, you may receive the following error message:

**This operation requires the merged cells to be identically sized.**

## Cause

This issue may occur if you sort a range of cells, and if the following conditions are true:


- You previously merged some cells, but not all cells in the sort range.    
- You previously merged all cells in the sort range and the cells are not all the same size.   

## Workaround

To work around this issue, split all the merged cells in the range, or merge all the cells in the range so that the merged cells are the same size. Each merged cell in the range must occupy the same number of rows and columns as the other merged cells in the range.

### Steps to reproduce the problem

1. In a worksheet, type the following data:

    ```asciidoc
    A1: B1: Name C1: Value
    A2: B2: Sue  C2: 1
    A3: B3: Tom  C3: 2
    ```

1. Merge cells A1 and B1, A2 and B2, and A3 and B3. To do this, follow these steps:  
      1. Select each pair of cells.    
      2. On the **Format** menu, click **Cells**.
    
         > [!NOTE]
         > In Microsoft Office Excel 2007, click the **Alignment** dialog box launcher in the **Alignment** group on the Home tab.
      3. Click the **Alignment** tab, and then click to select the **Merge cells** check box.    
      4. Click **OK**.
    
         Do not merge cells in column C.

3. Select cells A1:C3, click **Sort** on the **Data** menu, and then click **OK**.

    > [!NOTE]
    > In Excel 2007, click **Sort & Filter** in the **Editing** group on the **Home** tab, and then click **Custom Sort**.    
4. In the **Sort** box, click **OK**.    
