---
title: Store, calculate, and compare Date/Time data
description: Provides information on how to store, calculate, and compare Date/Time data in Access and discusses why you may get unexpected results when you calculate dates and times or compare dates and times.
author: helenclu
manager: dcscontentpm
ms.custom: 
  - CI 111294
  - CSSTroubleshoot
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: mattbum
appliesto: 
  - Access 2007
ms.date: 05/26/2025
---

# How to store, calculate, and compare Date/Time data in Microsoft Access

## Summary

This article describes how Microsoft Access stores the Date/Time data type. This article also describes why you may receive unexpected results when you calculate dates and times or compare dates and times.

This article describes the following topics:

- Store Date/Time data
- Format a Date/Time field
- Calculate time data
- Compare date data
- Compare time data

## More Information

### Store Date/Time data

Access stores the Date/Time data type as a double-precision, floating-point number up to 15 decimal places. The integer part of the double-precision number represents the date. The decimal portion represents the time.

Valid date values range from -657,434 (January 1, 100 A.D.) to 2,958,465 (December 31, 9999 A.D.). A date value of 0 represents December 30, 1899. Access stores dates before December 30, 1899 as negative numbers.

Valid time values range from .0 (00:00:00) to .99999 (23:59:59). The numeric value represents a fraction of one day. You can convert the numeric value to hours, to minutes, and to seconds by multiplying the numeric value by 24.

The following table shows how Access stores Date/Time values:

|Double number|  Date portion| Actual date| Time portion| Actual time|
|---|---|---|---|--|
|1.0| 1 |December 31, 1899| .0 |12:00:00 A.M.|
|2.5| 2| January 1, 1900| .5 |12:00:00 P.M.|
|27468.96875| 27468| March 15, 1975| .96875| 11:15:00 P.M.|
|36836.125| 36836| November 6, 2000| .125| 3:00:00 A.M.|

To view how Access stores Date/Time values as numbers, type the following commands in the Immediate window, press ENTER, and then notice the results:

?CDbl(#5/18/1999 14:00:00#)

Result equals: 36298.5833333333

?CDbl(#12/14/1849 17:32:00#)

Result equals: -18278.7305555556

To view the date and the time of numeric values, type the following commands in the Immediate window, press ENTER, and then notice the results:

?CVDate(1.375)

Result equals: 12/31/1899 9:00:00 AM

?CVDate(-304398.575)

Result equals: 8/1/1066 1:48:00 PM

### Format a Date/Time field

You can format a Date/Time value to display a date, a time, or both. When you use a date-only format, Access stores a value of 0 for the time portion. When you use a time-only format, Access stores a value of 0 for the date portion.

The following table shows how Access stores Date/Time values. The following table also shows how you can display those values by using different formats:

|Stored value (double number)| Default format (General Date)| Custom format (mm/dd/yyyy hh:nn:ss A.M./P.M.)|
|-------------------|---------------------|-----------------------------|
|36295.0| 5/15/99| 05/15/1999 12:00:00 AM|
|0.546527777777778| 1:07 PM| 12/30/1899 01:07:00 PM|
|36232.9375| 3/13/99| 10:30PM 03/13/1999 10:30:00 PM|

**Note** The default format for a Date/Time value is General Date. If a value is date-only, no time appears. If the value is time-only, no date appears.

### Calculate time data

Because a time value is stored as a fraction of a 24-hour day, you may receive incorrect formatting results when you calculate time intervals greater than 24 hours. To work around this behavior, you can create a user-defined function to make sure that time intervals are formatted correctly.

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. This includes, but is not limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you are familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure, but they will not modify these examples to provide added functionality or construct procedures to meet your specific requirements. To correctly calculate and to format time intervals, follow these steps:

1. Create a module, and then type the following line in the Declarations section if the following line is not already there:

   **Option Explicit**

2. Type the following procedure:

    ```adoc
    '------------------------------------------------------------------
    '  This function calculates the elapsed time between two values and then
    '  formats the result in four different ways.
    '
    '  The function accepts interval arguments such as the following:
    '
    '     #5/12/95 6:00:00AM# - #5/11/95 10:00:00PM#
    '
    '
    '
    '     [End Time]-[Start Time]
    '------------------------------------------------------------------

    Function ElapsedTime (Interval)
      Dim x
      x = Int(CSng(Interval * 24 * 3600)) & " Seconds"
      Debug.Print x
      x = Int(CSng(Interval * 24 * 60)) & ":" & Format(Interval, "ss") _
         & " Minutes:Seconds"
      Debug.Print x
      x = Int(CSng(Interval * 24)) & ":" & Format(Interval, "nn:ss") _
         & " Hours:Minutes:Seconds"
      Debug.Print x
      x = Int(CSng(Interval)) & " days " & Format(Interval, "hh") _
         & " Hours " & Format(Interval, "nn") & " Minutes " & _
         Format(Interval, "ss") & " Seconds"
      Debug.Print x

    End Function
    ```

3. Type the following line in the Immediate window, and then press ENTER:

   ? ElapsedTime(#6/1/1999 8:23:00PM#-#6/1/1999 8:12:12AM#)

Notice that the following values appear:

```adoc
43848 Seconds
730:48 Minutes:Seconds
12:10:48 Hours:Minutes:Seconds
0 days 12 Hours 10 Minutes 48 Seconds
```

### Compare date data

Because dates and times are stored together as double-precision numbers, you may receive unexpected results when you compare Date/Time data. For example, if you type the following expression in the Immediate window, you receive a False result even if today's date is 3/31/1999:

? Now()=DateValue("3/31/1999")

The Now() function returns a double-precision number that represents the current date and the current time. However, the DateValue() function returns an integer number that represents the date but not a fractional time value. Therefore, Now() equals DateValue() only when Now() returns a time of 00:00:00 (12:00:00 A.M.).

To receive accurate results when you compare date values, use one of the following functions. To test each function, type the function in the Immediate window, substitute the current date for 3/31/1999, and then press ENTER:

- To return an integer value, use the Date() function:

  ?Date()=DateValue("3/31/1999")

- To remove the fractional part of the Now() function, use the Int() function:

  ?Int(Now())=DateValue("3/31/1999")

### Compare time data

When you compare time values, you may receive inconsistent results because a time value is stored as the fractional part of a double-precision, floating-point number. For example, if you type the following expression in the Immediate window, you receive a false (0) result even though the two time values look the same:  

var1 = #2:01:00 PM#

var2 = DateAdd("n", 10, var1)

? var2 = #2:11:00 PM#

When Access converts a time value to a fraction, the calculated result may not be identical to the time value. The small difference caused by the calculation is sufficient to produce a false (0) result when you compare a stored value to a constant value.

To receive accurate results when you compare time values, use one of the following methods. To test each method, type each method in the Immediate window, and then press ENTER:

Add an associated date to the time comparison:

var1 = #1/1/99 2:01:00 PM#

var2 = DateAdd("n", 10, var1)

? var2 = #1/1/99 2:11:00 PM#

Convert the time values to string data types before you compare them:

var1 = #2:01:00 PM#

var2 = DateAdd("n", 10, var1)

? CStr(var2) = CStr(#2:11:00 PM#)

Use the DateDiff() function to compare precise units such as seconds:

var1 = #2:01:00 PM#

var2 = DateAdd("n", 10, var1)

? DateDiff("s", var2, #2:11:00 PM#) = 0

## References

For more information about calculating date values and time values, see [DateSerial Function](https://support.office.com/article/DateSerial-Function-A0128476-83A0-407C-831A-93F2B046F503)

For more information about how to format Date/Time data types, click **Microsoft Access Help** on the **Help** menu, type format property - date/time data type in the Office Assistant or the Answer Wizard, and then click **Search** to view the topic.
