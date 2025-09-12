---
title: General Ledger isn't updated as expected
description: Describes a problem in which the General Ledger isn't updated as expected when you post a pay run in Microsoft Dynamics GP. Provides a resolution.
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.reviewer: theley
ms.custom: sap:Financial - General Ledger
---
# The General Ledger isn't updated as expected when you post a pay run in Microsoft Dynamics GP

This article provides a solution to an issue where the General Ledger isn't updated as expected when you post a pay run in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 973608

## Symptoms

When you post a pay run in Microsoft Dynamics GP, the General Ledger isn't updated as expected.

## Cause

This problem occurs for one of the following reasons:

- A payroll posting is interrupted.
- The payroll batch is posted to the General Ledger, but the batch is deleted accidentally.
- The **Post to General Ledger** check box isn't selected in the Posting Setup window when the payroll is posted.

## Resolution

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.  

### Resolution 1

To resolve this problem, restore the database from a backup before the pay run is posted.

> [!NOTE]
> This resolution might be the most desirable because the pay run can be reposted. After you restore the database, you don't have to run manual updates or void checks.

### Resolution 2

To solve this problem, remove the payroll that was posted from the payroll tables only and then rerun the payroll process.

For more information, see [Recovering from failed Payroll processing activity in Dynamics GP](https://community.dynamics.com/blogs/post/?postid=bf5f2537-6323-42e7-a7f7-d6bed4f447a5).

### Resolution 3

To resolve this problem, void the checks, and then repost the pay run.

Because the original checks weren't posted to the General Ledger, the voided checks shouldn't be posted to the General Ledger. So the posting should be turned off. To turn off posting and then void the checks, follow these steps:

1. Follow the appropriate steps for your version of the program.

    - Microsoft Dynamics GP 10.0

        On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **Posting**, and then select **Posting**.
    - Microsoft Dynamics GP 9.0

        On the **Tools** menu, point to **Setup**, point to **Posting**, and then select **Posting**.
    1. In the Posting Setup window, select **Payroll** in the **Series** field, and then select **Void Checks** in the **Origin** field.
    1. Verify that the **Post to General Ledger** check box is selected.
    1. Verify that the **Post Through General Ledger Files** check box isn't selected, and then select **OK**.

        > [!NOTE]
        > When this check box is not selected, Microsoft Dynamics GP will create a General Ledger batch that can be deleted when the checks are voided.

2. Void the checks. To do it, follow these steps:

    1. On the **Transactions** menu, point to **Payroll**, and then select **Void Checks**.
    2. Select the Checkbook ID from which the checks were posted.
    3. Select a display range to display the checks that you want to void. To do it, set a restriction either by check date or by audit trail code.
    4. Select **Redisplay** to display the check range, mark all the checks that didn't post to the General Ledger.
    5. Verify the check date and posting date. The check date is the date when the voided checks update Payroll. The posting date is the date when the General Ledger entries are assigned, these General Ledger entries will be deleted in the next step.
    6. Select **Process** to void the checks, print the posting reports, and then note the audit trail code for the voided checks. The audit trail code will be at the top of each posting report that prints.
3. Delete the voided check batch from the General Ledger. To do it, follow these steps:
    1. On the **Transactions** menu, point to **Financial**, and then select **Batches**.
    2. Select the **lookup** button (magnifying glass) to select the batch that was created from the voided checks. The Batch ID will be the audit trail code that is printed on top of the posting reports for the voided checks in step 2f.
    3. Select **Delete** to delete the batch of checks.
    4. Select **Delete** again to confirm the batch deletion.

4. Determine whether the payroll can be rerun and posted as usual.

    If checks have already been printed to the check stock, the checks from the reprinting can be printed to screen.

### Resolution 4

To resolve this problem, manually update the General Ledger by printing the "Distribution Breakdown History" report in Payroll. Then, manually post the journal entries to the General Ledger. To do it, follow these steps.

> [!NOTE]
> When you follow these steps, you lose the drill-back functionality for the journal entries that are manually entered. In the General Ledger, you will be unable to drill back to the payroll checks. Therefore, we recommend that you enter a reference that describes why these transactions are posted directly to the General Ledger.

1. Print the Distribution Breakdown History report. This report lists what should be posted to the General Ledger.
    1. On the **Reports** Menu, point to **Payroll**, and then select **History**.
    2. Under **Reports**, select **Distribution Breakdown History**.
    3. Select **New** to create a new report option.
    4. Under **Option**, select or type a report name.
    5. For **Ranges**, select **Audit Trail Code**.
    6. In the **From** field and in the **To** field, enter the audit trail code of the pay run that didn't post to the General Ledger. Then select **Insert**.
    7. Select **Destination**, and then determine whether you want to print the report to the screen or to the printer.
    8. Select **Save** to save the report.
    9. Close the Payroll History Report Options window, insert your report option into the print list from the Payroll History Reports, and then select **Print**.
    10. Verify that this report lists which journal entries have posted to the General Ledger.
2. Manually enter the journal entries into the General Ledger. To do it, follow these steps:
    1. On the **Transactions** menu, point to **Financial**, and then select **Batches**.
    2. In the Batch Entry window, type a new batch name, select **General Entry** in the **Origin** field, select **Single Use** for **Frequency**, and then select **Transactions**.
    3. In the Transaction Entry window, enter the journal entries that are posted. To do it, enter the accounts, the debit amount, and the credit amount.
    4. Select **Save** after each journal entry to advance to the next entry.
    5. After all journal entries are saved, close the Transaction Entry window.

3. Review and post the batch. To do it, follow these steps:
    1. On the **Transactions** menu, point to **Financial**, and then select **Batches**.
    2. Select the batch that you created in step 2b, and then press the printer icon in the upper-right corner of the window to print an Edit List.
    3. Review the Edit List to make sure that the transactions are entered correctly.
    4. Select **Post** to post the batch.
