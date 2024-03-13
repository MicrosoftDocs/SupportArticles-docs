---
title: How to reprint the reports created in checkbook reconciliation
description: Describes how to generate reports that show the information from a previous checkbook reconciliation process in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/12/2024
---
# How to reprint the reports that are generated during the checkbook reconciliation process in Microsoft Dynamics GP

This article describes how to generate reports after you reconcile a checkbook in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 973083

## Summary

After a checkbook is reconciled, the following reports are printed:

- Bank Reconciliation Posting Journal

  This report displays checkbook and bank statement balance information.

- Bank Adjustments Posting Journal

  This report displays the adjustment transactions that are entered to balance the checkbook.

- Cleared Transactions Journal

  This report displays the transactions that are marked as cleared.

- Outstanding Transactions Report

  This report displays the transactions that have not cleared the bank and that fall between the cutoff dates that are entered in the Reconcile Bank Statements window.

The Outstanding Transactions Report cannot be reprinted in GP 2013 and prior versions. The information from this report is contained in the CM Unreconciled TEMP table before the reconciliation process is complete. When the process is complete, this table is cleared. The only way to reprint this report in GP 2013 and prior is to restore a backup that was created before the reconciliation process was performed, select the checks, and then rerun the reconciliation.

You can reprint this report in GP 2013 R2 and later versions. The reprint report options pull by audit trail code from the CM20502 - CM Unreconciled history table.

## How to determine whether a user has the access to the Bank Reconciliation reports

To do this, use the appropriate steps:

- In Microsoft Dynamics GP, follow these steps:
  1. On the **Tools** menu, point to **Setup**, point to **System**, and then select **Security**.
  2. In the **User ID** list, select the appropriate user ID.
  3. In the **Product** list, select **Microsoft Dynamics GP** or **Microsoft Business Solutions - Great Plains**.
  4. In the **Type** list, select **Reports**.
  5. In the **Series** list, select **Financial**.
  6. In the **Access** list, double-click the appropriate report, and then select **OK**.

## How to reprint the Bank Reconciliation reports

To do this, follow these steps:

1. On the **Reports** menu, point to **Financial**, and then select **Bank Posting Journals**. The following reports can be reprinted:

   - **Reconciliation Journal**: Select this option to reprint the Reconciliation Posting Journal.
   - **Bank Deposit Journal**: Select this option to reprint the Bank Deposit Posting Journal.
   - **Bank Transaction Journal**: Select this option to reprint the Bank Adjustments Posting Journal.
   - **Cleared Transactions Journal**: Select this option to reprint the cleared transactions in the last bank reconciliation.

2. In the **Ranges** list, select **Audit Trail Code**, and then type the appropriate audit trail codes in the **From** field and the **To** field.
3. Select **Destination**.
4. Select the appropriate destination, and then select **OK**.
