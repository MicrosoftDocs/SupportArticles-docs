---
title: Can't accrue transactions for a date
description: Provides a solution to an error that occurs when you save a transaction or accrue attendance in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle, jakelaux
ms.topic: troubleshooting
ms.date: 10/25/2024
ms.custom: sap:Human Resources
---
# "You cannot accrue transactions for a date that isn't within an accrual period" error when you save a transaction or accrue attendance

This article provides a solution to an error that occurs when you save a transaction or [accrue attendance](/dynamics-gp/payroll/humanresource#attendance-setup) in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 937821

## Symptoms

When you save a transaction or accrue attendance, you receive one of the following error messages:

> You cannot enter transactions for a date that isn't within an accrual period.

> You cannot accrue attendance for a date that isn't within an accrual period.

As a result, you can't complete the current attendance transaction or the current attendance accrual.

## Cause

This problem occurs if one or more of the following conditions are true in the **Accrual Period Setup** window:

- Dates are missing from an accrual year.
- Overlapping dates exist in an accrual year.
- The accrual year isn't set up.
- Not enough years are set up.
- The transaction is for a date that isn't set up.
- An employee has a **Next Accrual** date for an accrual period that isn't set up.
- Accrual codes are active for inactive employees in Human Resources.
- The **Time code Accrual Period** isn't set up.
- The **Accrual Period** on the **Accrual** isn't set up.
- The **Accrual Schedule** (required field) is blank for an active employee from import.

## Resolution

To resolve this problem, follow these steps:

1. Select **Microsoft Dynamics GP**, point to **Tools** > **Setup** > **Human Resources** > **Attendance**, and then select **Accrual Periods**.
2. Verify the following three years of accrual periods or pay periods are set up:

    1. The previous year
    1. The current year
    1. The upcoming year

3. ​​​Make sure that no dates are missing from an accrual setup.

   To do this, select each accrual period and make sure that all the dates are included for the whole year, through December 31 (not 30). For example, if you use a semimonthly setup, you should also review the weekly and biweekly setups. The system reads from the top down, so be sure to set all those up for the period setups down to the one you're using. Make sure that in each setup, no dates are skipped or overlap in between periods and each year.

    Additionally, make sure that no gaps exist between periods or years.

4. Make sure that no dates are included multiple times in any accrual period or in any pay period.

5. Make sure that all accrual periods or pay periods have setup information, even if you don't use the periods.

   For example, if all accrual periods or pay periods are completed on a biweekly schedule, you still have to set up information for weekly accrual periods or for the pay periods. Errors can occur if any setup is accidentally configured for a different pay period, especially for new employees. To avoid these issues, it's best practice to set up all periods for the entire year.

6. If the error occurs on transactions, make sure that the date in the **Attendance transaction entry** box is correct in the **Attendance Transaction Entry** window. Additionally, make sure that these dates fall in the accrual period or in the pay period that you want.

7. If the error occurs on accruals, make sure that the date in the **Accrue attendance through** box is correct in the **Accrue Attendance** window.

8. ​​​​​​​If the error occurs on accruals, run the following script in SQL Server Management Studio against the company database to see if any employees have a **Next Accrual Date** that's greater than the last day of the year that you set up periods for in the **Accrual Periods** or before the first date that you have **Accrual Periods** set up for. For any records found, change the **Next Accrual Date** to a valid date in the **Employee Attendance Maintenance** window.

    ```sql
    select * from TATM1030 where NEXTACCRUALDATE_I > 'YYYY-MM-DD' and INACTIVE = 0 and TIMETYPE_I = 4 --Fill in the YYYY-MM-DD placeholder with the last day of the year that you have accrual periods set up for to see if any employees have a Next Accrual Date dated in the future.
    ```

    ```sql
    select * from TATM1030 where NEXTACCRUALDATE_I < 'YYYY-MM-DD' and INACTIVE = 0 and TIMETYPE_I = 4 --Fill in the YYYY-MM-DD placeholder with the first day of the year that you have accrual periods set up for to see if any employees have a Next Accrual Date dated in the past.
    ```
