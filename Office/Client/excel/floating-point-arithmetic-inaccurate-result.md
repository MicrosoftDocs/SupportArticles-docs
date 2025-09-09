---
title: Floating-point arithmetic may give inaccurate result in Excel
description: Discusses that floating-point arithmetic may give inaccurate results in Excel.
author: Cloud-Writer
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.reviewer: clayj
ms.custom: 
  - Reliability
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Excel 2010
  - Excel 2013
  - Excel for Microsoft 365
  - Microsoft Excel for Mac 2011
  - Excel for Mac for Microsoft 365
ms.date: 05/26/2025
---

# Floating-point arithmetic may give inaccurate results in Excel

## Summary

This article discusses how Microsoft Excel stores and calculates floating-point numbers. This may affect the results of some numbers or formulas because of rounding or data truncation.

### Overview

Microsoft Excel was designed around the IEEE 754 specification to determine how it stores and calculates floating-point numbers. IEEE is the Institute of Electrical and Electronics Engineers, an international body that, among other things, determines standards for computer software and hardware. The 754 specification is a widely adopted specification that describes how floating-point numbers should be stored in a binary computer. It's popular because it allows floating-point numbers to be stored in a reasonable amount of space and calculations to occur relatively quickly. The 754 standard is used in the floating-point units and numeric data processors of nearly all of today's PC-based microprocessors that implement floating-point math, including the Intel, Motorola, Sun, and MIPS processors.

When numbers are stored, a corresponding binary number can represent every number or fractional number. For example, the fraction 1/10 can be represented in a decimal number system as 0.1. However, the same number in binary format becomes the following repeating binary decimal:  

**0001100110011100110011 (and so on)**

This can be infinitely repeated. This number can't be represented in a finite (limited) amount of space. Therefore, this number is rounded down by approximately -2.8E-17 when it's stored.

However, there are some limitations of the IEEE 754 specification that fall into three general categories:

- Maximum/minimum limitations
- Precision
- Repeating binary numbers

## More Information

### Maximum/Minimum Limitations

All computers have a maximum and a minimum number that can be handled. Because the number of bits of memory in which the number is stored is finite, it follows that the maximum or minimum number that can be stored is also finite. For Excel, the maximum number that can be stored is 1.79769313486232E+308 and the minimum positive number that can be stored is 2.2250738585072E-308.

#### Cases in which we adhere to IEEE 754

- Underflow: Underflow occurs when a number is generated that is too small to be represented. In IEEE and Excel, the result is 0 (with the exception that IEEE has a concept of -0, and Excel doesn't).
- Overflow: Overflow occurs when a number is too large to be represented. Excel uses its own special representation for this case (#NUM!).

#### Cases in which we don't adhere to IEEE 754

- Denormalized numbers: A denormalized number is indicated by an exponent of 0. In that case, the entire number is stored in the mantissa and the mantissa has no implicit leading 1. As a result, you lose precision, and the smaller the number, the more precision is lost. Numbers at the small end of this range have only one digit of precision.

  Example: A normalized number has an implicit leading 1. For instance, if the mantissa represents 0011001, the normalized number becomes 10011001 because of the implied leading 1. A denormalized number doesn't have an implicit leading one, so in our example of 0011001, the denormalized number remains the same. In this case, the normalized number has eight significant digits (10011001) while the denormalized number has five significant digits (11001) with leading zeroes being insignificant.

  Denormalized numbers are basically a workaround to allow numbers smaller than the normal lower limit to be stored. Microsoft doesn't implement this optional portion of the specification because denormalized numbers by their very nature have a variable number of significant digits. This can allow significant error to enter into calculations.

- Positive/Negative Infinities: Infinities occur when you divide by 0. Excel doesn't support infinities, rather, it gives a #DIV/0! error in these cases.  
- Not-a-Number (NaN): NaN is used to represent invalid operations (such as infinity/infinity, infinity-infinity, or the square root of -1). NaNs allow a program to continue past an invalid operation. Excel instead immediately generates an error such as `#NUM!` or `#DIV/0!`.

### Precision

A floating-point number is stored in binary in three parts within a 65-bit range: the sign, the exponent, and the mantissa.

|The sign|The exponent|The mantissa|
|---|---|---|
|1 sign bit|11 bits exponent|1 implied bit + 52 bits fraction|

The sign stores the sign of the number (positive or negative), the exponent stores the power of 2 to which the number is raised or lowered (the maximum/minimum power of 2 is +1,023 and -1,022), and the mantissa stores the actual number. The finite storage area for the mantissa limits how close two adjacent floating point numbers can be (that is, the precision).

The mantissa and the exponent are both stored as separate components. As a result, the amount of precision possible may vary depending on the size of the number (the mantissa) being manipulated. In the case of Excel, although Excel can store numbers from 1.79769313486232E308 to 2.2250738585072E-308, it can only do so within 15 digits of precision. This limitation is a direct result of strictly following the IEEE 754 specification and isn't a limitation of Excel. This level of precision is found in other spreadsheet programs as well.

Floating-point numbers are represented in the following form, where exponent is the binary exponent:

**X = Fraction * 2^(exponent - bias)**

Fraction is the normalized fractional part of the number, normalized because the exponent is adjusted so that the leading bit is always a 1. This way, it doesn't have to be stored, and you get one more bit of precision. This is why there's an implied bit. This is similar to scientific notation, where you manipulate the exponent to have one digit to the left of the decimal point; except in binary, you can always manipulate the exponent so that the first bit is a 1, because there are only 1s and 0s.

Bias is the bias value used to avoid having to store negative exponents. The bias for single-precision numbers is 127 and 1,023 (decimal) for double-precision numbers. Excel stores numbers using double-precision.

### Example using very large numbers

Enter the following into a new workbook:

```adoc
A1: 1.2E+200
B1: 1E+100
C1: =A1+B1 
```

The resulting value in cell C1 would be 1.2E+200, the same value as cell A1. In fact if you compare cells A1 and C1 using the IF function, for example IF(A1=C1), the result will be TRUE. This is caused by the IEEE specification of storing only 15 significant digits of precision. To be able to store the calculation above, Excel would require at least 100 digits of precision.

### Example using very small numbers

Enter the following into a new workbook:

```adoc
A1: 0.000123456789012345
B1: 1
C1: =A1+B1 
```

The resulting value in cell C1 would be 1.00012345678901 instead of 1.000123456789012345. This is caused by the IEEE specification of storing only 15 significant digits of precision. To be able to store the calculation above, Excel would require at least 19 digits of precision.

### Correcting precision errors

Excel offers two basic methods to compensate for rounding errors: the ROUND function and the **Precision as displayed** or
 **Set precision as displayed** workbook option.

#### Method 1: The ROUND function

Using the previous data, the following example uses the ROUND function to force a number to five digits. This lets you successfully compare the result to another value.

```adoc
A1: 1.2E+200
B1: 1E+100
C1: =ROUND(A1+B1,5) 
```

This results in **1.2E+200**.

**D1: =IF(C1=1.2E+200, TRUE, FALSE)**

This results in the value TRUE.

#### Method 2: Precision as displayed

In some cases, you may be able to prevent rounding errors from affecting your work by using the **Precision as displayed** option. This option forces the value of each number in the worksheet to be the displayed value. To turn on this option, follow these steps.

1. On the **File** menu, click **Options**, and then click the **Advanced** category.
2. In the **When calculating this workbook** section, select the workbook that you want, and then select the **Set precision as displayed** check box.

For example, if you choose a number format that shows two decimal places, and then you turn on the **Precision as displayed** option, all accuracy beyond two decimal places is lost when you save your workbook. This option affects the active workbook including all worksheets. You can't undo this option and recover the lost data. We recommend that you save your workbook before you enable this option.

### Repeating binary numbers and calculations that have near-zero results

Another confusing problem that affects the storage of floating point numbers in binary format is that some numbers that are finite, nonrepeating numbers in decimal base 10, are infinite, repeating numbers in binary. The most common example of this is the value 0.1 and its variations. Although these numbers can be represented perfectly in base 10, the same number in binary format becomes the following repeating binary number when it's stored in the mantissa:

**000110011001100110011 (and so on)**

The IEEE 754 specification makes no special allowance for any number. It stores what it can in the mantissa and truncates the rest. This results in an error of about -2.8E-17, or 0.000000000000000028 when it's stored.

Even common decimal fractions, such as decimal 0.0001, can't be represented exactly in binary. (0.0001 is a repeating binary fraction that has a period of 104 bits). This is similar to why the fraction 1/3 can't be exactly represented in decimal (a repeating 0.33333333333333333333).

For example, consider the following example in Microsoft Visual Basic for Applications:

```vb
   Sub Main()
      MySum = 0
      For I% = 1 To 10000
         MySum = MySum + 0.0001
      Next I%
      Debug.Print MySum
   End Sub
```

This will PRINT 0.999999999999996 as output. The small error in representing 0.0001 in binary propagates to the sum.

### Example: Adding a negative number

1. Enter the following into a new workbook:

   **A1: =(43.1-43.2)+1**
2. Right-click cell A1, and then click **Format Cells**. On the Number tab, click Scientific under Category. Set the **Decimal places** to 15.

Instead of displaying 0.9, Excel displays 0.899999999999999. Because (43.1-43.2) is calculated first, -0.1 is stored temporarily and the error from storing -0.1 is introduced into the calculation.

### Example when a value reaches zero

1. In Excel 95 or earlier, enter the following into a new workbook:

    **A1: =1.333+1.225-1.333-1.225**
2. Right-click cell A1, and then click **Format Cells**. On the Number tab, click Scientific under Category. Set the **Decimal places** to 15.

Instead of displaying 0, Excel 95 displays -2.22044604925031E-16.

Excel 97, however, introduced an optimization that attempts to correct for this problem. Should an addition or subtraction operation result in a value at or very close to zero, Excel 97 and later will compensate for any error introduced as a result of converting an operand to and from binary. The example above when performed in Excel 97 and later correctly displays 0 or 0.000000000000000E+00 in scientific notation.

For more information about floating-point numbers and the IEEE 754 specification, see the following World Wide Web sites:

- [https://www.ieee.org](https://www.ieee.org)
- [https://steve.hollasch.net/cgindex/coding/ieeefloat.html](https://steve.hollasch.net/cgindex/coding/ieeefloat.html)
