---
title: Computer Check batch doesn't have correct posting status
description: The Computer Check batch in the Payables Batch IDs window does not have the correct posting status in Microsoft Dynamics GP. This article provides a solution to this issue.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Financial - Payables Management
---
# The Computer Check batch in the Payables Batch IDs window does not have the correct posting status in Microsoft Dynamics GP

This article provides a solution to an issue where the Computer Check batch in the Payables Batch IDs window does not have the correct posting status.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 856043

## Symptoms

When you view the Computer Checks batch ID in the Payables Batch IDs window, the **Available** posting status is not in the **Status** column. This problem occurs in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

## Resolution

If a backup is unavailable to restore the Payables Computer Check batch, follow these steps:

1. If you cannot change the status of the Payables Computer Check batch to the **Available** status, complete the procedure in Microsoft Knowledge Base article 850289.

    [850289](https://support.microsoft.com/help/850289) A batch is held in the Posting, Receiving, Busy, Marked, Locked, or Edited status in Microsoft Dynamics GP

2. Click **Computer Checks**, click **Select**, and then click **Delete**.

3. Determine whether the invoices and the checks are updated in Payables in Microsoft Dynamics GP. Also, determine whether there is any amount remaining on open invoices that were paid by the check batch. To do this, use one of the following methods:

    - Use the Payables Transaction inquiry. To do this, point to **Purchasing** on the **Inquiry** menu, and then click **Transaction by Document**.
    - Use the Payables Aged Trial Balance report. To do this, point to **Purchasing** on the **Reports** menu, and then click **Trial Balance**.
    - Use the Transaction History report. To do this, point to **Purchasing** on the **Reports** menu, and then click **History**.

4. If the invoices and the checks are still in the open file, and the amount that is remaining equals the original amount, reselect the vouchers for payment. To do this, use Select Checks. Before you post to General Ledger in Microsoft Dynamics GP, confirm that the original batch did not update General Ledger. If General Ledger was updated, post the reselected checks to Payables and not to General Ledger.

5. If there are invoices and checks in the open file, and the amount remaining is zero, verify that the links to the "PM Transaction Logical" file exist.

    To do this, use the appropriate step:

    - In Microsoft Dynamics GP 10.0, click **Maintenance** on the **Microsoft Dynamics GP** menu, and then click **Check Links**.
    - In Microsoft Dynamics GP 9.0, click **Maintenance** on the **File** menu, and then click **Check Links**.

    If Microsoft Dynamics GP can find the appropriate information to apply to the voucher, the file maintenance will move the voucher to history. If Microsoft Dynamics GP cannot find the information, Microsoft Dynamics GP will change the amount remaining to the original amount of the document. Use Select Checks to reselect the vouchers for payment. Print a Detail Trial Balance report to verify that General Ledger is correct. To do this, click **Financial** on the **Reports** menu, and then click **Trial Balance**. Also, verify that the figures in the Vendor Credit Summary window are correct. To do this, click **Purchasing** on the **Cards** menu, and then click **Summary**.

6. If both the voucher and the payment are in history, Payables Management will be correct after the check batch is deleted in step 2. Check General Ledger to make sure that everything is posted correctly.
