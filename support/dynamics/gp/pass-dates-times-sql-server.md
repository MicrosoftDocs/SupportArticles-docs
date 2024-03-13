---
title: Pass dates and times to SQL Server
description: Explains that you must pass dates and times in formats that don't conflict with the computer's regional settings.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/13/2024
---
# How to pass dates and times to SQL Server from Dexterity in Microsoft Dynamics GP

This article describes how to pass dates and times to Microsoft SQL Server from Dexterity in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 929786

## Introduction

Make sure that the dates and the times that you pass to SQL Server are in formats that don't conflict with the formats that are specified in the computer's regional settings. It's true when you write pass-through SQL statements or Range Where clauses in Dexterity or when you call stored procedures.

SQL Server recognizes dates in the following formats:

- YYYYMMDD
- MM/DD/YYYY

> [!NOTE]
> In these formats, YYYY represents the four-digit year, MM represents the two-digit month, and DD represents the two-digit day.

SQL Server recognizes times in the following formats:

- HH:MM:SS (for the 24-hour time format)
- HH:MM:SS **XX** (for the 12-hour time format)

> [!NOTE]
>
> - In these formats, HH represents the two-digit hour, MM represents the two-digit minute, and SS represents the two-digit second.
> - In the 12-hour time format, replace **XX** with **AM**, **am**, **PM**, or **pm**.

You can use the str() function to convert a date or a time to a string value. This string value is then passed to SQL Server. In this situation, the computer's regional settings determine the format of the string value that is passed to SQL Server. So the following behavior may occur:

- If the DD/MM/YYYY date format is specified in the computer's regional settings, the date that is passed to SQL Server is incorrect for the first 12 days of each month. Additionally, on each remaining day of the month, SQL Server generates the following SQL Error 241 message:
    > Syntax error converting datetime from character string.

- If the 12-hour time format together with an abbreviation other than "AM," "am," "PM," or "pm" is specified in the computer's regional settings, SQL Server generates the following SQL Error 241 message:
    > Syntax error converting datetime from character string.

    > [!NOTE]
    > For example, if the 12-hour time format together with **A.M.** or **p.m.** is specified in the computer's regional settings, SQL Server generates this message.

## Pass dates to SQL Server from Dexterity

To pass dates to SQL Server from Dexterity, use the sqlDate function instead of the str() function. The sqlDate function is built into Microsoft Dynamics GP. To format a date, you can call this function in the code that you write.

> [!NOTE]
> The sqlDate function doesn't add the single quotation marks that are required when you pass the date to SQL Server. So enclose the result of the function by using single quotation marks.

## Pass times to SQL Server from Dexterity

Microsoft provides programming examples for illustration only, without warranty either expressed or implied. Which includes, but isn't limited to, the implied warranties of merchantability or fitness for a particular purpose. This article assumes that you're familiar with the programming language that is being demonstrated and with the tools that are used to create and to debug procedures. Microsoft support engineers can help explain the functionality of a particular procedure. However, they won't modify these examples to provide added functionality or construct procedures to meet your specific requirements.

To pass times to SQL Server from Dexterity, you must use a function that you create instead of the str() function. You must create a function because Microsoft Dynamics GP doesn't have a function that formats time in the manner that the sqlDate function formats dates.

The following code example creates a sqlTime function that passes the time to SQL Server.

```sql
{ Global Function : sqlTime }
function returns string OUT_String;
in time IN_Time;

OUT_String = pad(str(hour(IN_Time)), LEADING, CH_0, 2) + CH_COLON + 
pad(str(minute(IN_Time)), LEADING, CH_0, 2) + CH_COLON + 
pad(str(second(IN_Time)), LEADING, CH_0, 2);
```

For more information, see [How to write "Passthrough" SQL statements and "Range Where" clauses in Microsoft Great Plains Dexterity](https://support.microsoft.com/help/910129).
