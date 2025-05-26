---
title: Excel works with two-digit year numbers
description: Describes how Microsoft Excel determines the century when you  type a date using a two-digit year number.
author: helenclu
manager: dcscontentpm
search.appverid: 
  - MET150
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - Editing\Cells
  - CSSTroubleshoot
ms.author: luche
appliesto: 
  - Microsoft Excel
ms.date: 05/26/2025
---

# How Excel works with two-digit year numbers

## Summary

When you type a date using a two-digit year number (such as 98), Microsoft Excel uses specific rules to determine which century to use for the date. This article explains how Microsoft Excel determines the century.

## More information

When you type a date in a cell, if you omit the century digits from the year, Excel automatically determines which century to use for the date.

For example, if you type `7/5/98`, Excel automatically uses the year 1998 and changes the date to `7/5/1998` in the formula bar.

The following sections explain the default rules that Excel uses.

### Using the Regional Settings in Control Panel

Excel first interprets date according to the date ordering defined by the **Short date style** setting under Regional Settings in Control Panel, for example, M/d/yy.

You can use the **When a two digit year is entered, interpret a year between** setting under Regional Settings in Control Panel to determine the cutoff year for the century. The default value is 2029, but you can change it to any value between 99 and 9999.

> [!NOTE]
> You can change the **When a two digit year is entered, interpret a year between** setting to a value that isn't compatible with Excel. If you enter an incompatible value, Excel reverts to the rules discussed in the "The 2029 Rule" section of this article.

To change the century cutoff date, follow these steps:

1. Select **Start**, point to **Settings**, and then select **Control Panel**.   
2. Double-click the **Regional Settings** icon.   
3. Select the **Date** tab.   
4. In the **When a two digit year is entered, interpret a year between** box, type the cutoff year that you want, and then select **OK**.   

The following table illustrates the effect that various cutoff years have when you type a two-digit year in Excel:

Regional Settings

|Setting|Date typed |Date used|
|----------|------------|------|
|2039| 9/7/70| 9/7/1970|
|2039| 2/3/27| 2/3/2027|
|2075| 9/7/70| 9/7/2070|
|2099| 2/3/27| 2/3/2027|

> [!NOTE]
> It modifies the way Excel interprets dates only when they're typed into a cell. If you import or programmatically enter a date, the following 2029 rule is always in effect.

### The 2029 Rule

By default, Excel determines the century by using a cutoff year of 2029, which results in the following behavior:

- Dates in the inclusive range from January 1, 1900 (1/1/1900) to December 31, 9999 (12/31/9999) are valid.

- When you type a date that uses a two-digit year, Excel uses the following centuries:

    |Two-digit year typed| Century used|
    |----------|----------------|
    |00-29| 21st (year 2000)|
    |30-99 |20th (year 1900)|

    For example, when you type the following dates, Excel interprets these as follows:

    |Date typed |Date used|
    |----------------|---------|
    |7/4/00| 7/4/2000|
    |1/1/10| 1/1/2010|
    |12/31/29| 12/31/2029|
    |1/1/30| 1/1/1930|
    |7/5/98| 7/5/1998|
    |12/31/99| 12/31/1999|

- If you want to type a date that is before January 1, 1930, or after December 31, 2029, you must type the full four-digit year. For example, to use the date July 4, 2076, type 7/4/2076.

### Entering Dates That Contain Only Day/Month or Month/Year Components

So far, this article discusses how Excel interprets three-part date entries that contain month, day, and year components. It's possible to enter a two-part date that contains only the day and month, or the month and year components of the date. Two-part dates are inherently ambiguous and should be avoided if possible. This section discusses how Excel handles date entries that contain only two parts.

When you enter a date that contains only two of the three date components, Excel assumes that the date is in the form of Day/Month or Month/Year. Excel first attempts to resolve the entry as a Day/Month entry in the current year. If it can't resolve the entry in the Day/Month form, Excel attempts to resolve the entry in the Month/Year form, using the first day of that month. If it can't resolve the entry in the Month/Year form, Excel interprets the entry as text.

The following table illustrates how Excel interprets various date entries that contain only two of the three date components.

> [!NOTE]
> This table assumes that the current year is 1999.

|Entry| Resolution|
|-----|----------|
|12/01| 12/1/1999|
|12/99| 12/1/1999|
|11/95 |11/1/1995|
|13/99 |13/99 (text)|
|1/30| 1/30/1999|
|1/99| 1/1/1999|
|12/28 |12/28/1999|

> [!NOTE]
> This table illustrates how Excel stores the date, not how the date is displayed in the cell. The display format of the date varies according to the date formats that have been applied to the cell, and the current settings under Regional Settings in Control Panel.
