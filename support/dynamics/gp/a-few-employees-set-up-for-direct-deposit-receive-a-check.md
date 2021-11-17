---
title: A few employees set up for Direct Deposit receive a check
description: A few direct deposit employees still receive a check when they should be receiving a Direct Deposit Earnings Statement. Provides a resolution.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# A few employees set up for Direct Deposit receive a check instead of a Direct Deposit Earnings Statement

This article provides a resolution for the issue that a few employees set up for Direct Deposit receive a check instead of a Direct Deposit Earnings Statement when using Payroll Direct Deposit in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2450856

## Symptoms

A few direct deposit employees receive a check instead of a direct deposit earnings statement. In prior payruns, the employees received a Direct Deposit Earnings Statement, but are getting a check on the current payrun for no reason.

## Cause

In the Direct Deposit Employee Master (DD00100) table, the Employee ID is mis-matched with upper and lower case letters when you compare it to the Payroll Employee Master (UPR00100) table. So, Microsoft Dynamics GP incorrectly reads the direct deposit line for the employee and results in a check generated.

## Resolution

The Employee ID column in the Direct Deposit table needs to be corrected to match the Employee ID column in the Payroll Employee Master table.

Note Before you follow the steps below, make a current backup copy of the company database so you can restore if a problem occurs.

To resolve this problem, follow these steps:

1. Open a SQL query window using the appropriate method below:

    - If you use Microsoft SQL Server 2008, start SQL Server Management Studio. To do this, select **Start**, point to **All Programs**, point to Microsoft SQL Server 2008, and then select **SQL Server Management Studio**.

    - If you use Microsoft SQL Server 2005, start SQL Server Management Studio. To do this, select **Start**, point to **All Programs**, point to Microsoft SQL Server 2005, and then select **SQL Server Management Studio**.

    - If you use Microsoft SQL Server 2000, start SQL Query Analyzer. To do this, select **Start**, point to **All Programs**, point to Microsoft SQL Server, and then select **Query Analyze**.

2. Copy the below script into the query window and execute against the Company database.

    ```sql
    update b set b.EMPLOYID= a.employid from UPR00100 a, DD00100 b where a.EMPLOYID = B.EMPLOYID
    ```
