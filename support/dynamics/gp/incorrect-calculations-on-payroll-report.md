---
title: Incorrect calculations on a Payroll Report
description: Provides a solution to an issue where incorrect calculations are on the Payroll 941 Quarterly Summary Report in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Payroll
---
# Incorrect calculations are on the Payroll 941 Quarterly Summary Report in Microsoft Dynamics GP

This article provides a solution to an issue where incorrect calculations are on the Payroll 941 Quarterly Summary Report in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2249718

## Symptoms

How the line information pulls for the Payroll 941 report in Microsoft Dynamics GP.

## Resolution

The information for the 941 report pulls from the following tables:

- Payroll Employee Summary File (UPR00900)
- Payroll Employee Tips Summary File (UPR00901)
- Tax Liability File (UPR30200)

### Line 1: Number of Employees

Line 1 includes both active and inactive employees. Law requires that the 941 report includes the total number of employees for all quarters. The number of employees is based on the number of employees that are paid during the period for which you're reporting. Because Microsoft Dynamics GP doesn't maintain a daily count of employees, an approximation is all that can be completed. The count also doesn't include employees that have a **Household Employee** tax status.

### Line 2: Wages and Tips, and other compensation

The calculation for Line 2 is as follows:

- The amount in the **Gross Wages** field in the Employee Summary window plus the amount in the **Reported Tips** field and the amount in the **Charged Tips** field in the Employee Tips Summary window.
- The amount in the **Pension Wages** field is subtracted, and then the amount in the **Taxable Benefit** field from the Employee Benefit Maintenance window is added.
- Finally, it reduces this net amount by any deductions that are sheltered from federal tax.

### Line 3: Total Income Tax Withheld from wages, tips, and other compensation

Line 3 uses the amount in the **Federal Tax Withheld** field in the Employee Summary window for all employees. This amount doesn't include tax on pension pay types.

### Line 4

If wages, tips and other compensation aren't subject to social security or Medicare Tax, an **X** will be displayed on this line.

### Line 5: Taxable social security and Medicare wages and tips

- Line 5a: Taxable Social Security Wages

    Line 5a uses the amount in the **FICA Soc Sec Wages** field from the Employee Summary window. The amount in the **FICA Soc Sec Wages** field for each month in the year in the UPR_Employee_SUM (UPR00900) for employee social security multiplied by 12.4. (Employee + Employer share).  

- Line 5b: Taxable Social Security Tips

    The calculation for Line 5b is as follows. The amount in the **Reported Tips** field plus the amount in the **Charged Tips** field in the Employee Tips Summary window.

- Line 5c: Taxable Medicare Wages and Tips

    The calculation for Line 5c is as follows. The amount in the **FICA Medicare Wages** field in the Employee Summary window plus the amount in the **Reported Tips** field and the **Charged Tips** field in the Employee Tips Summary window. The amount in the **FICA Medicare Wages** field for each month of the year in the UPR_Employee_SUM (UPR00900) table multiplied by 2.9.  (Employee + Employer share).

- Line 5d: Taxable Wages & Tips subject to Additional Medicare Tax Withholding

    The calculation for Line 5d sums FICA Medicare Wages and Tips field for each month of the year in the UPR_Employee_SUM (UPR00900) over $200,000 multiplied by .9.  (Employee only).

- Line 5e: Total Social Security and Medicare Taxes

    Line 5e sums the amounts in Line 5a through Line 5d.

### Line 6: Total taxes before adjustments

Line 6 sums the amounts in Line 3 and Line 5e.

### Line 7: Tax adjustments

- Line 7a: Current quarter's fraction of cents

    The calculation for Line 7a is as follows. The Actual Social Security Tax Withheld calculation is the amount in the **FICA Soc Sec Tax Withheld** field for each month of the fiscal year plus the amount in the **FICA Medicare Tax Withheld** field for each month of the fiscal year in the UPR00900 table for employee.  The employer amount is held in the **EFIC Soc Sec W/H** field for each payroll that is processed in the UPR30200 table.

    The Actual Social Security Tax Withheld amount is subtracted from Line 6.

- Line 7c: Current quarter's adjustments for tips and group-term life insurance

    The amount in the **Uncollected FICA Social Security** field plus the amount in the **Uncollected FICA Medicare** field. The result is displayed as a negative number in the **Other** section.

- Line 7d: Total Adjustments

    Line 7d sums the amounts in Line 7a and Line 7c.

### Line 8: Total Taxes after adjustments

Line 8 sums the amounts in Line 6 plus Line 7d.

### Line 9: Advanced Earned Income Credit payments made to employees

Line 9 sums the amounts in the **Wages** field for each month of the year in the Employee Pay Code Summary for all employees that have an **Earned Income Credit** pay code.

### Line 10: Total Taxes after adjustment for Advance Earned Income Credit (EIC)

Line 10 sums the amounts in Line 8 and Line 9.

### Line 11

Total Deposits for the quarter

### Line 12

- Line 12a: Total of the posted COBRA subsidy benefits for all employees during the associated quarter

- Line 12b: Number of employees receiving COBRA subsidy benefits during the associated quarter

### Line 13

Line 13 sums lines 11 and 12a.

### Line 14: Balance Due

If the amount of Line 10 is more than Line 13, the difference is written here.

### Line 15: Overpayment

If the amount of Line 13 is greater than the amount of line 10, the difference is written here.

## More information

This article replaces KB 865555.
