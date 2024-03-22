---
title: Check Stub displays Attendance balances
description: Provides a solution to an issue where Check Stub or Earnings Statement displays Attendance balances from Payroll instead of Human Resources
ms.reviewer: theley, cwaswick, v-Kimh
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Human Resources
---
# Check Stub or Earnings Statement displays Attendance balances from Payroll instead of Human Resources in Microsoft Dynamics GP

This article provides a solution to an issue where Check Stub or Earnings Statement displays Attendance balances from Payroll instead of Human Resources in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2023150

## Symptoms

The Payroll Check Stub or Earnings Statement is designed to pull attendance balances from the Payroll tables. However, if you're accruing vacation and sick time in Human Resources, the check stub or earnings statement will have to be changed in Report Writer to pull the attendance balances from the HR tables.

## Cause

The check stub or Earning Statement pulls attendance balances from the Payroll tables by design. In Microsoft Dynamics GP, if you're accruing in HR, the Payroll tables are no longer updated. However, the check still pulls from the payroll side. So it must be changed to pull the Time Available from the Human Resources tables.

## Resolution

Change the check stub in Report Writer to pull in the **Time Available** arrays from the HR side on to the check stub. The **Time Available Array** field should represent the **Hours Available** value from the Employee Attendance Maintenance window, but the **Time Code Array** field should pull the description of the time code that is represented.

> [!NOTE]
> The balances and codes will print in alphanumeric order. So if different codes are marked to print for each employee, the balances will print in different array fields for each employee. For example, if Employee A has HOL and VAC codes only, HOL will print in Array 1, and VAC will print in Array 2 or alphanumeric order. If Employee B has HOL, VAC and SICK codes, then HOL will print in Array 1, SICK in Array 2, and VAC in Array 3. Therefore, at least three arrays must be dragged out on to the check format or earnings statement for this scenario. You should drag out as many arrays for the maximum number of codes that require to print for any employee.

Choose which time codes you want to print for each employee as follows:

1. Select **Cards**, point to **Human Resources**, point to **Employee-Attendance**, and then select **Maintenance**.
2. Select the **Print Available Time on Payroll Checks only** check box for the Employee/Time Code combinations that you want to print.

## More information

**Frequently Asked Questions**  
**Q1: I've modified my check stub to pull the Time Available Arrays. Why are they still not printing out on the check stub?**  

A1: In order for the time code to print, the following criteria must be true:

- The time code must be of the "benefit" type. 
- The time code must be linked to a pay code. 
- The "Print Available Time on Payroll Checks" option must be marked in the Employee Attendance Maintenance window. 

**Q2:  How do I get zeros not to print in the extra arrays for an employee?**  

A2: In Report Writer, double-click the array. Instead of selecting **Visible**, select **Hide When Empty**.

**Q3: Can I hard-code a Time Code description such as VAC on the check stub or earnings statement?**  

A3: We recommend that dray out the Time Code Array instead of hard-coding the Time Code descriptions. The codes are designed to print in alpha-numeric order within the arrays. As long as you drag out the Time Code array 1 next to the Time Available Array 1, and Time Code Array 2 next to Time Available Array 2, and so on, the correct code will print next to the corresponding balance.  

**Q4: How do I get the same codes to appear in the same array for every employee? For example, I want Array 3 to be VAC for all employees.**  

A4: It isn't necessary for the Time Codes to print in the same numbered array for each employee. As long as the correct Time Code Description prints next to each balance, it should be the main concern. One way to print the same code in the same array field for each employee is to assign all codes to all employees, or to create a dummy code to fill in for that spot for those employees who don't need a certain code. However, it shouldn't matter what array they print in for each employee because they don't see each other's check stubs. Just make sure that they're labeled correctly.

**Q5: I changed the check stub. Why the user is still seeing the old balances from Payroll?**  

A5: Make sure that you enable access in Microsoft Dynamics GP to the changed version of the check stub or earnings statement.
