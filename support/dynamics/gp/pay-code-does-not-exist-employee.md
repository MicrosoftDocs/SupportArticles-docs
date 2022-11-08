---
title: Pay code doesn't exist for Employee
description: Provides a solution to an error that occurs when you run a PA Timesheet integration in Integration Manager in Microsoft Dynamics GP 9.0.
ms.reviewer: kvogel
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# "Error Description = Pay code (PAPayCode) does not exist for Employee (EMPLOYID) in rate table - PA01403" Error message when you run a PA Timesheet integration in Integration Manager in Microsoft Dynamics GP 9.0

This article provides a solution to an error that occurs when you run a PA Timesheet integration in Integration Manager in Microsoft Dynamics GP 9.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 925663

## Symptoms

When you use the Project Accounting Adapter to run a PA Timesheet integration in Integration Manager in Microsoft Dynamics GP 9.0, you receive the following error message:
> Error Description = Pay code (PAPayCode) does not exist for Employee (EMPLOYID) in rate table - PA01403

## Cause

This problem occurs if the rate that is used for an employee on the project timesheet isn't entered in the employee rate table.

## Resolution

To resolve this problem, follow these steps:

1. On the **Cards** menu, point to **Project**, and then select **Employee Rate Table**.
2. Select the employee rate table that is being used.
3. Enter a rate that you want to use for the employee.
