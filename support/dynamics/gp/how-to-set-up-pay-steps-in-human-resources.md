---
title: How to set up Pay Steps in Human Resources
description: This article explains the process of creating a pay step table, assigning employees, and processing the pay rates.
ms.reviewer: theley, Kimberly Haisley
ms.topic: how-to
ms.date: 03/13/2024
---
# How to set up Pay Steps in Human Resources for Microsoft Dynamics GP

Pay Steps are used to associate an employee's amount of time in a position with a rate of pay. This article explains the process of creating a pay step table, assigning employees, and processing the pay rates.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2001014

## Activating Pay Steps

1. Point to the Microsoft Dynamics GP menu, point to **Tools** > **Setup** > **System** > **Human Resources Preferences**.
2. Mark the **Use Pay Steps/Grades** checkbox.
3. Select the type of date for the basis of the pay step increase. These choices are Hire Date, Adjusted Hire Date, Seniority Date, or Manual.

## Creating Pay Step Tables

1. Point to the Microsoft Dynamics GP menu, point to **Tools** > **Setup** > **Human Resources**, and then select Pay Step Table.
2. Enter a Pay Step Table ID for this table and description that explains it.
3. Select the **Unit of Pay**; you will need to create separate tables for hourly and salary employees.
4. Enter an Effective Date when the new period begins for the new pay rates. Add Column.
5. The Step/Grade should be entered in a sequential number sequence.
6. For the Months in Step, specify the range of steps for this new pay rate.
7. Enter an amount for the specified effective date.
8. Continue Steps 5 through 8 until you have entered all desired pay rates.
9. You can continue to enter effective dates for each new period rate.

## Assign a Pay Step Table to Employees through the Employee/Pay Step Table Assignment window*

1. Point to the Microsoft Dynamics GP menu, point to **Tools** > **Setup** > **Human Resources** > **Pay Step Table**, and then select the **Assign Employees** button.
2. Enter or select a Pay Code.
3. Under Base Step Increases on, select a type of date to base step increases on. These choices are Hire Date, Adjusted Hire Date, Seniority Date, or Manual.
4. Select the ranges of Employees. You can base these choices on Employee ID, Location, Department, Position, Union, or Class ID.
5. You can mark the check boxes to exclude employees already assigned to a pay step table or employees that have a pay increase on hold.
6. Select **Redisplay** for the employee information you have selected to be populated.
7. Select the employees to be assigned to this pay step table, or select **Mark All** to select them all, and press the **assign** button.
8. Select **Process** to process the changes.

## Assign a Pay Step Table to an employee on the Employee Pay Code Maintenance window

1. Point to Cards, point to **Payroll** > **Pay Code**.
2. Select the employee and the Hourly or Salary pay code.
3. Use the drop-down to select when the Base Step increases. The options include Hire Date, Adjusted Hire Date, Seniority Date, or Manual.
4. Use the Look Up to select the Pay Step table to be assigned to this employee.
5. You must have an amount greater than zero on the FTE field. This is used as a multiplier for the rates. The default value for this field is 1.0. Use the **FTE** value to change individual employees' **pay** rates without changing the **pay** step table amounts. For example, enter an **FTE** less than 1.0 to decrease a full-time position salary for a part-time employee, or enter an **FTE** greater than 1.0 to increase the **pay** rate for an employee providing greater qualifications and productivity. This value must be a positive number.

6. Select **Save**.

## Activating Post-Dated Pay Rates

1. To open the Activate Employee Post-Date Pay Rates window, point to **Transactions** > **Payroll** > **Activate Post Dated**.
2. Select the Range to search on; you can select ranges from the following: Effective Date, Employee ID, Pay Code, and Reason for Change.
3. In the **Sort By** field, select how you would like the results to be sorted. Select **Redisplay** for these results to be sorted.
4. Next to each post-dated pay rate, select Activate for this rate to become active.
5. Select **Process** for the post-dated pay rates to become active.
6. Verify on the Employee Pay Code the new rate appears. Point to **Cards**, point to **Payroll**, and select **Pay Code**.

After you have verified the new rate, you can process payroll as normal and the new rate will maintain.

If you need to in the future inactivate or turn off pay steps, see [Error message when you assign a pay code to an employee in Microsoft Dynamics GP: "You must enter a step/grade value before this record can be saved"](https://support.microsoft.com/topic/error-message-when-you-assign-a-pay-code-to-an-employee-in-microsoft-dynamics-gp-you-must-enter-a-step-grade-value-before-this-record-can-be-saved-d1a581cb-6465-451a-8176-cdb953752459).
