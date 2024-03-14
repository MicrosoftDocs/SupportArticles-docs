---
title: Cannot accrue transactions for a date
description: Provides a solution to an error that occurs when you save a transaction or when you accrue attendance in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle, jakelaux
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Human Resources
---
# "You cannot accrue transactions for a date that isn't within an accrual period" Error message when you save a transaction or when you accrue attendance in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you save a transaction or when you accrue attendance in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 937821

## Symptoms

When you save a transaction or when you accrue attendance, you receive one of the below error messages:

> You cannot enter transactions for a date that isn't within an accrual period.  
You cannot accrue attendance for a date that isn't within an accrual period.

When you receive this error message, you can't complete the current attendance transaction or the current attendance accrual.

## Cause

This problem occurs if one or more of the following conditions are true in the Accrual Period Setup window in Microsoft Dynamics GP:

- Dates are missing from an accrual year.
- Overlapping dates exist in an accrual year.
- The accrual year isn't set up.
- Not enough years are set up.
- The transaction is for a date that hasn't been set up.
- An employee has a Next Accrual date for an accrual period that isn't set up.
- Accrual codes still active in HR for inactive employees.
- Accrual Schedule is blank on active employee from import (required field)

## Resolution

To resolve this problem, follow these steps:

1. Select Microsoft Dynamics GP, point to **Tools**, point to **Setup**, point to **Human Resources**, point to **Attendance**, and then select **Accrual Periods**.
1. Verify the following three years of accrual periods or pay periods are set up:

    a. The previous year
    b. The current year
    c. The upcoming year

1. ​​​​​​Make sure that no dates are missing from an accrual setup. To do it, select each accrual period and make sure that all the dates are included for the whole year, through December 31 (not 30). For example, if you use a semimonthly setup, you should also review the weekly and biweekly setups as well. The system reads from the top down, so be sure to set all those up for the period setups down to the one you're using. Make sure that in each setup, no dates are skipped or overlap in between periods and each year.

    Additionally, make sure that no gaps exist between periods or years.

1. Make sure that no dates exist that are included multiple times in any accrual period or in any pay period.

1. Make sure that all accrual periods or pay periods have setup information entered, even if you don't use the periods. For example, if all accrual periods or pay periods are completed on a bimonthly schedule, you still have to set up information for weekly accrual periods or for the pay periods.

1. If the errors are on transactions, make sure that the date in the **Attendance transaction entry** box is correct on the **Attendance Transaction Entry** window. Additionally, make sure that these dates fall in the accrual period or in the pay period that you want.

1. If the error is on accruals, make sure that the date in the **Accrue attendance through** box is correct on the **Accrue Attendance** window.

1. ​​​​​​​If the error is on accruals, run this script in SQL Server Management Studio against the company database to see if any employees have a Next Accrual Date that is greater than the last day of the year that you have set up periods for in the Accrual Periods or before the first date that you have Accrual Periods set up for: (For any records found, change the Next Accrual Date to a valid date in the Employee Attendance Maintenance window.)

    ```sql
    select * from TATM1030 where NEXTACCRUALDATE_I > 'YYYY-MM-DD' and INACTIVE = 0 and TIMETYPE_I = 4 --Fill in the YYYY-MM-DD placeholder with the last day of the year that you have accrual periods set up for to see if any employees have a Next Accrual Date dated in the future.
    ```

    ```sql
    select * from TATM1030 where NEXTACCRUALDATE_I < 'YYYY-MM-DD' and INACTIVE = 0 and TIMETYPE_I = 4 --Fill in the YYYY-MM-DD placeholder with the first day of the year that you have accrual periods set up for to see if any employees have a Next Accrual Date dated in the past.
    ```
