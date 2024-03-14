---
title: Misleading labels in the output of Excel Analysis ToolPak t-Test tools
description: Discusses the problem that the Analysis ToolPak t-Test tools give misleading labels in the output. You may also notice that the t-Test. Paired Two Sample for Means tool gives incorrect results.
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
  - Microsoft Office Excel 2003
  - Excel 2004 for Mac
ms.date: 03/31/2022
---

# Misleading labels in the output of the Analysis ToolPak t-Test tools in Excel

## Summary

This article describes the misleading labels that exist in the output of each of the three Analysis ToolPak t-Test tools, and that are common to the output of all three tools.

The reader must also be aware of the fact that the t-Test: Paired Two Sample for Means tool can give incorrect results.

#### Microsoft Excel 2004 for Macintosh information

The statistical functions in Excel 2004 for Mac were updated by using the same algorithms that were used to update the statistical functions in Microsoft Office Excel 2003 and later versions of Excel. Any information in this article that describes how a function works or how a function was modified for Excel 2003 and later versions of Excel also applies to Excel 2004 for Mac.

## More Information

Problems with misleading labels are illustrated and discussed in this article.

### Example of usage

To illustrate the t-Test tools, create a blank Excel worksheet, copy the following table, and then select cell A1 in your blank Excel worksheet. Then, paste the entries so that the following table fills cells A1:C20 in your worksheet.

|A|B|C|
|---|---|---|
|200|220||
|190|210||
|180|200||
|170|190||
|160|180||
|150|170||
|t-Test: Two-Sample Assuming Unequal Variances|||
||Variable 1|Variable 2|
|Mean|175|195|
|Variance|350|350|
|Observations|6|6|
|Hypothesized Mean Difference|0||
|df|10||
|t Stat|-1.8516402||
|P(T<=t) one-tail|0.046896275||
|t Critical one-tail|1.812461102||
|P(T<=t) two-tail|0.093792549||
|t Critical two-tail|2.228138842||

> [!NOTE]
> After you paste this table into your new Excel worksheet, click the **Paste Options** button, and then click **Match Destination Formatting**. With the pasted range still selected, use one of the following procedures, as appropriate for the version of Excel that you are running:

- In Microsoft Office Excel 2007, click the **Home** tab, click **Format** in the **Cells** group, and then click **AutoFit Column Width**.
- In Excel 2003, point to **Column** on the **Format** menu, and then click **AutoFit Selection**.

Data for the two samples is in cells A1:B6. Cells A8:C20 show the output of one of the three t-Test tools, the two-sample test with unequal variances. The format of this output is similar for each of the three tools. All the rows in this table are included for all three tools; output for each of the other two tools includes one additional row (a different additional row for each of the other two tools). Additional rows in these other output tables are not important for this discussion.

The focus of this article is to understand the information in rows 16 to 20. In each tool, a t-Statistic value, t, is computed and shown as "t Stat" in the output tables. Depending on the data, this value, t, can be negative or non-negative. If you assume equal underlying population means, and if t is less than 0, "P(T <= t) one-tail" gives the probability that a value of the t-Statistic would be observed that is more negative than t. If t is greater than or equal to 0, "P(T <= t) one-tail" gives the probability that a value of the t-Statistic would be observed that is more positive than t. Therefore, if the label is replaced with one that is more accurate, the label would be "P(T > |t|) one tail".

"t Critical one-tail" gives the cutoff value so that the probability that an observation from the t-distribution with df degrees of freedom is greater than or equal to "t Critical one-tail" is Alpha. The default level of Alpha is 0.05 for each tool and this can be changed in the input dialog box. The value of t Critical one-tail can also be found by using the ```TINV(2*Alpha, df)``` function in Excel. Because TINV gives the cutoff for a two-tailed t-test, use 2*Alpha instead of Alpha. If the two-tailed probability of a t value higher in absolute value than this cutoff is 0.10, the one-tailed probability of a t value higher than this cutoff is 0.05 (as is the one-tailed probability of a t value less than the negative of this cutoff).

"P(T <= t) two-tail" gives the probability that a value of the t-statistic would be observed that is larger in absolute value than t. Therefore, if the label is replaced with one that is more accurate, the label would be "P(|T| > |t|) two tail".

"t Critical two-tail" gives the cutoff value so that the probability of an observed t-Statistic larger in absolute value than "t Critical two-tail" is Alpha. The value of t Critical two-tail can also be found by using the TINV(Alpha, df) function in Excel.