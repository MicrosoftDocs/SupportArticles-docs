---
title: Move reconciled transactions to history for performance issues
description: Performance issues when voiding a bank deposit in Microsoft Dynamics GP. Provides a resolution.
ms.reviewer: cwaswick
ms.topic: troubleshooting
ms.date: 03/31/2021
---
# Move reconciled transactions to history to help performance issues in Bank Reconciliation using Microsoft Dynamics GP

This article provides a resolution to move all reconciled transactions to the new historical tables to help performance issues in Bank Reconciliation in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4161364

## Symptoms

- When post or void a bank deposit, it takes forever and the system just hangs. How to make it go faster and get past this performance issue?
- When you open the checkbook register inquiry window, Microsoft Dynamics hangs or slow checkbook register inquiry window.
- In the checkbook register inquiry window, when you select the lookup button to select a document number, you are unable to select a document.
- Printing the checkbook register is now slow in Microsoft Dynamics GP 2018 after an upgrade.

## Cause

If your Bank Reconciliation tables (CM20200 and CM20300) get very large, it may slow down the posting or voiding processes for bank deposits.  Reducing the size of these tables may help these processes go faster.

Changes were made to the checkbook register window in Microsoft Dynamics GP 2016 R2 to accommodate the new historical tables. So if you have never used this feature to move documents to history in Bank Rec, you may want to move some documents to history and then performance should improve.

## Resolution

If you are on Microsoft Dynamics GP 2016 R2 (16.00.0541) or higher versions, there are new historical tables for Bank Rec. So you can run a process to move all reconciled transactions to the new historical tables. So having your open tables smaller, should help with performance overall in Bank Rec.

To do this:

1. Make a current backup of the company database.

2. Go to **Microsoft Dynamics GP** > **Tools** > **Setup** > **Financial** > **Bank Reconciliation**, and verify that the option for **MAINTAIN HISTORY** for **Transaction/reconciliation** is marked. (If this is not marked, the transactions will be removed completely when you reconcile or void, so make sure it is marked to keep history.)

3. Go to **Microsoft Dynamics GP** > **Tools** > **Routines** > **Financial** > **Reconciled Transaction Maintenance**,

    1. Select the checkbook ID.
    2. Mark the checkbox for what transactions you want to remove (that is, Deposits, Bank transactions, Transfers, or voiced transactions).
    3. Enter a cutoff date. (reconciled documents after this date will not be moved to history.)
    4. Mark the option to **print register** for your records.
    5. Select **Process**.
    6. Verify the transactions were moved.

## More information

Transactions you selected will move to historical tables as follows:

- Reconciled transactions will be moved from the CM20200 table to the CM30200 historical table.
- Reconciled/deposited receipts will be moved from the CM20300 table to the CM30300 historical table.

## References

For more information, see [Microsoft Dynamics GP 2016 R2 - Bank Reconciliation - Reconciled Transaction Maintenance](https://community.dynamics.com/blogs/post/?postid=6692ee70-d3b4-4267-86d8-575e021cb4ae).
