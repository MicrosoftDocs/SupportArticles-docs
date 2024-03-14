---
title: How to convert Excel column numbers into alphabetical characters
description: This article discusses how to convert integers into alphabetical characters.
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
ms.date: 03/31/2022
---

# How to convert Excel column numbers into alphabetical characters

## Introduction 

This article discusses how to use the Microsoft Visual Basic for Applications (VBA) function in Microsoft Excel to convert column numbers into their corresponding alphabetical character designator for the same column.

For example, the column number 30 is converted into the equivalent alphabetical characters "AD". 

## More Information

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.

The ConvertToLetter function works by using the following algorithm: 

1. Let `iCol` be the column number. Stop if `iCol` is less than 1.
2. Calculate the quotient and remainder on division of `(iCol - 1)` by 26, and store in variables `a` and `b`.
3. Convert the integer value of `b` into the corresponding alphabetical character (0 => A, 25 => Z) and tack it on at the front of the result string.
4. Set `iCol` to the divisor `a` and loop.

For example: The column number is 30. 

* (Loop 1, step 1) The column number is at least 1, proceed.

* (Loop 1, step 2) The column number less one is divided by 26:

   29 / 26 = 1 remainder 3.
   `a = 1, b = 3`

* (Loop 1, step 3) Tack on the `(b+1)` letter of the alphabet:

   3 + 1 = 4, fourth letter is "D".
   Result = "D"

* (Loop 1, step 4) Go back to step 1 with `iCol = a`

   `iCol = 1`

* (Loop 2, step 1) The column number is at least 1, proceed.

* (Loop 2, step 2) The column number less one is divided by 26:

   0 / 26 = 0 remainder 0.
   `a = 0, b = 0`

* (Loop 2, step 3) Tack on the `b+1` letter of the alphabet:

   0 + 1 = 1, first letter is "A"
   Result = "AD"

* (Loop 2, step 4) Go back to step 1 with `iCol = a`

   `iCol = 0`

* (Loop 3, step 1) The column number is less than 1, stop.


The following VBA function is just one way to convert column number values into their equivalent alphabetical characters:

```vb
Function ConvertToLetter(iCol As Long) As String
   Dim a As Long
   Dim b As Long
   a = iCol
   ConvertToLetter = ""
   Do While iCol > 0
      a = Int((iCol - 1) / 26)
      b = (iCol - 1) Mod 26
      ConvertToLetter = Chr(b + 65) & ConvertToLetter
      iCol = a
   Loop
End Function
```

**Note** This function only converts integers that are passed to it into their equivalent alphanumeric text character. It does not change the appearance of the column or the row headings on the physical worksheet.
