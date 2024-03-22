---
title: Process and track an advance pay run
description: Explains how to process and track an advance pay run in Payroll.
ms.reviewer: theley, lmuelle
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Payroll
---
# How to process and track an advance pay run in Payroll in Microsoft Dynamics GP

This article describes how to process an advance pay run, how to obtain the advance payback from the employee for the advance amount, and how to track the advance amount that remains for an employee in Payroll in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 849473

## Introduction

When you process an advance pay run in Payroll, only two pay codes exist that you can use when you process an advance pay run:

- Salary
- Commission

## How to process an advance pay run for an employee

1. On the **Cards** menu, point to **Payroll**, and then select **Pay Code**.
2. In the Employee Pay Code Maintenance window, select the employee who you want to pay in the **Employee ID** field.
3. In the **Pay Code** field, select the **Salary** pay code or the **Commission** pay code.
4. In the **Advance Amount** field, enter the advance amount, and then select **Save**.
5. On the **Transactions** menu, point to **Payroll**, and then select **Build Checks**.
6. In the Build Payroll Checks window, select **Advance Pay** under **Type of Pay Run**.
7. Select **Include Pay Codes**, insert the pay codes that you want to include in this advance pay run, and then select **OK**.
8. Select **Build**.
9. On the **Transactions** menu, point to **Payroll**, and then select **Calculate Checks**.
10. In the Calculate Payroll Checks window, select **OK**, and then print the Precheck Report.

    No benefits, deductions, or taxes are included in the pay run.
11. On the **Transactions** menu, point to **Payroll**, select **Print Checks**, and then print the employee checks.
12. Calculate the checks.
13. On the **Transactions** menu, point to **Payroll**, and then select **Print Checks**.
14. Select **Process**.

## How to obtain the advance payback from an employee

To obtain the advance payback from the employee, you must set up the payback. The next time that a regular check run that includes a salary pay type or a commission pay type is processed for this employee, Microsoft Dynamics GP will automatically take as much of the advance amount as possible. (It excludes the deductions and the taxes.) To set up the advance payback, follow these steps:

1. On the **Transactions** menu, point to **Payroll**, and then select **Build Checks**.
2. In the Build Payroll Checks window, select **Regular Pay** under **Type of Pay Run**.
3. Under **Include Pay Periods**, select the appropriate pay frequency pay periods.
4. Under **Include Automatic Pay Types**, select the **Salary** check box.
5. If it's needed, select one or more of the following options to add deductions, benefits, or batches to the existing payroll build:

    - **Include Deductions**  
    - **Include Benefits**  
    - **Select Batches**
6. Select **Build**.
7. On the **Transactions** menu, point to **Payroll**, and then select **Calculate Checks**.
8. Select **OK**, and then print the Precheck Report. You can see the payback amount that will be taken from the employee's check on this report.
9. On the **Transactions** menu, point to **Payroll**, select **Print Checks**, and then print the employee checks.
10. Calculate the checks.
11. On the **Transactions** menu, point to **Payroll**, and then select **Print Checks**.

    You see the typical salary amount on the pay stub. You also see that a negative amount for the salary pay code is deducted for the amount of the advanced pay run.
12. Select **Process**.

## How to track the advance amount that remains for an employee

The advance amount that remains will be tracked in the Employee Pay Code Summary window. The amount in this window will decrease until the whole advance amount has been paid back. To view the remaining advance amounts, follow these steps:

1. On the **Cards** menu, point to **Payroll**, and then select **Pay Code**.
2. In the Employee Pay Code Maintenance window, select the employee who received the advance in the **Employee ID** field.
3. In the **Pay Code** field, select the **Salary** pay code or the **Commission** pay code, and then select **Summary**.

    The advance amount that remains for the employee will appear in the **Advance Taken** field. This amount will decrease when the next pay run is completed for the employee who has this pay code.

## More information

Microsoft Dynamics GP will try to take the full advance amount that remains after taxes and deductions to pay off the advance amount. It may result in a zero dollar check for the employee. If you don't want Microsoft Dynamics GP to do it, you can set up a minimum net pay amount that you want the employee to receive until the advance is paid off. To do it, follow these steps:

1. On the **Cards** menu, point to **Payroll**, and then select **Employee**.
2. In the Employee Pay Code Maintenance window, select the employee who received the advance in the **Employee ID** field, and then select **Additional Information**.
3. In the **Minimum Net Pay** field, enter the minimum amount of pay that you want the employee to receive until the advance is paid off.
4. Select **OK**, and then select **Save**.
5. Process a regular pay run. To do it, follow the steps in the [How to obtain the advance payback from an employee](#how-to-obtain-the-advance-payback-from-an-employee) section.

    When the advance is paid off, you can clear the amount in the **Minimum Net Pay** field in the Employee Additional Information window.
