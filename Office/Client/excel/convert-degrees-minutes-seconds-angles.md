---
title: Convert degrees/minutes/seconds angles to or from decimal angles
description: Provides a custom function that you can use to convert a degree value that is stored in decimal format to DMS stored in text format, or you can use the custom function to convert DMS to a degree value that is stored in decimal format.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.custom: 
  - CSSTroubleshoot
ms.reviewer: garymu
search.appverid: 
  - MET150
appliesto: 
  - Excel 2010
  - Microsoft Office Excel 2007
  - Microsoft Office Excel 2003
ms.date: 03/31/2022
---

# How to convert degrees/minutes/seconds angles to or from decimal angles in Excel

## Summary

Angular measurements are commonly expressed in units of degrees, minutes, and seconds (DMS). 1 degree equals 60 minutes, and one minute equals 60 seconds. To simplify some mathematical calculations, you may want to express angular measurements in degrees and decimal fractions of degrees.

This article contains a sample custom function you can use to convert a degree value stored in decimal format, to DMS stored in text format, and a sample function that converts DMS to a degree value stored in decimal format.

## More Information

Microsoft provides programming examples for illustration only, without warranty either expressed or implied, including, but not limited to, the implied warranties of merchantability and/or fitness for a particular purpose. This article assumes that you are familiar with the programming language being demonstrated and the tools used to create and debug procedures. Microsoft support professionals can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific needs.

 If you have limited programming experience, you may want to contact a Microsoft Advisory Services. For more information, visit the Microsoft Web site:

Microsoft Advisory Services - [https://support.microsoft.com/gp/advisoryservice](https://support.microsoft.com/gp/advisoryservice)

For more information about the support options that are available and about how to contact Microsoft, see [https://support.microsoft.com](https://support.microsoft.com).

### Converting Decimal Degrees to Degrees/Minutes/Seconds

The following Microsoft Visual Basic for Applications custom function accepts an angle formatted as a decimal value and converts it to a text value displayed in degrees, minutes, and seconds.

```vb
Function Convert_Degree(Decimal_Deg) As Variant
    With Application
        'Set degree to Integer of Argument Passed
        Degrees = Int(Decimal_Deg)
        'Set minutes to 60 times the number to the right
        'of the decimal for the variable Decimal_Deg
        Minutes = (Decimal_Deg - Degrees) * 60
        'Set seconds to 60 times the number to the right of the
        'decimal for the variable Minute
        Seconds = Format(((Minutes - Int(Minutes)) * 60), "0")
        'Returns the Result of degree conversion
        '(for example, 10.46 = 10~ 27  ' 36")
        Convert_Degree = " " & Degrees & "° " & Int(Minutes) & " ' " & Seconds + Chr(34)
    End With
End Function
```

To use this function, create a conversion formula, as in the following example:

1. Start Excel and press ALT+F11 to start the Visual Basic editor.
2. On the Insert menu, click Module.
3. Enter the sample code for the Convert_Degree custom function described above into the module sheet.
4. Press ALT+F11 to return to excel.
5. In cell A1 type 10.46.
6. In cell A2 type the formula: =Convert_Degree(A1)

   The formula returns 10°27'36"

### Converting Degrees/Minutes/Seconds to Decimal Degrees

The following Microsoft Visual Basic for Applications custom function accepts a text string of degrees, minutes, and seconds formatted in the exact same format that the Convert_Degree function returns (for example, 10° 27' 36") and converts it to an angle formatted as a decimal value. This is exactly the reverse of the Convert_Degree custom function.

> [!WARNING]
> This custom function fails if the Degree_Deg argument is not in the format \<degrees>° \<minutes>' \<seconds>" even if the seconds value is 0.

```vb
Function Convert_Decimal(Degree_Deg As String) As Double
    ' Declare the variables to be double precision floating-point

   Dim degrees As Double
   Dim minutes As Double
   Dim seconds As Double
   ' Set degree to value before "°" of Argument Passed.
   Degree_Deg = Replace(Degree_Deg, "~", "°")


   degrees = CDbl(Left(Degree_Deg, InStr(1, Degree_Deg, "°") - 1))
   ' Set minutes to the value between the "°" and the "'"
   ' of the text string for the variable Degree_Deg divided by
   ' 60. The Val function converts the text string to a number.
   minutes = CDbl(Mid(Degree_Deg, InStr(1, Degree_Deg, "°") + 1, _
             InStr(1, Degree_Deg, "'") - InStr(1, Degree_Deg, "°") - 1)) / 60
   ' Set seconds to the number to the right of "'" that is
   ' converted to a value and then divided by 3600.
   seconds = CDbl(Mid(Degree_Deg, InStr(1, Degree_Deg, "'") + _
           1, Len(Degree_Deg) - InStr(1, Degree_Deg, "'") - 1)) / 3600

   Convert_Decimal = degrees + minutes + seconds

End Function
```

To use this function, create a conversion formula, as in the following example:

1. Start Excel and press ALT+F11 to start the Visual Basic Editor.
1. On the Insert menu, click Module.
1. Enter the sample code for the Convert_Decimal custom function described above into the module sheet.
1. Press ALT+F11 to return to excel.
1. In cell A1 type the following formula:

   =Convert_Decimal("10° 27' 36""")

    > [!NOTE]
    > You are required to type three quotation marks (""") at the end of the argument of this formula to balance the quotation mark for the seconds and the quotation mark for the text string. A cell reference will not require a quotation mark.

1. The formula returns 10.46
