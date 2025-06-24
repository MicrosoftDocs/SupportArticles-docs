---
title: Differences between Excel statistical functions STDEVPA and STDEVP
description: This article describes changes to the STDEVPA and the STDEVP statistical functions in Excel 2007, in Excel 2003, and in Excel 2004.
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

# Differences between the Excel statistical functions STDEVPA and STDEVP

## Summary

This article discusses the differences between the STDEVPA function in Microsoft Excel and the closely related STDEVP function. In particular, it discusses how the results of the STDEVPA function for Microsoft Office Excel 2007 and for Microsoft Office Excel 2003 may differ from the results of STDEVPA in earlier versions of Excel.

#### Excel 2004 for Macintosh Information

The statistical functions in Microsoft Excel 2004 for Macintosh were updated using the same algorithms as Microsoft Office Excel 2003. Any information in this article that describes how a function works or how a function was modified for Excel 2003 and Excel 2007 also applies to Excel 2004 for Macintosh.

## More Information

The STDEVPA function returns the population standard deviation for a population whose values are contained in an Excel worksheet and specified by the argument(s) to STDEVPA.

### Syntax

```excel
STDEVPA(value1, value2, value3, ...)
```

The parameters (value1, value2, value 3,...) are up to 30 value arguments.

Frequently, STDEVPA includes only one value argument that specifies a range of cells that contain the sample. For example:

```excel
STDEVPA(A1:B100)
```

### Example Usage

STDEVPA differs from STDEVP only in the way it treats cells in the data range that contain TRUE, FALSE, or a text string. STDEVPA interprets TRUE as the value 1 and interprets FALSE as the value 0. It interprets a text string as the value 0. It ignores blank cells. These interpretations also apply for the COUNTA, AVERAGEA, and STDEVA functions.

STDEVP ignores blank cells and cells that contain TRUE, FALSE, or a text string. These interpretations also apply for the COUNT, AVERAGE, and STDEV functions.

Use STDEVP instead of STDEVPA unless you are sure that you want the function to interpret TRUE, FALSE, and text strings as described earlier in this article for STDEVPA. Most data you want to calculate a population standard deviation for is completely numeric. Therefore, STDEVP is appropriate.

To illustrate the difference between STDEVPA and STDEVP, create a blank Excel worksheet, copy the table below, select cell A1 in your blank Excel worksheet, and then click **Paste** on the **Edit** menu so that the entries in the table below fill cells A1:D12 in your worksheet.

|A|B|C|D|
|---|---|---|---|
|Data|0|||
|||||
|6|6|Sample Mean for STDEVP, STDEV|=AVERAGE(A1:A8)|
|4|4|Sample Size for STDEVP, STDEV|=COUNT(A1:A8)|
|2|2|STDEVP|=STDEVP(A1:A8)|
|1|1|STDEV|=STDEV(A1:A8)|
|7|7|Sample Mean for STDEVPA, STDEVA|=AVERAGEA(A1:A8)|
|TRUE|1|Sample Size for STDEVPA, STDEVA|=COUNTA(A1:A8)|
|||STDEVPA|=STDEVPA(A1:A8)|
|||STDEVA|=STDEVA(A1:A8)|
|||STDEVP for Column B|=STDEVP(B1:B8)|
|||STDEV for Column B|=STDEV(B1:B8)|

> [!NOTE]
> After you paste this table into your new Excel worksheet, click the **Paste Options** button, and then click **Match Destination Formatting**. With the pasted range still selected, point to **Column** on the **Format** menu, and then click
 **AutoFit Selection**. 

In this example, cells A1:A8 contain data values that contrast STDEVPA with STDEVP. All the functions that are used in cells D3:D10 refer to the data in A1:A8. STDEVPA treats the text string in cell A1 as the value 0, the numeric values in A3:A7 as themselves, and the value TRUE in A8 as 1. The values that are used for STDEVPA in A1:A8 appear in B1:B8. The worksheet shows that the value of STDEVPA(A1:A8) in cell D9 is exactly equal to the value of STDEVP(B1:B8) in cell D11.

STDEVP and STDEVPA return population standard deviation, whereas STDEV and STDEVA return sample standard deviation. In all versions of Excel, a value is calculated first for VAR, VARA, VARP, or VARPA. The square root of this value is returned (respectively) for STDEV, STDEVA, STDEVP, or STDEVPA. To evaluate VAR, VARA, VARP, and VARPA, Excel 2003 calculates the number of data points and their average, and then calculates the sum of squared deviations of data values from this average. This sum of squared deviations is the numerator of the fraction that is used to evaluate VAR, VARA, VARP, and VARPA. The denominator for VARP and VARPA is the number of data points. The denominator for VAR and VARA is one less than the number of data points.

To calculate each of these four functions, Excel 2003 and Excel 2007 use a procedure that differs from and improves upon the procedure that earlier versions of Excel use. The article for STDEV gives a worksheet that permits you to examine cases where unusual behavior occurs in STDEV for earlier versions of Excel, but not for Excel 2003 or for Excel 2007. However, such cases are likely to occur only in extreme situations. Procedures for STDEV, STDEVA, STDEVP, STDEVPA, VAR, VARA, VARP, and VARPA have all been modified in the same way to improve the numeric stability of the results. The articles for STDEV and VAR also describe these modifications.

For more information, see the following articles:

[STDEV function](https://support.microsoft.com/office/stdev-function-51fecaaa-231e-4bbb-9230-33650a72c9b0)

[826112](https://support.microsoft.com/help/826112) Excel Statistical Functions: VAR
