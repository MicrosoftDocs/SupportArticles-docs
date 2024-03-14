---
title: Excel statistical functions INTERCEPT
description: Describes the Excel statistical function INTERCEPT for Excel 2003 and later.
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
  - Microsoft Office Excel 2007
  - Microsoft Office Excel 2003
ms.date: 03/31/2022
---

# Excel statistical functions: INTERCEPT

## Summary

This article discusses the INTERCEPT function in Microsoft Excel, illustrates how to use the function, and compares its results for Excel 2003 and for later versions of Excel with its results in earlier versions of Excel.

## More Information

The INTERCEPT(**known_y's**,**known_x's**) function returns the INTERCEPT of the linear regression line that is used to predict **y** values from **x** values.

### Syntax

```excel
INTERCEPT(known_y's,known_x's)
```

The arguments, **known_y's** and **known_x's**, must be arrays or cell ranges that contain equal numbers of numeric data values. Frequently, INTERCEPT includes 2 ranges of cells containing the data, such as INTERCEPT(A1:A100, B1:B100).

### Example of usage

To illustrate the INTERCEPT function, create a blank Excel worksheet, copy the following table, select cell **A1** in your blank Excel worksheet, and then paste the entries so that the following table fills cells A1:D13 in your worksheet.

|A|B|C|D|
|---|---|---|---|
|y-values|x-values|||
|1|= 3 + 10^$D$3||Power of 10 to add to data|
|2|=4 + 10^$D$3||0|
|3|=2 + 10^$D$3|||
|4|=5 + 10^$D$3|||
|5|=4+10^$D$3|||
|6|=7+10^$D$3||Excel 2002 and earlier|
||||when D3 = 7.5|
|=SLOPE(A2:A7,B2:B7)|||-23717082.0762629|
|=INTERCEPT(A2:A7,B2:B7)|||-24516534.4029667|
|= AVERAGE(A2:A7) - A9*AVERAGE(B2:B7)|||when D3 = 8|
|=AVERAGE(A2:A7) - 0.775280899*AVERAGE(B2:B7)|||#DIV/0!|
||||-77528089.6303371|

> [!NOTE]
> After you paste this table into your new Excel worksheet, click the **Paste Options** button, and then click **Match Destination Formatting**. With the pasted range still selected, use one of the following procedures, as appropriate for the version of Excel that you are running:

- In Microsoft Office Excel 2007, click the **Home** tab, click **Format** in the **Cells** group, and then click **AutoFit Column Widths**.
- In Excel 2003, point to **Column** on the **Format** menu, and then click **AutoFit Selection**.

You may want to format cells B2:B7 as Number with 0 decimal places and cells A9:D13 as Number with 6 decimal places.

Cells A2:A7 and B2:B7 contain the **y**-values and **x**-values that call INTERCEPT in cell A10.

In versions of Excel that are earlier than Excel 2003, INTERCEPT can exhibit round off errors. Excel 2003 and later versions of Excel improve the behavior of INTERCEPT. INTERCEPT(**known_y's**, **known_x's**) is the result of evaluating AVERAGE(**known_y's**) – SLOPE(**known_y's**, **known_x's**) * AVERAGE(**known_x's**). While the code for INTERCEPT has not been directly changed for Excel 2003 and for later versions of Excel, the behavior of INTERCEPT is improved because of improved code for SLOPE.

If you have an earlier version of Excel, you can use the worksheet you created earlier to run an experiment to discover when round off errors occur. Adding a positive constant to each of the observations in B2:B7 should not affect the value of SLOPE. If you plot **x**,**y** pairs with **x** on the horizontal axis and **y** on the vertical axis, and then add a positive constant to each **x** value, data just shifts to the right. The best-fit regression line still has the same slope. However, the shifted data has a different intercept.

With the default value of 0 in D3, SLOPE in A9 is 0.775280899. Cell A10 shows the value of INTERCEPT, and cell A11 shows the value of the expression that is evaluated when calculating INTERCEPT:

AVERAGE(**known_y's**) – SLOPE(**known_y's**, **known_x's**) * AVERAGE(**known_x's**)

Values in cells A9 and A10 always agree because the value in A10 is exactly what INTERCEPT returns. SLOPE should not vary as you add different positive constants to the **known_x's**. Cell A11 shows AVERAGE(**known_y's**) – 0.775280899 * AVERAGE(**known_x's**). Because SLOPE should not change, and 0.775280899 is the value of SLOPE when D3 = 0, values of this expression in A11 should also agree with the values in cells A9 and A10.

If you increase the value in D3, you add a larger constant to B2:B7. If D3 <= 7, then there are no round off errors that appear in the first 6 decimal places of SLOPE. But if you try 7.25, 7.5, 7.75, and 8, the SLOPE in A9 changes. As a result, the values in cells A11 (that agree with A10) and A12 differ. However, values in A11 (or A10) and A12 should be the same because adding a constant to the **known_x's** should not affect SLOPE.

D7:D13 show the values that INTERCEPT returns and the values that INTERCEPT should have returned if SLOPE had not changed. These pairs of values appear for the cases where D3 = 7.5 and 8 respectively. Round off errors have become so severe that division by 0 occurs when D3 = 8.

Earlier versions of Excel give wrong answers in these cases because the effects of round-off errors are greater with the computational formula that these versions use. Still, this experiment shows that the cases where the errors occur are extreme.

If you have Excel 2003 or a later version of Excel, there is little or no difference between the common values in A10 and A11 and the value in A12 if you try the experiment. However, cells D7:D13 show the round-off errors that you obtain with the earlier versions of Excel.

### Results in earlier versions of Excel

The article about SLOPE describes the less numerically robust formula that earlier versions use. The formula requires only one pass through the data. Only the shortcomings of SLOPE in these versions cause INTERCEPT to give round-off errors in the extreme cases.

### Results in Excel 2003 and in later versions of Excel

Excel 2003 and later versions of Excel uses an improved procedure to calculate SLOPE. As a result, INTERCEPT's performance improves. The improved procedure requires two passes through the data. Again, the following article about SLOPE describes the improvement.

For more information about the improvements in SLOPE for Excel 2003 and for later versions of Excel, click the following article number to view the article in the Microsoft Knowledge Base:

[828142](https://support.microsoft.com/help/828142) Excel statistical functions: SLOPE

### Conclusions

Because Excel 2003 and later versions of Excel replace a one-pass approach with a two-pass approach, the numeric performance of SLOPE in Excel 2003 and in later versions of Excel is better than in earlier versions of Excel. Therefore, the numeric performance of INTERCEPT is better. Results in Excel 2003 and in later versions of Excel will never be less accurate than the results in earlier versions of Excel.

Typically, there is not a difference between the results in Excel 2003 and in later versions of Excel and the results in earlier versions of Excel because data does not frequently behave in the unusual way that this experiment illustrates. Numeric instability is most likely to appear in earlier versions of Excel when the data contains many significant digits and little variation between the data values.

The following procedure finds the sum of the squared deviations about a sample mean:

1. Find the sample mean.
2. Calculate each squared deviation.
3. Sum the squared deviations.

This procedure is more accurate than the following alternative procedure (also known as the "calculator formula" because it was suitable for use on a calculator for a small number of data points):

1. Find the sum of the squares of all the observations, the sample size, and the sum of all the observations.
2. Calculate the sum of the squares of all the observations minus ((**sum of all observations**)^2)/**sample size**).

By replacing this latter one-pass procedure with the two-pass procedure that finds the sample mean on the first pass and computes the sum of squared deviations about it on the second pass, Excel 2003 and later versions of Excel improve many other functions. A short list of such functions includes VAR, VARP, STDEV, STDEVP, DVAR, DVARP, DSTDEV, DSTDEVP, FORECAST, SLOPE, INTERCEPT, PEARSON, RSQ, and STEYX. Microsoft made similar improvements in each of the three Analysis of Variance tools in the Analysis ToolPak.