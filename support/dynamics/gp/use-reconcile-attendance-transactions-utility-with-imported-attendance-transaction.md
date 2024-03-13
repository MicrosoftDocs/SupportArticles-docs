---
title: Use Reconcile Attendance Transactions utility with imported attendance transaction info
description: Describes when to use the Reconcile Attendance Transactions option in the Reconcile Human Resources window when attendance transaction information is imported directly into the Payroll Transaction Entry window in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle, cwaswick
ms.date: 03/13/2024
---
# When to use Reconcile Attendance Transactions utility when attendance transaction information is imported directly into Payroll

When you import Human Resources attendance transactions directly into the Payroll Transaction Entry window, only the Payroll tables are updated. You must run the **Reconcile Attendance Transactions** utility in the Reconcile Human Resources window before you process the pay run to update the Human Resources module with the information from the Payroll batch. This reconcile process must be done before the Payroll batch is posted.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 967085

To reconcile attendance transactions, follow these steps:

1. Follow the appropriate step:

    - In Microsoft Dynamics GP 10.0 and later versions, on the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Utilities**, point to **Human Resources**, and then select **Reconcile**.
    - In Microsoft Dynamics GP 9.0, on the **Tools** menu, point to **Utilities**, point to **Human Resources**, and then select **Reconcile**.

2. In the Reconcile Human Resources window, select the **Reconcile Attendance Transactions** check box.
3. Select **Process**. When you are prompted to print the reconcile report, select the appropriate destination.

## Frequently Asked Questions

- Q1: What does the reconcile utility for *Reconcile Attendance Transactions* do?

  A1: This will reconcile attendance transactions between unposted Payroll batches and Human Resources tables and updates the missing information. If attendance records have been imported directly to a US Payroll batch, then only the Payroll work tables have been updated with the transaction information. The reconcile option must be performed to update the Human Resources tables with the transaction information from the payroll batch.
  
  > [!NOTE]
  > Attendance transactions can be imported directly to a payroll batch from Business Portal, Project Accounting or any other third party attendance application. However, not all third party products require that you reconcile and may update HR tables automatically, so be sure to check with your ISV.

- Q2: When should Reconcile Attendance Transactions be performed?

  A2: We recommend reconciling the attendance transactions before the Accrual process is run in case any of the accruals need to calculate on the transactions. The reconcile can be done before or after you Build Checks, as long as it is done before you Calculate checks, so the most up-to-date balance of the attendance code is printed on the check stub.

- Q3: What do I do if I forgot to process the Reconcile Attendance Transactions reconcile utility and have already posted the check batch?

  A3: Unfortunately there is no automated process to update the Human Resources tables once the payrun has been posted. You will need to key manual HR adjustment transactions to update the Human Resources tables. To do this, select **Transactions** in the menu, point to **Human Resources**, select **Transaction Entry** and select the **Transaction Type of Hours Available Adjustment**. Key a positive or negative adjustment amount as needed.

- Q4: If attendance transactions are manually entered into Microsoft Dynamics GP, do you still need to process the reconcile utility for Reconcile Attendance Transactions?

  A4: No. The Human Resources tables will be automatically updated when you key in an attendance transaction if the time code in Human Resources is properly linked to the pay code in Payroll.

- Q5: Do all users need to be out of the system when running Reconcile Attendance Transactions?

  A5: Users should not be processing payroll or importing transactions during the reconcile process. Typically, you do not want to be inserting new transaction data into the tables at the same time the reconcile is being done.
