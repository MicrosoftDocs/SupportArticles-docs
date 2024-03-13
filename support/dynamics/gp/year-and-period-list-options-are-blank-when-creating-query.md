---
title: Year and Period list options are blank
description: Describes a problem where the Year list and the Period list are blank when you try to create a Distribution Query or a Multilevel Query in Analytical Accounting in Microsoft Dynamics GP.
ms.reviewer: kriszree, cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# The Year and the Period list options are blank when you try to create a Distribution Query or a Multilevel Query in Analytical Accounting in Microsoft Dynamics GP

This article provides a resolution to solve the issue that the **Year** and the **Period list** options are blank when creating a Distribution or a Multilevel Query in Analytical Accounting in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 968055

## Symptoms

When you try to create a Distribution Query or a Multilevel Query in Analytical Accounting in Microsoft Dynamics GP and Microsoft Business Solutions - Great Plains 8.0, the drop-down lists for the **Year:** and the **Period:** are blank in the Distribution Query Wizard-Finish window or the Multilevel Query Wizard-Finish window.

## Cause

This problem occurs if the reporting periods are not populated in Analytical Accounting. The AAG00500 table stores the calendar information or reporting periods for Analytical Accounting and this table is blank.

## Resolution

To resolve this problem, populate the AAG00500 table. The Analytical Accounting reporting periods are built from the company Fiscal Periods Setup window. A trigger exists in the SY40101 table in the company database that will prompt an insert statement to the AAG00500 table when you calculate the company Fiscal Period Setup window.

To populate the AAG00500 table, follow these steps:

1. Follow the appropriate step:

    - In Microsoft Dynamics GP 10.0, on the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **Company**, and then select **Fiscal Periods**.
    - In Microsoft Dynamics GP 9.0 and Microsoft Business Solutions - Great Plains 8.0, on the **Tools** menu, point to **Setup**, point to **Company**, and then select **Fiscal Periods**.

2. Select **Calculate**, and then select **OK**.
3. A message box will appear that says *All years will be created again. This may take some time*. Select **OK**.

4. Another message box will appear that says *These changes will cause period balances to be incorrect. You will have to reconcile the General Ledger, Payables Management and Receivables Management Modules*. Select **OK**.

5. The reporting periods or AAG00500 table in Analytical Accounting will now be populated and so the **Year** and **Period list** options will now be available in the Multilevel and Distribution queries.
