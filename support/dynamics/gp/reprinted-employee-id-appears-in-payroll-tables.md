---
title: An employee ID of REPRINTED appears in the payroll tables when you void a paycheck during a pay run in Microsoft Dynamics GP
description: Describes a problem that occurs when you void a paycheck during a pay run. Provides a workaround to remove the REPRINTED employee ID.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 12/30/2021
---
# An employee ID of REPRINTED appears in the payroll tables when you void a paycheck during a pay run in Microsoft Dynamics GP

This article provides a workaround to remove the REPRINTED employee ID.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 917063

## Symptoms

When you void a paycheck during a pay run in Microsoft Dynamics GP, sometimes an employee ID of REPRINTED appears in the payroll tables. Additionally, this problem occurs only when Direct Deposit in Microsoft Dynamics GP is active.

## Resolution

To resolve this problem, follow the steps below.
## Workaround

> [!NOTE]
> To perform this workaround, you must be running Microsoft SQL Server.

To work around this problem, follow these steps to remove the REPRINTED employee ID.

1. Use one of the following methods:
   - If you're using Microsoft SQL Server, start SQL Query Analyzer.
   - If you're using MSDE 2000, start Support Administrator Console.
2. Run the following scripts against the company database.

    ```SQL
    delete from UPR00100 where EMPLOYID ='REPRINTED'
    delete from UPR00300 where EMPLOYID ='REPRINTED'
    delete from UPR00400 where EMPLOYID ='REPRINTED'
    delete from UPR00500 where EMPLOYID ='REPRINTED'
    delete from UPR00600 where EMPLOYID ='REPRINTED'
    delete from UPR00700 where EMPLOYID ='REPRINTED'
    delete from UPR00800 where EMPLOYID ='REPRINTED'
    delete from UPR00900 where EMPLOYID ='REPRINTED'
    delete from UPR00901 where EMPLOYID ='REPRINTED'
    delete from UPR30300 where EMPLOYID ='REPRINTED'
    delete from UPR30301 where EMPLOYID ='REPRINTED'
    delete from UPR30401 where EMPLOYID ='REPRINTED'
    ```

3. Verify that the REPRINTED employee doesn't appear in the Employees window. To open the Employees window, follow these steps:
    1. On the **Cards** menu, point to **Payroll**, and then click **Employee**.
    2. In the Employee Maintenance window, click the lookup button next to the **Employee ID** field.

