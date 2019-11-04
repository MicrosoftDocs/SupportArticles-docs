---
title: Use the if worksheet function to suppress DIV/0! error value
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
- Excel 2000
---

# How to use the IF worksheet function to suppress the #DIV/0! error value in Excel

For a Microsoft Excel 2000 version of this article, see [Hide error values and error indicators in cells](https://support.microsoft.com/help/182188).

## Summary

When you divide by 0 (zero) or a blank cell, Microsoft Excel displays the error value "#DIV/0!" as the result of the calculation. This article shows you how to use the IF worksheet function to suppress the #DIV/0! error value.

## More information

To keep #DIV/0! from appearing, use the following formula in place of the standard division formula:

```excel
   =IF(denominator=0,"",numerator/denominator)
```

Numerator refers to the cell to be divided. Denominator refers to the cell that is the divisor.

This formula checks to see if the denominator equals zero (or is blank); if so, it displays a blank cell. For example, if you want to divide cell A1 by cell A2 and put the result in cell A3, the formula in cell A3 would be:

```
   $A$3: =IF(A2=0,"",A1/A2)
```
Cell A3 will appear blank if cell A2 is blank or contains a zero. Otherwise, A3 will contain the result of the expression A1/A2.

To display other information in the cell if the divisor is blank or zero, type the necessary information in the formula where the "" (quotation marks) appear. If you want to display text, type it between these quotation marks. If you want to display anything else (values), type it instead of the quotation marks.

> [!NOTE]
> If the denominator is a nonzero value, the division is calculated.

## References

For more information, see
[How to create a conditional format to hide errors in Excel](https://support.microsoft.com/help/182189).
