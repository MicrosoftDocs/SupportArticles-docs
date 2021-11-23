---
title: An employee ID of REPRINTED appears in the payroll tables when you void a paycheck during a pay run in Microsoft Dynamics GP 9.0
description: Describes a problem that occurs when you void a paycheck during a pay run. Provides a workaround to remove the REPRINTED employee ID.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# An employee ID of REPRINTED appears in the payroll tables when you void a paycheck during a pay run in Microsoft Dynamics GP 9.0

This article provides a workaround to remove the REPRINTED employee ID.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 917063

## Symptoms

When you void a paycheck during a pay run in Microsoft Dynamics GP 9.0, an employee ID of REPRINTED appears in the payroll tables. Additionally, this problem occurs only when Direct Deposit in Microsoft Dynamics GP is active.

## Resolution

To resolve this problem, obtain the latest service pack for Microsoft Dynamics GP 9.0

## Workaround

> [!NOTE]
> To perform this workaround, you must be running Microsoft SQL Server or SQL Server Desktop Engine (also known as MSDE 2000).

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

## Status

Microsoft has confirmed that this is a problem in the Microsoft products that are listed in the "Applies to" section. This problem was first corrected in Microsoft Dynamics GP 9.0 Service Pack 1.

## Steps to reproduce the problem

> [!NOTE]
> The following steps are used for Fabrikam Inc. Fabrikam Inc. is a fictitious company that is used for demonstration in Microsoft Dynamics GP.

1. On the **Transactions** menu, point to **Payroll**, and then click **Build Check**.
2. In the Build Payroll Checks window, type the information in the required fields, click to select the **Salary** check box, and then click **Build**.
3. In the Report Destination window, click to select the **Screen** check box, and then click **OK**.
4. On the **Transactions** menu, point to **Payroll**, and then click **Calculate Checks**.
5. In the Report Destination window, click to select the **Screen** check box, and then click **OK**.
6. On the **Transactions** menu, point to **Payroll**, and then click **Print Checks**.
7. In the Print Payroll Checks window, select **Calculate Employee Deposits** in the **Process:** list, and then click **Process**.
8. After the deposits have been calculated, click **OK**.
9. Select **Checks** in the **Print:** list, and then click **Print**.
10. In the Post Payroll Checks window, select **Reprint Checks** in the **Process:** list, and then click **Process**.
11. In the Post Payroll Checks window, select **Print Earnings Statements** in the **Process:** list, and then click **Process**.
12. In the Post Payroll Checks window, select **Post Checks** in the **Process:** list, and then click **Process**.
