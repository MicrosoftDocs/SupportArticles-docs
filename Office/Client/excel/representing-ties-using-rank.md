---
title: Excel statistical functions Representing ties by using RANK
description: Describes how to use RANK to give an average rank value to tied observations.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Microsoft Excel
ms.date: 03/31/2022
---

# Excel statistical functions: Representing ties by using RANK

## Summary

This article discusses how to use RANK to give an average rank value to tied observations.

## More Information

When you convert numeric data to ranks, you may want to represent ties so that the tied observations each receive an average rank over all such observations instead of the lowest possible rank. The numeric example in this article illustrates this.

Although the current version of RANK returns the appropriate results for most situations, this article discusses the situation where a tie occurs. For example, you may want RANK to handle ties if you are using a non-parametric statistical hypothesis test that involves ranks.

The method that this article describes is also described in the RANK Help file for Microsoft Office Excel 2003 and for later versions of Excel (but not in earlier RANK Help files). This procedure works equally well for all versions of Excel. The RANK function itself has not changed.

### Syntax

```excel
RANK(number, ref, order)
```

> [!NOTE]
> **Number** must have a numeric value; **ref** must be an array or cell range that contains numeric data values; **order** is optional. If you omit **order**, or assign it a value of 0 (zero), the rank of **number** is the position of **number** in **ref** if **ref** is ranked in descending order. If **order** is assigned any non-zero value, **ref** is assumed to be ranked in ascending order.

### Example of usage

To illustrate this use of RANK, create a blank Excel worksheet, copy the following table, select cell **A1** in your blank Excel worksheet, and then click **Paste** on the **Edit** menu so that the entries in the following table fill cells A1:F12 in your worksheet.

> [!NOTE]
> In Microsoft Office Excel 2007, the **Paste** command is in the **Clipboard** group on the **Home** tab.

|A|B|C|D|E|F|
|---|---|---|---|---|---|
|10|=RANK(A1,$A$1:$A$12,1)|=B1 + (COUNT($A$1:$A$12) + 1 - RANK($A1,$A$1:$A$12,0) - RANK($A1,$A$1:$A$12,1))/2||=RANK(A1,$A$1:$A$12,0)|=E1 + (COUNT($A$1:$A$12) + 1 - RANK($A1,$A$1:$A$12,0) - RANK($A1,$A$1:$A$12,1))/2|
|21|=RANK(A2,$A$1:$A$12,1)|=B2 + (COUNT($A$1:$A$12) + 1 - RANK($A2,$A$1:$A$12,0) - RANK($A2,$A$1:$A$12,1))/2||=RANK(A2,$A$1:$A$12,0)|=E2 + (COUNT($A$1:$A$12) + 1 - RANK($A2,$A$1:$A$12,0) - RANK($A2,$A$1:$A$12,1))/2|
|21|=RANK(A3,$A$1:$A$12,1)|=B3 + (COUNT($A$1:$A$12) + 1 - RANK($A3,$A$1:$A$12,0) - RANK($A3,$A$1:$A$12,1))/2||=RANK(A3,$A$1:$A$12,0)|=E3 + (COUNT($A$1:$A$12) + 1 - RANK($A3,$A$1:$A$12,0) - RANK($A3,$A$1:$A$12,1))/2|
|21|=RANK(A4,$A$1:$A$12,1)|=B4 + (COUNT($A$1:$A$12) + 1 - RANK($A4,$A$1:$A$12,0) - RANK($A4,$A$1:$A$12,1))/2||=RANK(A4,$A$1:$A$12,0)|=E4 + (COUNT($A$1:$A$12) + 1 - RANK($A4,$A$1:$A$12,0) - RANK($A4,$A$1:$A$12,1))/2|
|21|=RANK(A5,$A$1:$A$12,1)|=B5 + (COUNT($A$1:$A$12) + 1 - RANK($A5,$A$1:$A$12,0) - RANK($A5,$A$1:$A$12,1))/2||=RANK(A5,$A$1:$A$12,0)|=E5 + (COUNT($A$1:$A$12) + 1 - RANK($A5,$A$1:$A$12,0) - RANK($A5,$A$1:$A$12,1))/2|
|33|=RANK(A6,$A$1:$A$12,1)|=B6 + (COUNT($A$1:$A$12) + 1 - RANK($A6,$A$1:$A$12,0) - RANK($A6,$A$1:$A$12,1))/2||=RANK(A6,$A$1:$A$12,0)|=E6 + (COUNT($A$1:$A$12) + 1 - RANK($A6,$A$1:$A$12,0) - RANK($A6,$A$1:$A$12,1))/2|
|33|=RANK(A7,$A$1:$A$12,1)|=B7 + (COUNT($A$1:$A$12) + 1 - RANK($A7,$A$1:$A$12,0) - RANK($A7,$A$1:$A$12,1))/2||=RANK(A7,$A$1:$A$12,0)|=E7 + (COUNT($A$1:$A$12) + 1 - RANK($A7,$A$1:$A$12,0) - RANK($A7,$A$1:$A$12,1))/2|
|52|=RANK(A8,$A$1:$A$12,1)|=B8 + (COUNT($A$1:$A$12) + 1 - RANK($A8,$A$1:$A$12,0) - RANK($A8,$A$1:$A$12,1))/2||=RANK(A8,$A$1:$A$12,0)|=E8 + (COUNT($A$1:$A$12) + 1 - RANK($A8,$A$1:$A$12,0) - RANK($A8,$A$1:$A$12,1))/2|
|52|=RANK(A9,$A$1:$A$12,1)|=B9 + (COUNT($A$1:$A$12) + 1 - RANK($A9,$A$1:$A$12,0) - RANK($A9,$A$1:$A$12,1))/2||=RANK(A9,$A$1:$A$12,0)|=E9 + (COUNT($A$1:$A$12) + 1 - RANK($A9,$A$1:$A$12,0) - RANK($A9,$A$1:$A$12,1))/2|
|52|=RANK(A10,$A$1:$A$12,1)|=B10 + (COUNT($A$1:$A$12) + 1 - RANK($A10,$A$1:$A$12,0) - RANK($A10,$A$1:$A$12,1))/2||=RANK(A10,$A$1:$A$12,0)|=E10 + (COUNT($A$1:$A$12) + 1 - RANK($A10,$A$1:$A$12,0) - RANK($A10,$A$1:$A$12,1))/2|
|61|=RANK(A11,$A$1:$A$12,1)|=B11 + (COUNT($A$1:$A$12) + 1 - RANK($A11,$A$1:$A$12,0) - RANK($A11,$A$1:$A$12,1))/2||=RANK(A11,$A$1:$A$12,0)|=E11 + (COUNT($A$1:$A$12) + 1 - RANK($A11,$A$1:$A$12,0) - RANK($A11,$A$1:$A$12,1))/2|
|73|=RANK(A12,$A$1:$A$12,1)|=B12 + (COUNT($A$1:$A$12) + 1 - RANK($A12,$A$1:$A$12,0) - RANK($A12,$A$1:$A$12,1))/2||=RANK(A12,$A$1:$A$12,0)|=E12 + (COUNT($A$1:$A$12) + 1 - RANK($A12,$A$1:$A$12,0) - RANK($A12,$A$1:$A$12,1))/2|

> [!NOTE]
> After you paste this table into your new Excel worksheet, click the **Paste Options** button, and then click **Match Destination Formatting**.

In Excel 2003, with the pasted range still selected, point to **Column** on the **Format** menu, and then click **AutoFit Selection**.

In Excel 2007, with the pasted range still selected, click **Format** in the **Cell** group on the **Home** tab, and then click **AutoFit Column Width**.

For some purposes, you may want to use a definition of rank that takes ties into account. To do so, add the following correction factor to the value that RANK returns. This correction factor is appropriate where rank is computed in descending order (**order** = 0 or omitted) or ascending order (**order** = nonzero value).

```excel
(COUNT(ref) + 1 – RANK(number, ref, 0) – RANK(number, ref, 1))/2.
```

The worksheet illustrates this definition of rank. Data is in cells A1:A12. Ranks that RANK returns in ascending order are in cells B1:B12. Observations in cells A2:A5 are tied with a common value of 21. This produces a common rank of 2. There is one lower-ranked observation, 10. These four values of 21 take up ranked positions 2, 3, 4, and 5 and have an average rank of (2 + 3 + 4 + 5)/4 = 3.5. Similarly, the two observations in cells A6:A7 are each 33, there are five observations with lower rank. Therefore, these two observations take up ranked positions 6 and 7 and have an average rank of (6 + 7)/2 = 6.5. Finally, the three observations in cells A8:A10 have a common value, 52. There are seven observations with lower rank. Therefore, these three observations take up ranked positions 8, 9, and 10 and have an average rank of (8 + 9 + 10)/3 = 9.

Entries in column C contain the correction factor for tied ranks and show these average ranks that take ties into account. The values in columns B and C are exactly the same where observations are not tied with other observations, such as rows 1, 11, and 12.

Cells E1:E12 contain ranks that RANK returns in descending order. There are two entries with lower ranks than the three entries in cells A8:A10. Cells A8:A10 have a common value, 54. Therefore, these three entries take up ranked positions 3, 4, and 5 and have an average rank of (3 + 4 + 5)/3 = 4. There are five entries with a lower rank than the two entries in cells A6:A7. Cells A6:A7 have a common value, 33. Therefore, these two entries take up ranked positions 6 and 7 and have an average rank of (6 + 7)/2 = 6.5. There are seven entries with lower ranks than the four entries in cells A2:A5. Cells A2:A5 have a common value, 21. Therefore, these four entries take up ranked positions 8, 9, 10, 11 and have an average value of (8 + 9 + 10 + 11)/4 = 9.5.

Entries in column F contain the correction factor for tied ranks and show these average ranks that take ties into account. The values in columns E and F are exactly the same where observations are not tied with other observations, such as rows 1, 11, and 12.

### Conclusions

This article describes and illustrates a correction factor that you can use to account for tied ranks when you rank data. You can use the correction factor together with the RANK function. The correction factor works equally well when ranks are in ascending or descending order.