---
title: Excel statistical functions STEYX
description: Describes the STEYX function in Excel 2003 and in later versions of Excel.
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

# Excel statistical functions: STEYX

## Summary

This article describes the STEYX function in Microsoft Office Excel 2003 and in later versions of Excel, illustrates how the function is used, and compares the results of the function for Excel 2003 and for later versions of Excel with the results of STEYX in earlier versions of Excel.

## More Information

The STEYX(known_y's, known_x's) function returns the standard error of Y given X for a least-squares linear regression line that is used to predict y values from x values.

### Syntax

```excel
STEYX(known_y's,known_x's)
```

The arguments, known_y's and known_x's, must be arrays or cell ranges that contain equal numbers of numeric data values.

The most common usage of STEYX includes two ranges of cells that contain the data, such as STEYX(A1:A100, B1:B100).

### Example of usage

To illustrate the function STEYX, create a blank Excel worksheet, copy the following table, select cell A1 in your blank Excel worksheet and then paste the entries so that the table fills cells A1:D12 in your worksheet.

|A|B|C|D|
|---|---|---|---|
|y-values|x-values|||
|1|= 3 + 10^$D$3||Power of 10 to add to data|
|2|=4 + 10^$D$3||0|
|3|=2 + 10^$D$3|||
|4|=5 + 10^$D$3|||
|5|=4+10^$D$3|||
|6|=7+10^$D$3||pre-Excel 2003|
||||when D3 = 7.5|
|=STEYX(A2:A7,B2:B7)|||1.48954691097662|
|||||
||||when D3 = 8|
||||#DIV/0!|

After you paste this table into your new Excel worksheet, click the **Paste Options** button, and then click **Match Destination Formatting**. With the pasted range still selected, use one of the following procedures, as appropriate for the version of Excel that you are running:

- In Microsoft Office Excel 2007, click the **Home** tab, click **Format** in the **Cells** group, and then click **Auto-Fit Column Width**.
- In Excel 2003, point to **Column** on the
 **Format** menu, and then click
 **Auto-Fit Selection**.

You may want to format cells B2:B7 as Number with 0 decimal places and cell A9:D9 as Number with six decimal places.

Cells A2:A7 and B2:B7 contain the y-values and x-values that are used to call STEYX in cell A9.

If you have a version of Excel that is earlier than Excel 2003, you should know that STEYX can exhibit round-off errors. The behavior of STEYX has been improved for Excel 2003 and for later versions of Excel.

If you have an earlier version of Excel, the worksheet gives you a chance to run an experiment and discover when round-off errors occur. Adding a positive constant to each of the observations in B2:B7 should not affect the value of STEYX. If you were to plot x,y pairs with x on the horizontal axis and y on the vertical axis, adding a positive constant to each x value would shift the data to the right. The best fit regression line would still have the same slope and goodness of fit and should have the same value of STEYX.

Increasing the value in D3 adds a larger constant to B2:B7. If D2 <= 7, then there are no round-off errors that appear in the first six decimal places of STEYX. But then try 7.25, 7.5, 7.75, and 8. D7:D12 show values of STEYX when D2 = 7.5 and 8 respectively. Round-off errors have become so severe that division by 0 occurs when D3 = 8.

Earlier versions of Excel show wrong answers in these cases because the effects of round-off errors are more profound with the computational formula that is used by these versions. Still, the cases that are used in this experiment can be viewed as rather extreme.

If you have Excel 2003 or a later version of Excel, you will see no changes in values of STEYX if you try the experiment that is described earlier. However, cells D7:D12 shows round-off errors that you would have obtained by using earlier versions of Excel.

### Results in earlier versions of Excel

If you call the two data arrays X's and Y's, earlier versions of Excel used a single pass through the data to compute the sum of squares of X's, the sum of squares of Y's, the sum of X's, the sum of Y's, the sum of XY's, and the count of the number of observations in each array. These quantities were then combined into the computational formula that is provided in the Help file in earlier versions of Excel.

### Results in Excel 2003 and in later versions of Excel

The procedure that is used in Excel 2003 and in later versions of Excel uses a two-pass process through the data. First, the sums of X's and Y's and the count of the number of observations in each array are computed, and from these, the means (averages) of X and Y observations can be computed. Then, on the second pass,

- the squared difference between each X and the X mean is found and these squared differences are summed,
- the squared difference between each Y and the Y mean is found and these squared differences are summed, and
- the products (X – X mean) * (Y – Y mean) are found for each pair of data points and summed.

STEYX is then computed by using the formula in the Help file for STEYX in Excel 2003 and in later versions of Excel. Notice that none of these three sums is affected by adding a constant to each X value, because that same value is added to the X mean. In the numeric examples, even with a high power of 10 in cell D3, these three sums are not affected, and the results of the second pass are independent of the entry in cell D3. Therefore, the results in Excel 2003 and in later versions of Excel are more stable numerically.

### Conclusions

Replacing a one-pass approach by a two-pass approach guarantees better numeric performance of STEYX in Excel 2003 and in later versions of Excel. The results in Excel 2003 and in later versions of Excel will never be less accurate than the results in earlier versions.

In most practical examples, however, you are not likely to see a difference between the results in later versions of Excel and the results in earlier versions of Excel. This is because typical data is unlikely to exhibit the kind of unusual behavior that this experiment illustrates. Numeric instability is most likely to appear in earlier versions of Excel when data contains a high number of significant digits combined with relatively little variation between data values.

The procedure of finding the sum of squared deviations about a sample mean by

- finding the sample mean,
- computing each squared deviation, and
- summing the squared deviations

is more accurate than the alternative procedure. This procedure is frequently named the "calculator formula" because it was suitable for use of a calculator on a small number of data points. The calculator formula uses the following procedures:

- Find the sum of squares of all observations, the sample size, and the sum of all observations.
- Compute the sum of squares of all observations minus ((sum of all observations)^2)/sample size).

There are many other functions that have been improved for Excel 2003 and for later versions of Excel. These functions were improved by replacing the one-pass procedure with the two-pass procedure that finds the sample mean on the first pass and computes the sum of squared deviations about the sample mean on the second pass.

Functions that have been improved in this way for Excel 2003 and for later versions of Excel include the following functions:

- VAR
- VARP
- STDEV
- STDEVP
- DVAR
- DVARP
- DSTDEV
- DSTDEVP
- FORECAST
- SLOPE
- INTERCEPT
- PEARSON
- RSQ
- STEYX

Similar improvements were made in each of the three Analysis of Variance tools in the Analysis ToolPak.