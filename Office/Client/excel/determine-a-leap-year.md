---
title: Method to determine whether a year is a leap year
description: Describes how to determine whether the year in a date that is used in an Excel document is a leap year.
author: helenclu
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.author: luche
ms.reviewer: akeeler
ms.custom: 
  - Reliability
  - CSSTroubleshoot
search.appverid: 
  - MET150
appliesto: 
  - Excel 2016
  - Excel 2016 for Mac
  - Excel 2013
  - Excel 2010
  - Excel 2007
  - Excel 2003
ms.date: 05/26/2025
---

# Method to determine whether a year is a leap year

## Summary

This article describes how to determine whether the year in a date that is used in a Microsoft Excel document is a leap year. 

## More Information

The date system that is used by Excel is based on the Gregorian calendar, first established in 1582 by Pope Gregory XIII. This calendar was designed to correct the errors introduced by the less accurate Julian calendar.

In the Gregorian calendar, a normal year consists of 365 days. Because the actual length of a sidereal year (the time required for the Earth to revolve once about the Sun) is actually 365.2425 days, a "leap year" of 366 days is used once every four years to eliminate the error caused by three normal (but short) years. Any year that is evenly divisible by 4 is a leap year: for example, 1988, 1992, and 1996 are leap years.

However, there is still a small error that must be accounted for. To eliminate this error, the Gregorian calendar stipulates that a year that is evenly divisible by 100 (for example, 1900) is a leap year only if it is also evenly divisible by 400.

For this reason, the following years are not leap years: 

1700, 1800, 1900, 2100, 2200, 2300, 2500, 2600 

This is because they are evenly divisible by 100 but not by 400.

The following years are leap years: 1600, 2000, 2400 

This is because they are evenly divisible by both 100 and 400.

Because versions of Microsoft Excel earlier than Excel 97 handle only years from 1900 to 2078, only the year 1900 is subject to the 100/400 exclusion rule of leap years in Microsoft Excel. However, in order to be compatible with other programs, Microsoft Excel treats the year 1900 as a leap year.   

### How to determine whether a year is a leap year

To determine whether a year is a leap year, follow these steps: 
 
1. If the year is evenly divisible by 4, go to step 2. Otherwise, go to step 5.    
2. If the year is evenly divisible by 100, go to step 3. Otherwise, go to step 4.    
3. If the year is evenly divisible by 400, go to step 4. Otherwise, go to step 5.    
4. The year is a leap year (it has 366 days).    
5. The year is not a leap year (it has 365 days).    
 
### Formula to determine whether a year is a leap year

Use the following formula to determine whether the year number that is entered into a cell (in this example, cell A1) is a leap year: 

```excel
=IF(OR(MOD(A1,400)=0,AND(MOD(A1,4)=0,MOD(A1,100)<>0)),"Leap Year", "NOT a Leap Year")  
```

|If the value in cell A1 is this |The formula returns |
|---------------------------------|-------------------------|
|1992| Leap Year |
|2000| Leap Year |
|1900 |NOT a Leap Year|
