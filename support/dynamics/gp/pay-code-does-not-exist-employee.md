---
title: Pay code doesn't exist for Employee
description: Provides a solution to an error that occurs when you run a PA Timesheet integration in Integration Manager in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 02/18/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# "Error Description = Pay code (PAPayCode) does not exist for Employee (EMPLOYID) in rate table - PA01403" when you run a PA Timesheet integration in Integration Manager in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you run a PA Timesheet integration in Integration Manager in Microsoft Dynamics GP

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 925663

## Symptoms

When you use the Project Accounting Adapter to run a PA Timesheet integration in Integration Manager in Microsoft Dynamics GP, you receive the following error message:

> Error Description = Pay code (PAPayCode) does not exist for Employee (EMPLOYID) in rate table - PA01403

## Cause

This problem occurs if the rate that is used for an employee on the project timesheet isn't entered in the employee rate table.

## Resolution

To resolve this problem, follow these steps:

1. On the **Cards** menu, point to **Project**, and then select **Employee Rate Table**.
2. Select the employee rate table that is being used.
3. Enter a rate that you want to use for the employee.
