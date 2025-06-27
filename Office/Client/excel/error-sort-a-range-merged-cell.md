---
title: An error message when you sort a range that contains merged cells in Excel
description: Discusses a problem in which you may receive an error message when you sort a range that contains merged cells in Excel.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - Editing\Cells
  - CSSTroubleshoot
appliesto: 
  - Excel for Microsoft 365
  - Excel 2019
  - Excel 2016
  - Excel 2013
  - Excel 2010
  - Excel 2007
ms.date: 05/26/2025
---

# You may receive an error message when you sort a range that contains merged cells in Excel

## Symptoms

When you sort a range in a Microsoft Excel worksheet, Excel does not sort the range. Additionally, you may receive the following error message:

**This operation requires the merged cells to be identically sized.**

## Cause

This issue might occur if you sort a range of cells, and if the following conditions are true:

- You previously merged some of the cells, but not all of the cells in the sort range.
- You previously merged all of the cells in the sort range and the cells are not all the same size.

## Workaround

To work around this issue, split all the merged cells in the range, or merge all the cells in the range so that the merged cells are the same size. Each merged cell in the range must occupy the same number of rows and columns as the other merged cells in the range.

### General solution

1. Select the entire range you want to sort.
2. In the **Alignment** group on the **Home** tab, select the **Alignment** dialog box launcher.

   :::image type="content" source="media/error-sort-a-range-merged-cell/select-alignment-on-home-tab.png" alt-text="Select the Alignment dialog box on the Home tab.":::

3. Select the **Alignment** tab, and then clear the **Merge cells** check box.
4. Select **OK**.

> [!NOTE]
> This can alter the layout of the data in the range.

### Example solution

1. In a worksheet, type the following data:

    ```asciidoc
    A1: B1: Name C1: Value
    A2: B2: Sue  C2: 1
    A3: B3: Tom  C3: 2
    ```

2. Merge cells A1 and B1, A2 and B2, and A3 and B3. To do this, follow these steps:  
      1. Select each pair of cells.
      2. Select the **Alignment** dialog box launcher in the **Alignment** group on the **Home** tab.

         :::image type="content" source="media/error-sort-a-range-merged-cell/select-alignment-on-home-tab.png" alt-text="Select the Alignment dialog box on the Home tab.":::

      3. Select the **Alignment** tab, and then select the **Merge cells** check box.
      4. Select **OK**.

     Do not merge cells in column C.

3. Select cells A1:C3, select **Sort & Filter** in the **Editing** group on the **Home** tab, and then click **Custom Sort**.

4. In the **Sort** box, select "Column C" next to **Sort By**, and then select **OK**. You should see the error message as documented above.

5. To resolve the issue, do one of the following:
   1. Unmerge cells A1:B3 so there are no merged cells in the selection.  
   2. Merge cells C1 and D1, C2 and D2, and C3 and D3, so that C column is same sized (merged) as the A/B column.  Then select cells A1:D3, and repeat steps 3 and 4 using a uniform range size.
