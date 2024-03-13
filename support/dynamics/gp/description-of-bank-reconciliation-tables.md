---
title: Description of Bank Reconciliation tables
description: Discusses the tables in Bank Reconciliation. This includes a description of what each table holds and how they work together in Microsoft Dynamics GP.
ms.reviewer: theley
ms.date: 03/13/2024
---
# Description of Bank Reconciliation tables in Microsoft Dynamics GP

This article lists the tables that are located in Bank Reconciliation in Microsoft Dynamics GP. This list includes a description of what each table holds and of how the tables work together in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 872693

The following tables are located in Bank Reconciliation in Microsoft Dynamics GP:

- CM Checkbook Master (CM00100)

  The CM Checkbook Master file holds each checkbook and its corresponding setup information. The information for this file is entered in the Checkbook Maintenance window. The Checkbook Balance is stored in this file. Whenever a deposit or a check is posted, the amount updates the Checkbook Balance.

- CM Deposit Work (CM10100)

  The CM Deposit Work file holds saved, unposted deposits that were entered in the Bank Deposit Entry window. Only one Deposit To Clear Receipts or Deposit with Receipts can be saved per checkbook. You can enter and save an unlimited number of Deposits without Receipts transactions for each checkbook in the Bank Deposit Entry window, even though Bank Reconciliation does not have batches. The saved deposits will be stored in this file until the deposits are posted and moved to the CM Transaction file (CM20200). If all deposits are posted, this file will be empty.

- CM Journal (CM20100)

  The CM Journal file lets users reprint Bank Reconciliation Posting Journals. The audit trail code, Checkbook IDs, and other posting journal information are stored in the file so that you can reprint the reports. The actual transactions are not stored in this file. Two reprint journals are not stored in the CM Journal file, the Reconciliation Journal and the Cleared Transactions Journal. These two reports are stored in the CM Reconcile Header file (CM20500). If the CM Journal file is renamed or deleted, you must perform the Check Links procedure on the CM Transaction logical table. Because the CM Journal is part of the CM Transaction Logical file group, the Check Links procedure will bring the previously posted transactions back. Then, you will be able to reprint posting journals for the transactions that were previously posted. To perform the Check Links procedure, use the appropriate method:

  - In Microsoft Dynamics GP 10.0 and later versions, point to **Maintenance** on the **Microsoft Dynamics GP** menu, and then select **Check Links**. In the **Series** list, select **Financial**.
  - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, point to **Tools** on the **File** menu, and then select **Check Links**. In the **Series** list, select **Financial**.

- CM Transaction (CM20200)

  The CM Transaction file stores all transactions except receipts. Checks, increase/decrease adjustments, deposits, withdrawals, income, and service charges are all saved in the CM Transaction file. Because there are no batches in Bank Reconciliation, the transactions never move from this file to another file. Even after clearing a transaction through the reconcile process, the transaction remains in this file. Unreconciled transactions have an assigned value of 0. Therefore, when transactions are reconciled, they remain in the file but the value changes to 1.

- CM Receipt (CM20300)

  The CM Receipt file stores all receipt type transactions whether they were entered directly in Bank Reconciliation or through Receivables Management. Receipts will never transfer from this file to another file. Unlike transactions in the CM Transaction file, receipts do not clear the bank. Receipts have a value defining whether the receipt has been deposited. When the receipt is deposited, the value assigned to the receipt changes from 0 to 1. The deposit is then saved to the CM Transaction file (CM20200), where the deposit is marked as clearing the bank.

- CM Distribution (CM20400)

  The CM Distribution file stores all the distributions for Bank Reconciliation transactions. The distributions for transactions entered in other modules, such as Payables Management and Receivables Management, are not stored in this file.

- CM Reconcile Header (CM20500)

  The CM Reconcile Header file stores all the summary figures of the information entered during the monthly reconciliation from all checkbooks. The transactions from previously posted reconciliations and current reconciliations are stored in summary in the file. If the file is renamed, it will clear the current reconciliation and will also prevent the user from reprinting the Reconciliation Journal and the Cleared Transactions Journal. If the CM Reconcile Header is renamed, previous reconciliation information can still be obtained in detail from the CM Transaction file (CM20200).

- CM Transfer (CM20600)

  The CM Transfer file holds posted bank transfers that were entered in the Bank Transfer Entry window. The CM Transfer file stores one record for each transfer posted. The transfer amount can be found in the CM Transaction file (CM20200).

- CM Reconcile Adjustments (CM20501)

  The CM Reconcile Adjustments file stores all adjustments entered on current reconciliations. Unlike the CM Reconcile Header file, it does not store adjustments from previous reconciliations. As the adjustments are posted through the reconcile process, the adjustments are saved in the CM Transaction file (CM20200).

- CM Setup (CM40100)

  The CM Setup file stores some setup information entered under the Bank Reconciliation Setup window. The file stores the following setup information: next number, maintain history, user-defined 1, and user-defined 2. The additional fields and the type codes are stored in the CM Transaction Type Setup file.

- CM Transaction Type Setup (CM40101)

  The CM Transaction Type Setup file stores the remaining Bank Reconciliation setup information, such as the transaction and adjustment type codes.
