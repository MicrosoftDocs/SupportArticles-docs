---
title: Calculate age in months and in years
description: Describes how to create two functions that you can use to calculate the age of a person or of a thing that are based on a specified date in Access.
author: Cloud-Writer
manager: dcscontentpm
ms.custom: 
  - CI 111294
  - CSSTroubleshoot
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: meerak
ms.reviewer: mattbum
appliesto: 
  - Access 2007
  - Access 2003
  - Access 2002
ms.date: 05/26/2025
---

# How to create two functions to calculate age in months and in years in Access

Advanced: Requires expert coding, interoperability, and multiuser skills. 

This article applies to a Microsoft Office Access database (.accdb and .mdb) and to Microsoft Access project (`.apd`).

## Summary

This article shows you how to create two functions that you can use to calculate the age of a person or thing based on a specified date.

> [!NOTE]
> You can see a demonstration of the technique that is used in this article in the sample file Qrysmp00.exe.

## More information

### Creating the Functions

Type or paste the following code in a module:

```vb
'==========================================================
' General Declaration
'==========================================================
Option Explicit

'*************************************************************
' FUNCTION NAME: Age()
'
' PURPOSE:
'    Calculates age in years from a specified date to today's date.
'
' INPUT PARAMETERS:
'    StartDate: The beginning date (for example, a birth date).
'
' RETURN
'    Age in years.
'
'*************************************************************
Function Age (varBirthDate As Variant) As Integer
   Dim varAge As Variant

If IsNull(varBirthdate) then Age = 0: Exit Function

varAge = DateDiff("yyyy", varBirthDate, Now)
   If Date < DateSerial(Year(Now), Month(varBirthDate), _
                        Day(varBirthDate)) Then
      varAge = varAge - 1
   End If
   Age = CInt(varAge)
End Function

'*************************************************************
' FUNCTION NAME: AgeMonths()
'
' PURPOSE:
'  Compliments the Age() function by calculating the number of months
'  that have expired since the last month supplied by the specified date.
'  If the specified date is a birthday, the function returns the number of
'    months since the last birthday.
'
' INPUT PARAMETERS:
'    StartDate: The beginning date (for example, a birthday).
'
' RETURN
'    Months since the last birthday.
'*************************************************************
Function AgeMonths(ByVal StartDate As String) As Integer

Dim tAge As Double
   tAge = (DateDiff("m", StartDate, Now))
   If (DatePart("d", StartDate) > DatePart("d", Now)) Then
      tAge = tAge - 1
   End If
   If tAge < 0 Then
      tAge = tAge + 1
   End If

AgeMonths = CInt(tAge Mod 12)

End Function

```

### Testing the Age() and AgeMonths() Functions

To test the Age() and AgeMonths() functions, follow these steps.

> [!IMPORTANT]
> The following steps ask you to change the date on your computer. Make sure that you complete step 6 to reset the date to the current date.

1. By using the Date/Time tool in Control Panel, make a note of the current date, and then set the date to June 3, 2001.   
2. Open a module or create a new one.   
3. On the View menu, click Immediate Window.   
4. Assume your friend's birth date was November 15, 1967 and today is June 3, 2001. Type the following line in the Immediate window, and then press ENTER: 

    ?Age("11/15/67")

   Note that Microsoft Access responds with the value 33 (years).   
5. Type the following line, and then press ENTER: 

    ?AgeMonths("11/15/67")

    Note that Microsoft Access responds with the value 6, indicating that six months have passed since this person's last birthday. Your friend is 33 years and six months old.   
6. By using the Date/Time tool in Control Panel, reset the date to the current date that you noted in step 1.   

### Using the Age() and AgeMonths() Functions

The following procedure explains how to mark old orders by placing the age value in a new control. 

1. In the sample database Northwind.mdb, type the Age() and AgeMonth() functions in a new module.   
2. Open the Orders form in Design view and add an unbound text box control.   
3. Type the following line in the ControlSourceproperty of the new text box control:

   =Age([OrderDate]) & " yrs " & AgeMonths([OrderDate]) & " mos"
4. View the form in Form view. Note that the age of the order is displayed in the new text box control.

## References

For more information about date differences, in the Visual Basic Editor, click Microsoft Visual Basic Help on the Help menu, type datediff function in the Office Assistant or the Answer Wizard, and then click Search to view the article.
