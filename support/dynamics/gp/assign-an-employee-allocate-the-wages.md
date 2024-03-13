---
title: Assign an employee and allocate the wages
description: Describes how to allocate an employee's salary when an employee works in multiple departments in Microsoft Dynamics GP Payroll.
ms.reviewer: v-kimh
ms.topic: how-to
ms.date: 03/13/2024
---
# How to assign an employee and allocate the wages to different departments in Microsoft Dynamics GP Payroll

This article describes how to allocate an employee's salary when an employee works in multiple departments in Microsoft Dynamics GP Payroll.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 866577

## Introduction

This article describes how to do the following steps in Microsoft Dynamics GP Payroll:

- Assign an employee to multiple departments.
- Allocate employee hours and employee wages to different departments.

## Assign an employee to multiple departments

> [!NOTE]
> The following steps can only be performed if you use the Human Resources module. If you do not use the Human Resources module, move to the "Allocate employee hours and employee wages to different departments" section.

1. On the **Cards** menu, point to **Payroll**, and then select **Employee**.
2. Use the magnifying glass icon to select an employee.
3. Select **Additional Positions**.
4. Select **New**. Assign the employee to departments and to positions that the employee works. Then, select **Save**.

## Allocate employee hours and employee wages to different departments

A transaction must be entered in the **Payroll Transaction Entry** window to reallocate the salary hours to multiple departments. By default, all employee hours and employee dollars are allocated to the department and to the position that the employee is assigned to on the employee card. To reallocate hours to a different department, follow these steps:

1. Open the Payroll Transaction Entry window. To do it, on the **Microsoft Dynamics GP** menu, point to **Transactions**, point to **Payroll**, and then select **Transaction Entry**.
2. Enter a batch ID. A new batch can be entered or an existing batch can be selected.
3. Enter the From dates and To dates for the pay period.
4. Use the magnifying glass icon to select the employee.
5. Use the magnifying glass icon next to **Code** to select the employee's salary pay code.
6. The **Payroll Salary Adjustment** window will open. Select **Reallocate Hours** or **Reallocate Dollars** for the salary change.
7. Enter the hours or dollars to allocate to a new department.
8. Change the **Department** field to the new department.

    > [!NOTE]
    > The system will automatically reduce hours or dollars from the employee's home department and reallocate the hours and dollars to the selected department.
9. Repeat steps 1 through 8 if you want to reallocate the employee to other departments.

When you process the pay run, include the batch. The pre-check report will show a different line for each department that lists the employee.

When you split pay by different departments, the system will also automatically split taxes, deductions, and benefits based on those splits.
