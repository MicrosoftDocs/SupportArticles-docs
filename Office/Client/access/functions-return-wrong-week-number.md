---
title: Format or DatePar functions return a wrong week number for a date
description: When determining the week number of a date using either the Format or DatePart function, the last Monday in some calendar years is returned as week 53 when it should be week 1.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - CI 110058
  - CSSTroubleshoot
ms.reviewer: denniwil
appliesto: 
  - Access
search.appverid: MET150
ms.date: 05/26/2025
---

# Format or DatePart functions can return wrong week number for last Monday in Year

> [!WARNING]
> There is an issue with the use of this function. The last Monday in some calendar years can be returned as week 53 when it should be week 1. For more information and a workaround, see [Format or DatePart functions can return wrong week number for last Monday in Year](functions-return-wrong-week-number.md).

## Symptoms

When you use either the Format or DatePart function to determine the week number for dates using the following syntax:

- `Format(AnyDate, "ww", vbMonday, vbFirstFourDays)`
- `DatePart("ww", AnyDate, vbMonday, vbFirstFourDays)`

The last Monday in some calendar years is returned as week 53 when it should be week 1.

## Cause

When determining the week number of a date according to the ISO 8601 standard, the underlying function call to the Oleaut32.dll file mistakenly returns week 53 instead of week 1 for the last Monday in certain years.

## Resolution

Use a user-defined function to return the Week number based on the rules for the ISO 8601 standard. [An example is included in this article.](#workarounds)

## More Information

The ISO 8601 standard is used extensively in Europe and includes the following:

```asciidoc
ISO 8601 "Data elements and interchange formats - Information interchange   - Representation of dates and times"
ISO 8601 : 1988 (E) paragraph 3.17:
"week, calendar: A seven day period within a calendar year, starting on a Monday and identified by its ordinal number within the year; the first calendar week of the year is the one that includes the first Thursday of that year. In the Gregorian calendar, this is equivalent to the week which includes 4 January."
```

This can be implemented by applying these rules for Calendar weeks:

- A year is divided into either 52 or 53 calendar weeks.
- A calendar week has seven days. Monday is day 1 and Sunday is day 7.
- The first calendar week of a year is the one containing at least four days.
- If a year isn't concluded on a Sunday, either its 1-3 last days belong to next year's first calendar week or the first 1-3 days of next year belong to the present year's last calendar week.
- Only a year starting or concluding on a Thursday has 53 calendar weeks.

In Visual Basic and Visual Basic for Applications, all date functionality, except for the DateSerial function, comes from calls to the Oleaut32.dll file. Because both the Format() and DatePart() functions can return the calendar week number for a given date, both are affected by this bug. To avoid this problem, you must use the alternative code that this article provides.

### Steps to Reproduce Behavior

1. Open the Visual Basic project within an Office application (Alt + F11).
2. From the **Project** menu, add a new module.
3. Paste the following code into the module:

   ```vb
   Option Explicit

   Public Function Test1()
   ' This code tests a "problem" date and the days around it
   Dim DateValue As Date
   Dim i As Integer

   Debug.Print "   Format function:"
   DateValue = #12/27/2003#
   For i = 1 To 4   ' examine the last 4 days of the year
    DateValue = DateAdd("d", 1, DateValue)
    Debug.Print "Date: " & DateValue & "   Day: " & _
    Format(DateValue, "ddd") & "   Week: " & _
    Format(DateValue, "ww", vbMonday, vbFirstFourDays)
   Next i
   End Function

   Public Function Test2()
   ' This code lists all "Problem" dates within a specified range
    Dim MyDate As Date
    Dim Years As Long
    Dim days As Long
    Dim woy1 As Long
    Dim woy2 As Long
    Dim ToPrint As String

    For Years = 1850 To 2050
    For days = 0 To 3
    MyDate = DateSerial(Years, 12, 28 + days)
    woy1 = Format(MyDate, "ww", vbMonday, vbFirstFourDays)
    woy2 = Format(MyDate, "ww", vbMonday, vbFirstFourDays)
    If woy2 > 52 Then
    If Format(MyDate + 7, "ww", vbMonday, vbFirstFourDays) = 2 Then _
    woy2 = 1
    End If
    If woy1 <> woy2 Then
    ToPrint = MyDate & String(13 - Len(CStr(MyDate)), " ")
    ToPrint = ToPrint & Format(MyDate, "dddd") & _
    String(10 - Len(Format(MyDate, "dddd")), " ")
    ToPrint = ToPrint & woy1 & String(5 - Len(CStr(woy1)), " ")
    ToPrint = ToPrint & woy2
    Debug.Print ToPrint
    End If
    Next days
   Next Years
   End Function
   ```

4. Use (Ctrl + G) to open the Immediate Window if it's not already open.
5. Type **?Test1** in the Immediate window and hit Enter, note the following results in the Immediate window:

   ```asciidoc
   Format function:
   Date: 12/28/03   Day: Sun   Week: 52
   Date: 12/29/03   Day: Mon   Week: 53
   Date: 12/30/03   Day: Tue   Week: 1
   Date: 12/31/03   Day: Wed   Week: 1
   ```

   With this format, all weeks start with Monday, so that December 29, 2003 should be considered the start of Week 1 and not part of Week 53.

6. Type **?Test2** in the Immediate window and hit Enter to see a list of dates in the specified range that experience this problem. The list includes the date, Week day (always Monday), the Week # returned by Format (53), and the Week number it should return (1.) For example:

   ```asciidoc
   12/29/1851   Monday    53   1
   12/31/1855   Monday    53   1
   12/30/1867   Monday    53   1
   12/29/1879   Monday    53   1
   12/31/1883   Monday    53   1
   12/30/1895   Monday    53   1
   ...
   ```

### Workarounds

If you use the Format or DatePart functions, you need to check the return value. When it's 53, run another check and force a return of 1, if necessary. This code sample demonstrates one way to do this:

```vb
Function WOY (MyDate As Date) As Integer   ' Week Of Year
  WOY = Format(MyDate, "ww", vbMonday, vbFirstFourDays)
  If WOY > 52 Then
    If Format(MyDate + 7, "ww", vbMonday, vbFirstFourDays) = 2 Then WOY = 1
  End If
End Function
```

You can avoid using these functions to determine Week number by writing code that implements the ISO 8601 rules described above. The following example demonstrates a replacement function to return the Week number.

### Step by Step Example

1. Open the Visual Basic project within an Office application (Alt + F11).
2. From the **Project** menu, add a new module.
3. Paste the following code into the module:

   ```vb
   Option Explicit

   Function WeekNumber(InDate As Date) As Integer
    Dim DayNo As Integer
    Dim StartDays As Integer
    Dim StopDays As Integer
    Dim StartDay As Integer
    Dim StopDay As Integer
    Dim VNumber As Integer
    Dim ThurFlag As Boolean

    DayNo = Days(InDate)
    StartDay = Weekday(DateSerial(Year(InDate), 1, 1)) - 1
    StopDay = Weekday(DateSerial(Year(InDate), 12, 31)) - 1
    ' Number of days belonging to first calendar week
    StartDays = 7 - (StartDay - 1)
    ' Number of days belonging to last calendar week
    StopDays = 7 - (StopDay - 1)
    ' Test to see if the year will have 53 weeks or not
    If StartDay = 4 Or StopDay = 4 Then ThurFlag = True Else ThurFlag = False
    VNumber = (DayNo - StartDays - 4) / 7
    ' If first week has 4 or more days, it will be calendar week 1
    ' If first week has less than 4 days, it will belong to last year's
    ' last calendar week
    If StartDays >= 4 Then 
    WeekNumber = Fix(VNumber) + 2 
    Else 
    WeekNumber = Fix(VNumber) + 1
    End If
    ' Handle years whose last days will belong to coming year's first
    ' calendar week
    If WeekNumber > 52 And ThurFlag = False Then WeekNumber = 1
    ' Handle years whose first days will belong to the last year's 
    ' last calendar week
    If WeekNumber = 0 Then
    WeekNumber = WeekNumber(DateSerial(Year(InDate) - 1, 12, 31))
    End If
   End Function

   Function Days(DayNo As Date) As Integer
    Days = DayNo - DateSerial(Year(DayNo), 1, 0)
   End Function

   Public Function Test3()
    Dim DateValue As Date, i As Integer
   
    Debug.Print "   WeekNumber function:"
    DateValue = #12/27/2003#
    For i = 1 To 4   ' examine the last 4 days of the year
    DateValue = DateAdd("d", 1, DateValue)
    Debug.Print "Date: " & DateValue & "   Day: " & _
         Format(DateValue, "ddd") & "   Week: " & WeekNumber(DateValue)
    Next i
   End Function
   ```

4. Use (Ctrl + G) to open the Immediate Window if it's not already open.
5. Type **?Test3** in the Immediate window and hit Enter, note the following results in the Immediate window:

   ```asciidoc
   WeekNumber function:
   Date: 12/28/03   Day: Sun   Week: 52
   Date: 12/29/03   Day: Mon   Week: 1
   Date: 12/30/03   Day: Tue   Week: 1
   Date: 12/31/03   Day: Wed   Week: 1
   ```

   Monday is considered to be Week 1 as it should be.
