---
title: Reports to view HR Attendance balances for Employees
description: Introduces the reports that you can use to view HR Attendance balances for Employees in Microsoft Dynamics GP.
ms.reviewer: Cwaswick
ms.date: 03/13/2024
---
# Reports that can be used to view HR Attendance balances for Employees

This article introduces the reports that you can use to view HR Attendance balances for Employees in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4057513

## Summary

The reports used to view Attendance balances in Human Recourses are:

1. EMPLOYEE ATTENDANCE SUMMARY - This report shows the current '**Hours Available'** balance for each Time Code as displayed in theEmployee Attendance Maintenance window. Run this report under **Reports** > **Human Resources** > **Attendance** and select the Employee Attendance Summary Report. Set restrictions by Department, Division, Time Code, Employee ID, First Name, Last Name and/or Social Security Number, (This report pulls the HOURSAVAILABLE_I field in the 'TA MSTR TYPES' [TATM1030] table.)

2. EMPLOYEE ATTENDANCE DETAIL - This report lists the transactions that have been keyed in HR for the Employee. Run this report under **Reports** > **Human Resources** > **Attendance** and select the Employee Attendance Detail Report. Set restrictions by Department, Division, Time Code, Employee ID, First Name, Last Name, Social Security Number and/or Date, (This report pulls detailed transactions from the 'TA TRX Detail' [TATX1030] table.)

## More information

Q1: What are some reasons the Employee Attendance Detail report may not match the Employee Attendance Summary report? Shouldn't the sum of the detail match the total?

A1: These two reports may become mismatched for the following reasons:

- You added/deleted/edited transactions directly in the TATX1030 table. If you remove a transaction in this SQL table, it does not automatically update the balance. (And there is no reconcile process to run to get them in balance.)
- You edited the Attendance balance directly in the TATM1030 table. If you edit a balance directly in this SQL table, then there is no detailed transaction or audit trail to support the change.
- Users are allowed to directly edit the **Hours Available** balance field in the Employee Attendance Maintenance window. If this field is editable, the user can simply change the balance, and there is not detailed transaction to support it.
  - For this reason, we recommend going **Microsoft Dynamics GP** > **Tools** > **Setup** > **System** >**Human Resources Preferences**, and unmark the option for **Edit Attendance Maintenance and Earnings History**. With this option unmarked, the Hours Available balance field will not longer be an editable field. To make adjustments to the employee's balance, the user should go to **Transactions** > **Human Resources** > **Transaction Entry** and mark **Hours Available Adjustment** and key a positive/negative amount as needed to adjust the balance as needed. (Note that Start Date used will also record the adjustment against the maximum tracked for the corresponding year.) This adjustment entry records a detailed transaction in the TATX1030 table to support the change, and affects both tables so the two reports stay in sync. Without a detailed transaction to support the change, the two reports will not match. The change must be made in BOTH tables by keying an HR Transaction Adjustment in order for the reports to stay in sync.
