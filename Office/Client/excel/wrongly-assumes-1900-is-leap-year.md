---
title: Excel incorrectly assumes that the year 1900 is a leap year
description: Explains why the year 1900 is treated as a leap year in Excel 2000. This article outlines the behaviors that occur if this specific issue is corrected.
author: helenclu
ms.author: luche
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.reviewer: bradthor
ms.custom: 
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Microsoft Excel for Mac 2011
  - Excel for Microsoft 365 for Mac 
  - Microsoft Office Excel 2003
  - Microsoft Office Excel 2007
  - Excel 2010
  - Excel 2013
  - Excel 2016
ms.date: 03/31/2022
---

# Excel incorrectly assumes that the year 1900 is a leap year

## Symptoms

Microsoft Excel incorrectly assumes that the year 1900 is a leap year. This article explains why the year 1900 is treated as a leap year, and outlines the behaviors that may occur if this specific issue is corrected.

## More Information

When Lotus 1-2-3 was first released, the program assumed that the year 1900 was a leap year, even though it actually was not a leap year. This made it easier for the program to handle leap years and caused no harm to almost all date calculations in Lotus 1-2-3.

When Microsoft Multiplan and Microsoft Excel were released, they also assumed that 1900 was a leap year. This assumption allowed Microsoft Multiplan and Microsoft Excel to use the same serial date system used by Lotus 1-2-3 and provide greater compatibility with Lotus 1-2-3. Treating 1900 as a leap year also made it easier for users to move worksheets from one program to the other.

Although it is technically possible to correct this behavior so that current versions of Microsoft Excel do not assume that 1900 is a leap year, the disadvantages of doing so outweigh the advantages.

If this behavior were to be corrected, many problems would arise, including:

- Almost all dates in current Microsoft Excel worksheets and other documents would be decreased by one day. Correcting this shift would take considerable time and effort, especially in formulas that use dates.
- Some functions, such as the WEEKDAY function, would return different values; this might cause formulas in worksheets to work incorrectly.
- Correcting this behavior would break serial date compatibility between Microsoft Excel and other programs that use dates.

If the behavior remains uncorrected, only one problem occurs:

- The WEEKDAY function returns incorrect values for dates before March 1, 1900. Because most users do not use dates before March 1, 1900, this problem is rare.
  
NOTE: Microsoft Excel correctly handles all other leap years, including century years that are not leap years (for example, 2100). Only the year 1900 is incorrectly handled.

## References

For more information about determining whether a given year is a leap year, see [Method to Determine Whether a Year Is a Leap Year](determine-a-leap-year.md).
