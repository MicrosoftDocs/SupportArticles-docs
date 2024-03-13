---
title: How to start using existing checkbook to reconcile
description: This article describes how to start using Bank Reconciliation with an existing checkbook in Microsoft Dynamics GP.
ms.reviewer: cwaswick
ms.topic: how-to
ms.date: 03/13/2024
---
# How to start using an existing checkbook to reconcile in Bank Reconciliation for Microsoft Dynamics GP

This article describes how to start using Bank Reconciliation with an existing checkbook in Microsoft Dynamics GP, so you can do the reconciliation between the Ending Balance on the Bank Statement and the Current Checkbook balance within Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 857211

> [!NOTE]
> In addition, you should also reconcile the GL Cash Account balance to the reconciled balance above as a separate reconciliation. To learn more about this reconciliation, see [The checkbook balance and the general ledger cash account do not balance in Microsoft Dynamics GP](https://support.microsoft.com/topic/kb-864652-the-checkbook-balance-and-the-general-ledger-cash-account-do-not-balance-in-microsoft-dynamics-gp-a9774c8e-5221-b432-bec2-5e08c7a0b446).

## Summary

Follow these steps to clear out the old data in an existing checkbook, so you are able to reconcile the Current Checkbook balance in Bank Reconciliation to the Ending Balance on the Bank Statement:

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a current backup copy of the company database that you can restore if a problem occurs, or do this in a test company first.

1. Select a starting point in time: Select a start date or point in time to begin reconciling the existing checkbook. Typically, this is the ending date of the last Bank Statement balance that you reconciled to the GL cash account used with this checkbook (which you should have been doing outside of Microsoft Dynamics GP). You will also want to perform the steps in this article as close afterwards to that date as possible, to minimize the number of outstanding items since that date. The goal will be to get the checkbook balance in Bank Reconciliation to match this balance that was last reconciled between the Bank Statement and General Ledger. To begin, you will need to determine:

   - The last Bank Statement ending date of the last reconciliation you completed between the Bank Statement and the GL cash account that is used with this checkbook. (Note: The GL cash account should only be linked to *one* checkbook ID.)
   - The Bank Statement Ending balance at this same point in time.
   - The outstanding items for the above reconciliation at this same point in time.

2. Post all batches: Post all the batches from other modules (GL, Payables, Receivables, SOP, POP, and so on) that would affect the checkbook balance. You do not want any other items affecting the checkbook balance or the GL Cash account balance at the same time you are doing maintenance to the checkbook, so it is recommended to have all batches posted in all modules, and ask all users not to key/post any transactions to this checkbook ID or GL cash account during this time.

3. Identify outstanding receipts: Print a list of cash receipts not yet deposited in Microsoft Dynamics GP to compare to the list of outstanding items from step 1, to identify the outstanding cash receipts. To do this, follow these steps:

    1. Select **Reports**, point to **Financial** and select **Checkbook**.
    2. Select the report for Undeposited Receipts, and select **New**.
    3. Type in a name for the Option.
    4. Enter the Checkbook ID for the range and select Insert to add this restriction.
    5. Select **Destination** and choose to print the report to the screen, printer, and/or file, and then select **OK**.
    6. Select **Print** to print the *Undeposited Receipts Report*.
    7. Review the *Undeposited Receipts Report* to identify which receipts have already been deposited to the bank and reconciled, and which receipts are still outstanding, or part of an outstanding deposit as of the point in time chosen in step 1.

4. Mark off deposited/reconciled receipts: Mark off the cash receipts in Microsoft Dynamics GP that have already been deposited and reconciled to the Bank Statement as of the point in time in step 1. To do this, follow these steps:

    1. Select **Transactions**, point to **Financial** and select **Bank Deposits**.
    2. For the **Option** field, select Enter/Edit.
    3. Select the appropriate Deposit Date and Checkbook ID.
    4. Select the appropriate Type and enter as many Deposits as needed:

        > [!NOTE]
        > Leave any current cash receipts unmarked that have not yet been deposited to the bank.

          - Deposit With Receipts - Enter a deposit(s) and mark any receipts that are part of an 'outstanding' deposit as of the date chosen in step 1 or after. Enter as many deposits as needed and the Deposit Total for each should match the actual outstanding deposit amount(s) for ease in matching to the bank statement by amount. This deposit option only updates the checkbook balance and does not affect GL. (Note: GL was already updated when the cash receipt was posted.)
          - Clear Unused Receipts - Enter one large deposit for any receipts that are older than the date chosen in step 1 and not part of an outstanding deposit as of this date. This option simply drops the receipt from the Deposit Entry window and does not affect GL. Use this option to clear all old unused data, as you will want to clear all receipts from this window that will not be needed going forward.
          - Deposit Without Receipts - If needed, use this option to enter any 'outstanding' deposits as of the date chosen in step 1, where you could not find the receipts listed that make up this outstanding deposit. This option will affect GL and increase the cash account balance, so you must be absolutely sure that the cash receipts that make up this deposit were not listed in the window (so that GL is not updated twice for the same cash receipt amount).
          - Deposit EFT - Enter a deposit(s) and mark any receipts that are part of any 'outstanding EFT deposit' for cash receipts as of the date chosen in step 1. This option does not affect GL. Note: If you are not registered for EFT for Receivables Management, you may not have this option listed.

    5. Select Post for each deposit keyed. Enter as many deposits as needed, and ensure all receipts for old data or receipts included in an outstanding deposit have been marked off.

5. Create reconcile header:

   To do this, follow these steps:

   1. Select **Transactions**, point to **Financial**, and then select **Reconcile Bank Statement**.
   2. Select the appropriate Checkbook ID.
   3. Enter the Bank Statement ending balance, and the Bank Statement ending date from the statement that was used in step 1.
   4. Specify a Cutoff Date that is the last day of the month that is being reconciled (which is typically the same date as the Bank Statement Ending Date). This step will only list transactions in Bank Rec through this date and prevent the unintentional clearing of transactions from the following months.

6. Reconcile transactions: In the above **Reconcile Bank Statements** window, select **Transactions**, to open the **Select Bank Transactions** window (also known as. 'Reconcile' window). Then mark the C' checkbox to clear all the transactions *except* the following transactions:

   - Outstanding transactions in step 1 should not be marked.
   - Any transactions that were entered after the reconciliation date in step 1 should not be marked.

    > [!TIP]
    > It may be easier to mark a large range as cleared, and then just go back and individually unmark the items that are outstanding. You can mark or unmark a range to be cleared: Simply mark the first checkbox for the beginning of the range and select CONTROL - B to begin the range. Then mark the last checkbox in the range you choose and select CONTROL - E to end the range. Then select CONTROL - K to have the range marked, or press CONTROL - N to unmark this range. (Refer to the drop-down list for Select Range.)

    > [!NOTE]
    > A Difference between the Adjusted Bank Balance and the Adjusted Book Balance should be expected, and will cause the **Reconcile** button to be unavailable at this point. Leave this window open in the background, and proceed to the next step.

7. Turn off posting to GL: An adjustment is needed in the above Reconcile window to offset the amount of the Difference. However, most often, this adjustment is not needed in GL, so use the following steps to first turn off posting to GL from Bank Reconciliation:

    1. Select Microsoft Dynamics GP, point to **Tools**, point to **Setup**, point to **Posting** and select **Posting**.
    2. In the Series list, select **Financial**.
    3. In the Origin list, select **Reconcile Bank Statement**.
    4. Clear the Post To General Ledger checkbox. (First take note if **Post Through General Ledger Files** was marked.)
    5. Select **Save**.

8. Key dummy adjustment: Back in the Reconcile window, an adjustment is needed to offset the Difference and get the reconciliation to zero for the sake of reconciling. To key the adjustment, follow these steps:

    1. Back in the Reconcile window, select the **Adjustments** button. The **Reconcile Bank Adjustments** window will open.
    2. Take note of the Difference listed at the bottom of the window and key the adjustment needed: If the Difference is a positive number, select **Other Expense**. But if the difference is a negative number, select **Other Income**.
    3. Enter the cash account. Remember that you turned off posting to GL in the prior step, so no entries will actually be made to GL.
    4. Enter the amount of the adjustment needed so the Difference shows as $0.00 at the bottom.
    5. Select **OK** to close the **Reconcile Bank Adjustments** window.

9. Print reports before reconciling:

    To do this:

    1. Back in the **Select Bank Transactions** window (or Reconcile window), select **File** and select **Print** to open the **Print Reconciliation Reports** window.
    2. Print the Reconcile Edit List report, and then print the Outstanding Transactions Report. Review the reports and make any changes as necessary.

    > [!NOTE]
    > Make sure that these reports match the reports from the reconciliation in step 1. Specifically, make sure that the outstanding transactions and the Bank Statement Ending Balance match. If any transactions are missing from the Outstanding Transactions report, you must enter them in Bank Transactions, and you must make sure not to post to the general ledger if the transaction has already updated GL.

10. Complete the reconciliation:

    To do this:

    1. Select **RECONCILE** in the Select Bank Transactions window to perform the reconciliation.
    2. Print the Posting reports to screen/file/printer as you wish.

    > [!NOTE]
    > Make sure the Outstanding Transactions Report contains the correct Reconciling items to carry forward.

11. Turn Posting to GL back on. Go back to the Posting Setup and turn posting to GL back on for Bank Reconciliation. To do this:

    1. Select Microsoft Dynamics GP, point to **Tools**, point to **Setup**, point to Posting and select **Posting**.
    2. In the Series list, select **Financial**.
    3. In the Origin list, select **Reconcile Bank Statement**.
    4. Remark the Post To General Ledger checkbox. (Also remark the **Post Through General Ledger Files** button if it was marked before to put it back how it was.)
    5. Select **Save**.

12. Make sure that the Last Reconciled Balance and Last Reconciled Date in **Checkbook Maintenance** window matches the Bank Statement Ending balance and Ending Date last used. (Select the **Cards** menu, point to **Financial** and select **Checkbook**.)

    > [!NOTE]
    > If these fields are not correct, that is fine, as they are informational only and will be overwritten the next time you reconcile.

## More information

For more information on how to reconcile the Checkbook Balance to the GL Cash Account Balance, see [The checkbook balance and the general ledger cash account do not balance in Microsoft Dynamics GP](https://support.microsoft.com/topic/kb-864652-the-checkbook-balance-and-the-general-ledger-cash-account-do-not-balance-in-microsoft-dynamics-gp-a9774c8e-5221-b432-bec2-5e08c7a0b446).

For more information on how to set up a brand new checkbook ID in Bank Reconciliation, see [How to set up a new Checkbook in Bank Reconciliation](https://support.microsoft.com/topic/kb-847594-how-to-set-up-a-new-checkbook-in-bank-reconciliation-fca40753-eedf-4228-80a7-844f4df35117).
