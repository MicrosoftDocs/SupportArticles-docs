---
title: How to calculate ages before 1/1/1900 in Excel
description: Describes how to use Macro to calculate age before 1/1/1900 in Excel.
author: helenclu
manager: dcscontentpm
localization_priority: Normal
search.appverid: 
  - MET150
audience: ITPro
ms.custom: 
  - CSSTroubleshoot
ms.topic: troubleshooting
ms.author: luche
appliesto: 
  - Microsoft Excel
ms.date: 03/31/2022
---

# How to calculate ages before 1/1/1900 in Excel

## Summary

Although Microsoft Excel date formulas can only use dates entered between 1/1/1900 and 12/31/9999, you can use a custom Microsoft Visual Basic for Applications function to calculate the age (in years) of someone or something that was first created before January 1, 1900.

### Use Macro to Calculate Age

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements.

Excel enters dates prior to 1/1/1900 as text. This function works for dates entered as text beginning with 1/1/0001, normal dates, and can handle dates when the starting date is before 1900 and ending date is after 1900. To use the macro, follow these steps:

1. Start Excel. View the worksheet on which you want to use the function.
2. Press ALT+F11 to switch to the Visual Basic Editor.
3. On the Insert menu, click Module.
4. Type the following code in the module:

    ```vb
    ' This is the initial function. It takes in a start date and an end date.
    Public Function AgeFunc(stdate As Variant, endate As Variant)
    
        ' Dim our variables.
        Dim stvar As String
        Dim stmon As String
        Dim stday As String
        Dim styr As String
        Dim endvar As String
        Dim endmon As String
        Dim endday As String
        Dim endyr As String
        Dim stmonf As Integer
        Dim stdayf As Integer
        Dim styrf As Integer
        Dim endmonf As Integer
        Dim enddayf As Integer
        Dim endyrf As Integer
        Dim years As Integer
    
        ' This variable will be used to modify string length.
        Dim fx As Integer
        fx = 0
    
        ' Calls custom function sfunc which runs the Search worksheet function
        ' and returns the results.
        ' Searches for the first "/" sign in the start date.
        stvar = sfunc("/", stdate)
    
        ' Parse the month and day from the start date.
        stmon = Left(stdate, sfunc("/", stdate) - 1)
        stday = Mid(stdate, stvar + 1, sfunc("/", stdate, sfunc("/", stdate) + 1) - stvar - 1)
    
        ' Check the length of the day and month strings and modify the string 
        ' length variable.
        If Len(stday) = 1 Then fx = fx + 1
        If Len(stmon) = 2 Then fx = fx + 1
    
        ' Parse the year, using information from the string length variable.
        styr = Right(stdate, Len(stdate) - (sfunc("/", stdate) + 1) - stvar + fx)
    
        ' Change the text values we obtained to integers for calculation 
        ' purposes.
        stmonf = CInt(stmon)
        stdayf = CInt(stday)
        styrf = CInt(styr)
    
        ' Check for valid date entries.
        If stmonf < 1 Or stmonf > 12 Or stdayf < 1 Or stdayf > 31 Or styrf < 1 Then
            AgeFunc = "Invalid Date"
            Exit Function
        End If
    
        ' Reset the string length variable.
        fx = 0
    
        ' Parse the first "/" sign from the end date.
        endvar = sfunc("/", endate)
    
       ' Parse the month and day from the end date.
        endmon = Left(endate, sfunc("/", endate) - 1)
        endday = Mid(endate, endvar + 1, sfunc("/", endate, sfunc("/", endate) + 1) - endvar - 1)
      
        ' Check the length of the day and month strings and modify the string 
        ' length variable.
        If Len(endday) = 1 Then fx = fx + 1
        If Len(endmon) = 2 Then fx = fx + 1
    
        ' Parse the year, using information from the string length variable.
        endyr = Right(endate, Len(endate) - (sfunc("/", endate) + 1) - endvar + fx)
    
        ' Change the text values we obtained to integers for calculation 
        ' purposes.
        endmonf = CInt(endmon)
        enddayf = CInt(endday)
        endyrf = CInt(endyr)
    
        ' Check for valid date entries.
        If endmonf < 1 Or endmonf > 12 Or enddayf < 1 Or enddayf > 31 Or endyrf < 1 Then
            AgeFunc = "Invalid Date"
            Exit Function
        End If
    
        ' Determine the initial number of years by subtracting the first and 
        ' second year.
        years = endyrf - styrf
    
        ' Look at the month and day values to make sure a full year has passed. 
        If stmonf > endmonf Then
            years = years - 1
        End If
    
    If stmonf = endmonf And stdayf > enddayf Then
            years = years - 1
        End If
    
        ' Make sure that we are not returning a negative number and, if not, 
        ' return the years.
        If years < 0 Then
            AgeFunc = "Invalid Date"
        Else
            AgeFunc = years
        End If
    
    End Function
    
    ' This is a second function that the first will call.
    ' It runs the Search worksheet function with arguments passed from AgeFunc.
    ' It is used so that the code is easier to read.
    Public Function sfunc(x As Variant, y As Variant, Optional z As Variant)
        sfunc = Application.WorksheetFunction.Search(x, y, z)
    End Function
    ```

5. Save the file.   
6. Type the following data:

   ```asciidoc
    A1 01/01/1887
    A2 02/02/1945
   ```
    In cell A3, enter the following formula:
    ```excel
    =AgeFunc(startdate,enddate)
    ```
    The **startdate** is a cell reference to your first date (A1) and **enddate** is a cell reference to your second date (A2).

    The result should be 58.

> [!NOTE]
> Check all dates before 1/1/1900 for validity. Dates entered as text are not checked by Excel.

## References

For more information about how to use the sample code in this article, see [How to run sample code from Knowledge Base Articles in Office 2010](https://support.microsoft.com/help/212536).
