---
title: Differences between Payroll and Project Accounting cost
description: There are differences between the cost posted to the project and the cost in Payroll for salaried employees who worked more than 40 hours in a week. Provides a resolution.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Project Accounting
---
# Differences between Payroll and Project Accounting cost for a salaried employee who worked over 40 hours on a project

This article provides a resolution for the differences between Payroll and Project Accounting cost for a salaried employee who worked over 40 hours on a project in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2266358

## Symptoms

There are differences between the cost posted to the project and the cost in Payroll for salaried employees who worked more than 40 hours in a week.

## Cause

Project Accounting will always calculate an hourly rate for all employees even if they're salaried. This hourly amount is determined by their annual salary amount divided by the value in the Work Hours per Year field in the Employee Additional Information Maintenance window. This is typically set to 2080 (which is the number of working hours in a year). Project Accounting will calculate the cost for this employee based on this hourly amount. If salaried employees are paid a different hourly rate for overtime hours or if they aren't paid for any hours over 40 hours in a week, this will cause discrepancies between the Payroll and Project Accounting costs. For example, the calculated hourly rate for a salaried employee is $72.11. If the employee works 41 hours in a week, the total cost to the project in Project Accounting would be 41 x 72.11 versus the 2882.40 (40 x 72.11) that would be in Payroll if they aren't paid overtime.

## Workaround

Here are some steps for working around this issue:

1. Enter the first 40 hours on the project using their normal salary pay code.

2. Enter any additional time on the project using a different pay code that has the overtime rate associated with it or a $0 rate if the employee isn't paid for overtime. You could choose to track this under a different cost category as well.

3. When you post the timesheet, it will update a batch in Payroll. If the employee isn't paid for overtime, we suggest creating a dummy batch in Payroll for these extra hours only, which can be deleted in Payroll so the employee isn't overpaid.

> [!NOTE]
> The users would have to know to use the different pay code (and possibly cost category) when they go over 40 hours.
