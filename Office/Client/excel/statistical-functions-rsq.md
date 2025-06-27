---
title: Excel statistical functions RSQ
description: Describes the Excel statistical function RSQ.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - Editing\Functions
  - CSSTroubleshoot
appliesto: 
  - Microsoft Office Excel 2007
  - Microsoft Office Excel 2003
ms.date: 05/26/2025
---

# Excel statistical functions: RSQ

## Summary

This article describes the RSQ function in Microsoft Office Excel 2003 and in later versions of Excel. This article discusses how the function is used and compares the results of RSQ in these later versions of Excel with the results of RSQ in earlier versions of Excel.

## More Information

The RSQ(array1, array2) function returns the Square of the Pearson Product-Moment Correlation Coefficient between two arrays of data.

### Syntax

```excel
RSQ(array1, array2)
```

The arguments, array1 and array2, must be either numbers or names, array constants, or references that contain numbers.

The most common usage of RSQ includes two ranges of cells that contain the data, such as RSQ(A1:A100, B1:B100).

### Example of usage

To illustrate the RSQ function, follow these steps:

1. Create a blank Excel worksheet, and then copy the following table.

   |A|B|C|D|
   |---|---|---|---|
   |1||= 3 + 10^$D$2|Power of 10 to add to data|
   |2|=4 + 10^$D$2||0|
   |3|=2 + 10^$D$2|||
   |4|=5 + 10^$D$2|||
   |5|=4+10^$D$2|||
   |6|=7+10^$D$2||pre-Excel 2003|
   |=RSQ(A1:A6,B1:B6)|||when D2 = 7.5|
   |=PEARSON(A1:A6,B1:B6)^2||RSQ = PEARSON^2|0.492857142857143|
   |=CORREL(A1:A6,B1:B6)^2||CORREL^2|0.509470304975923|
   |||||
   ||||when D2 = 8|
   |||RSQ = PEARSON^2|#DIV/0!|
   |||CORREL^2|0.509470304975923|

2. Select cell A1 in your blank Excel worksheet, and then paste the entries so that the table fills cells A1:D13 in your worksheet.
3. After you paste the table into your new Excel worksheet, select the **Paste Options** button, and then select **Match Destination Formatting**. With the pasted range still selected, use one of the following procedures, as appropriate for the version of Excel that you're running:

   - In Microsoft Office Excel 2007, select the **Home** tab, select **Format** in the **Cells** group, and then select **AutoFit Column Width**.
   - In Excel 2003, point to **Column** on the **Format** menu, and then select **AutoFit Selection**.

> [!NOTE]
> You may want to format cells B1:B6 as Number with 0 decimal places.

Cells A1:A6 and B1:B6 contain the two data arrays that are used in this example to call RSQ, PEARSON, and CORREL in cells A8:A10. RSQ is calculated by essentially calculating PEARSON and squaring the result. Because PEARSON and CORREL both compute the Pearson Product-Moment Correlation Coefficient, their results should agree. RSQ could be (but wasn't) implemented as essentially calculating CORREL and squaring the result.

In versions of Excel that are earlier than Excel 2003, PEARSON may exhibit round-off errors. This behavior leads to round-off errors in RSQ. The behavior of PEARSON, and therefore of RSQ, has been improved for Excel 2003 and for later versions of Excel. CORREL has always been implemented by using the improved procedure that is found in Excel 2003 and in later versions of Excel. Therefore, an alternative to RSQ for an earlier version of Excel is to use CORREL instead and then to square the result.

In versions of Excel that are earlier than Excel 2003, you can use the worksheet in this article to run an experiment and to discover when round-off errors occur. If you add a constant to each of the observations in B1:B6, the values of RSQ, PEARSON^2, and CORREL^2 in cells A7:A9 shouldn't be affected. If you increase the value in D2, a larger constant is added to B1:B6. If D2 <= 7, there are no round-off errors that appear in A7:A9. Now change the value of 7.25, 7.5, 7.75, and then 8. CORREL^2 in A9 is unaffected, but RSQ and PEARSON^2 (these expressions always agree with each other) show round-off errors in A7:A8. D6:D13 show values of RSQ = PEARSON^2 and CORREL^2 when D2 = 7.5 and 8, respectively.

Note that CORREL is still well-behaved, but round-off errors in PEARSON have become so severe that division by 0 occurs in RSQ and PEARSON^2 when D2 = 8.

Earlier versions of Excel exhibit incorrect answers in these cases because the effects of round-off errors are more profound with the computational formula that is used by these versions of Excel. Still, the cases that are used in this experiment may be viewed as extreme.

If you have Excel 2003 or a later version of Excel, you see no changes in values of RSQ and PEARSON^2 if you try the experiment. However, cells D6:D13 show round-off errors that you would have obtained with earlier versions of Excel.

### Results in earlier versions of Excel

If you name the two data arrays X's and Y's, earlier versions of Excel used a single pass through the data to compute the sum of squares of X's, the sum of squares of Y's, the sum of X's, the sum of Y's, the sum of XY's, and the count of the number of observations in each array. These quantities were then combined in the computational formula that is given in the Help file in earlier versions of Excel. The Help file for RSQ shows the formula for the Pearson Product-Moment Correlation Coefficient. This result is squared to obtain RSQ.

### Results in Excel 2003 and in later versions of Excel

The procedure that is used in Excel 2003 and in later versions of Excel uses a two-pass process through the data. First, the sums of X's and Y's and the count of the number of observations in each array are computed, and from these the means (averages) of X and Y observations can be computed. Then, on the second pass, the squared difference between each X and the X mean is found, and these squared differences are summed. The squared difference between each Y and the Y mean is found, and these squared differences are summed. Additionally, the products (X – X mean) * (Y – Y mean) are found for each pair of data points and summed. These three sums are combined in the formula for PEARSON. Notice that none of the three sums is affected if you add a constant to each value in the Y array (or in the X array). This behavior occurs because that same value is added to the Y mean (or to the X mean). In the numeric examples, even with a high power of 10 in cell D12, these three sums aren't affected, and the results of the second pass are independent of the entry in cell D2. Therefore, the results in Excel 2003 and in later versions of Excel are more stable numerically.

### Conclusions

Replacing a one-pass approach by a two-pass approach guarantees better numeric performance of PEARSON, and therefore RSQ, in Excel 2003 and in later versions of Excel. The results that you obtain in Excel 2003 and in later versions of Excel will never be less accurate than results that you obtained in earlier versions of Excel.

In most practical examples, you aren't likely to see a difference between the results in later versions of Excel and the results in earlier versions of Excel. This behavior occurs because typical data is unlikely to exhibit the kind of unusual behavior that this experiment illustrates. Numeric instability is most likely to appear in earlier versions of Excel when data contains a high number of significant digits combined with relatively little variation between data values.

The procedure of finding the sum of squared deviations about a sample mean by finding the sample mean, by computing each squared deviation, and by summing the squared deviations is more accurate than the alternative procedure. This alternative procedure was frequently named the "calculator formula" because it was suitable for use of a calculator on a few data points. The alternative procedure used the following procedure:

- Found the sum of squares of all observations, the sample size, and the sum of all observations
- Computed the sum of squares of all observations minus ([sum of all observations]^2)/sample size).

There are many other functions that have been improved for Excel 2003 and for later versions of Excel. These functions are improved because later versions of Excel replace the one-pass procedure with the two-pass procedure that finds the sample mean on the first pass and then computes the sum of squared deviations about the sample mean on the second pass.

The following list is a list of such functions:

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
