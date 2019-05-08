---
title: How to convert Excel column numbers into alphabetical characters
description: This article discusses how to convert integers into alphabetical characters.
author: simonxjx
manager: willchen
audience: ITPro
ms.prod: office-perpetual-itpro
ms.topic: article
ms.author: v-six
---

# How to convert Excel column numbers into alphabetical characters

## Introduction 

This article discusses how to use the Microsoft Visual Basic for Applications (VBA) function in Microsoft Excel to convert column numbers into their corresponding alphabetical character designator for the same column.

For example, the column number 30 is converted into the equivalent alphabetical characters "AD". 

## More Information

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.
The ConvertToLetter function works by using the following algorithm: 

1. Divide the column number by 27, and then put the resulting integer in the variable "i".   
2. Subtract the column number from "i" multiplied by 26, and then put the result in the variable "j".   
3. Convert the integer values into their corresponding alphabetical characters, "i" and "j" will range from 0 to 26 respectively.

For example: The column number is 30. 

1. The column number is divided by 27: 30 / 27 = 1.1111, rounded down by the Int function to "1". 

   i = 1   

1. Next Column number - (i * 26) = 30 -(1 * 26) = 30 - 26 = 4.

   j = 4   

3. Convert the values to alphabetical characters separately,

   i = 1 = "A"
   j = 4 = "D"    

4. Combined together, they form the column designator "AD".   

The following VBA function is just one way to convert column number values into their equivalent alphabetical characters:

```vb
Function ConvertToLetter(iCol As Integer) As String
   Dim iAlpha As Integer
   Dim iRemainder As Integer
   iAlpha = Int(iCol / 27)
   iRemainder = iCol - (iAlpha * 26)
   If iAlpha > 0 Then
      ConvertToLetter = Chr(iAlpha + 64)
   End If
   If iRemainder > 0 Then
      ConvertToLetter = ConvertToLetter & Chr(iRemainder + 64)
   End If
End Function
```

**Note** This function only converts integers that are passed to it into their equivalent alphanumeric text character. It does not change the appearance of the column or the row headings on the physical worksheet.