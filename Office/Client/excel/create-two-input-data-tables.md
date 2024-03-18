---
title: How to create and use two-input data tables in Excel
description: Describes how to create and use two-input data tables in  Excel.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
appliesto: 
  - Excel 2007
  - Excel 2003
  - Excel 2001
  - Excel 98
ms.date: 03/31/2022
---

# How to create and use two-input data tables in Microsoft Excel

## Summary

This article describes how to create and to use two-input tables in Microsoft Excel. These tables allow you to test how changes in two variables affect one formula.

## More Information

When you create a two-input table, you specify input cells in the Row Input Cell and Column Input Cell boxes in the Table dialog box.

> [!NOTE]
> In Microsoft Office Excel 2007, the **Table** dialog box is called the **Data Table** dialog box.

To create a simple two-input table, follow these steps:

1. Create a new workbook.
2. In cells B15:B19, type the following data:
  
   |Cell|Value|
   |------------|------------|
   |B15|1|
   |B16|2|
   |B17|3|
   |B18|4|
   |B19|5|

3. In cells C14:G14, type the following data:
 
   |Cell|Value|
   |------------|------------|
   |C14|6|
   |D14|7|
   |E14|8|
   |F14|9|
   |G14|10|

4. In cell B14, type the following formula:

   **=A14*2+A15**

   > [!NOTE]
   > A14 is the column input cell (which substitutes values 1, 2, 3, 4, and 5), and A15 is the row input cell (which substitutes values 6, 7, 8, 9, and 10). These input cells must be located outside the table; they may or may not contain data. Because this table is set up in cells B14:G19, and because A14 and A15 are outside the table, they are valid column input and row input cells.

5. Select B14:G19.
6. On the Data menu, click Table.

   > [!NOTE]
   > In Excel 2007, click the **Data** tab, click **What-If Analysis,** and then click **Data Table**.

7. In the Row Input Cell box, type A15. In the Column Input Cell box, type A14.
8. Click OK.

You see the following results:

```asciidoc
Two-Input table (with formulas displayed)
=========================================

Note: Due to screen display limitations, the following six-column table is shown in two parts.

(Left three columns of a six-column table)

||B|C|D|
|---|-----------|---------------|---------------|
|14|=A14*2+A15|6|7|
|15|1|=TABLE(A15,A14)|=TABLE(A15,A14)|
|16| 2|=TABLE(A15,A14)|=TABLE(A15,A14)|
|17| 3|=TABLE(A15,A14)|=TABLE(A15,A14)|
|18| 4|=TABLE(A15,A14)|=TABLE(A15,A14)|
|19| 5|=TABLE(A15,A14)|=TABLE(A15,A14)|

(Right three columns of a six-column table.)

||E|F|G|
|---|----------------|---------------|---------------|
|14|8|9|10|
|15|=TABLE(A15,A14)|=TABLE(A15,A14)|=TABLE(A15,A14)|
|16|=TABLE(A15,A14)|=TABLE(A15,A14)|=TABLE(A15,A14)|
|17|=TABLE(A15,A14)|=TABLE(A15,A14)|=TABLE(A15,A14)|
|18|=TABLE(A15,A14)|=TABLE(A15,A14)|=TABLE(A15,A14)|
|19|=TABLE(A15,A14)|=TABLE(A15,A14)|=TABLE(A15,A14)|

Two-Input table (with values displayed)
=======================================

||B|C|D|E|F|G|
|---|---|---|---|---|---|---|
|14| | 6| 7| 8| 9| 10|
|15| 1| 8| 9| 10| 11| 12|
|16| 2| 10| 11| 12| 13| 14|
|17| 3| 12| 13| 14| 15| 16|
|18| 4| 14| 15| 16| 17| 18|
|19| 5| 16| 17| 18| 19| 20|
```

> [!NOTE]
> Take cell C15 as an example. The actual values that are used in the formula are from cells B15:B19 (the row input cells) and cells C15:G14 (the column input cells). The formula with the values in it would be 1*2+6 (for a total of 8). Excel internally substitutes the values in the row and column input cells into the formula in cell B14.

0 appears in cell B14, although the cell B14 is not a number format. To duplicate the blank value in cell B14, follow these steps:

1. Right-click cell B14, and then click **Format Cells**.
2. Click the Number tab.
3. In the Category list, click Custom.
4. In the Type box, type "" (two quotation marks).
5. Click OK.

## References

For more information about how to use data tables, view the following articles:

[Calculate multiple results by using a data table](https://support.office.com/article/Calculate-multiple-results-by-using-a-data-table-e95e2487-6ca6-4413-ad12-77542a5ea50b)

[282852](https://support.microsoft.com/help/282852) An overview of data tables in Microsoft Excel