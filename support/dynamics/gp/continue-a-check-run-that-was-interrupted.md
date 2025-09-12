---
title: Continue a check run that was interrupted
description: Describes how to continue a check run after the check run is interrupted in Payables Management in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle, cwaswick, kriszree
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:Financial - Payables Management
---
# How to continue a check run that was interrupted in Payables Management in Microsoft Dynamics GP

This article describes how to continue a check run after the check run is interrupted in Payables Management in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 852064

## Introduction

To continue after an interruption that occurs during a Payables Management check run, follow the appropriate option in step 1 below first.

## Step 1: Restore Microsoft Dynamics GP from a backup

**Option 1** - To continue after a check run is interrupted, restore Microsoft Dynamics GP to a prior backup, and rebuild the check run as you did before. Continue as normal. No other steps are required.

**Option 2** -If you can't resolve this problem by restoring Microsoft Dynamics GP from a backup, follow these steps below to clear out the temp tables and reset the batch back to available status using the steps below:

1. **Make a current backup**: Make sure that you have a current backup of the company database. To back up the company database in Microsoft Dynamics GP, follow these steps:
    1. Have all users sign out from Microsoft Dynamics GP.
    2. On the **File** menu, select **Backup**.
    3. In the **Company Name** list, select the company that you want to back up.
    4. In the **Select the backup file** box, select the yellow folder to open the location in which you want to put the backup file.
2. **View TEMP Tables**: View the contents of the following tables to verify that all users are logged out:
    - DYNAMICS..ACTIVITY
    - DYNAMICS..SY00800
    - DYNAMICS..SY00801
    - TEMPDB..DEX_LOCK
    - TEMPDB..DEX_SESSION

    To do it, run the following scripts against the Dynamics database:

    ```sql
    SELECT * FROM DYNAMICS..ACTIVITY
    SELECT * FROM DYNAMICS..SY00800 
    SELECT * FROM DYNAMICS..SY00801 
    SELECT * FROM TEMPDB..DEX_LOCK 
    SELECT * FROM TEMPDB..DEX_SESSION
    ```

    > [!NOTE]
    > When all users are signed out of Microsoft Dynamics GP, the tables above should be empty. Any records existing in these tables if all users are out of Microsoft Dynamics GP would be stuck records.

3. **Delete TEMP Tables**: If no results are returned, go to step 4. Otherwise, clear the stuck records by using any of the following appropriate scripts: (Be sure all users are out of Microsoft Dynamics GP.)

    ```sql
    DELETE DYNAMICS..ACTIVITY 
    DELETE DYNAMICS..SY00800 
    DELETE DYNAMICS..SY00801 
    DELETE TEMPDB..DEX_LOCK 
    DELETE TEMPDB..DEX_SESSION
    ```

4. **Reset Batch Status**: Set the computer check batch back to **available** status. To do it, run the following script against the company database:

    ```sql
    UPDATE SY00500 SET MKDTOPST=0, BCHSTTUS=0 where BACHNUMB='XXX'
    ```

    > [!NOTE]
    >
    > - Replace **XXX** with the batch number or the name of the batch that you're trying to post or select in Microsoft Dynamics GP.
    > - The value of **BACHNUMB** is the same as the value of the Batch ID window in Microsoft Dynamics GP

5. Review the batch and verify the accuracy of the transactions in the batch.

6. Go to [Step 2: Use the appropriate method](#step-2-use-the-appropriate-method). For more information about restoring Microsoft Dynamics GP from a backup, see [KB - A batch is held in the Posting, Receiving, Busy, Marked, Locked, or Edited status in Microsoft Dynamics GP](https://support.microsoft.com/help/850289).

## Step 2: Use the appropriate method

If you followed Option 2 from Step 1 above, then read each method below and determine which method you should use next to proceed:

- If all the checks weren't printed and not posted, use [Method 1](#method-1-the-checks-werent-printed).
- If all the checks were printed and all the checks weren't posted, use [Method 2](#method-2-the-checks-were-printed-but-not-posted).
- If all the checks were printed, but only some of the checks were partly posted, use [Method 3](#method-3-all-the-checks-in-the-check-run-were-printed-but-the-checks-were-only-partly-posted).
- If the posting was interrupted and there's data-damage (such as the check appears to be applied, but doesn't exist), you must restore to a backup immediately. (If you're unable to do it, the Partner will need to contact the Partner Assist team to open an advisory service request (as fixing damaged data is a billable consulting service and outside the scope of your regular support policy.)

### Method 1: The checks weren't printed

1. **Review batch**: After you've completed the steps in [Step 1: Restore Microsoft Dynamics GP from a backup](#step-1-restore-microsoft-dynamics-gp-from-a-backup), and if the status of the batch is Available, print and edit list of the batch so that you know what is included in the batch.

    To print a batch edit list, follow these steps:

    1. On the **Transactions** menu, point to **Purchasing**, and then select **Print Checks**. (Because the batch may be damaged, don't reprint or post the recovered batch.)
    2. In the Print Payables Checks window, select the **Payables batch** in the **Batch ID** field.
    3. select **Print**.
    4. When the Report Destination window appears, select the appropriate report destination, and then select **OK**.

2. **Run check links**: Run the Check Links operation on the Payables Transaction logical files. It's recommended to do it in a TEST company first and only do this step in the LIVE company if you agree with the results. If you do it in the LIVE company, be sure to make a current backup first and restore to the backup if you don't agree with the results. To run the Check Links operation, follow these steps:

    1. In Microsoft Dynamics GP, point to **Maintenance** on the Microsoft Dynamics GP menu, and then select **Check Links**.
    2. In the **Series** list, select **Purchasing**.
    3. In the **Logical Tables** list, select **Payables Transaction Logical Files**, and then select **Insert** to move this file to the **Selected Tables** list.
    4. select **OK**.
    5. When you're prompted, select a report destination, and then select **OK**.

3. **Delete batch**: Delete the computer check batch.

    1. On the **Transactions** menu, point to **Purchasing**, and select **Batches**.
    1. In the Batch ID field, select the batch that you want to delete. (Be sure to print an edit list of the batch first before deleting it.)
    1. Select **Delete**.
    1. When you're prompted to delete the batch, select **Delete**.

4. **Rebuild batch**: Reenter the checks and continue with the check run as normal. You can re-create Payables checks from one of the following locations:
   - Select Payables Checks window

      To access the **Select Payables Checks** window, point to **Purchasing** on the **Transactions** menu, and then select **Select Checks**.

   - Edit Payables Check Batch window

      To access the **Edit Payables Check Batch** window, point to **Purchasing** on the **Transactions** menu, and then select **Edit Check Batch**.

   - Edit Payables Checks window

      To access the **Edit Payables Checks** window, point to **Purchasing** on the **Transactions** menu, and then select **Edit Check**.

### Method 2: The checks were printed, but not posted

1. **Review batch**: After you've completed the steps in Step 1 and set the status of the batch to Available, print a batch edit list.

    To print a batch edit list, follow these steps:

    1. On the **Transactions** menu, point to **Purchasing**, and then select **Print Checks**.
    2. In the Print Payables Checks window, select the **Payables batch** in the **Batch ID** field.
    3. Select **Print**.
    4. When the Report Destination window appears, select the appropriate report destination, and then select **OK**.

2. **Delete batch**: Delete the Payables check batch. To do it, follow these steps:

    1. On the **Transactions** menu, point to **Purchasing**, and then select **Batches**.
    2. In the **Batch ID** field, select the batch that you want to delete.
    3. Select **Delete**.
    4. When you're prompted to delete the batch, select **Delete**.

3. **Run check links**: Run Check Links on the Payables Transaction logical files and on the Payables History logical files. It's recommended to do it in a TEST company first and only do this step in the LIVE company if you agree with the results. If you do it in the LIVE company, be sure to make a current backup first and restore to the backup if you don't agree with the results. To do it, follow these steps:

    1. I Microsoft Dynamics GP, point to **Maintenance** on the **Microsoft Dynamics GP** menu, and then select **Check Links**.
    2. In the **Series** list, select **Purchasing**.
    3. In the **Logical Tables** list, select **Payables Transaction Logical Files**, and then select **Insert** to move this file to the **Selected Tables** list.
    4. In the **Logical Tables** list, select **Payables History Logical Files**, and then select **Insert** to move this file to the **Selected Tables** list.
    5. Select **OK**.
    6. When you're prompted, select a report destination, and then select **OK**.

4. **Revert check number**: Specify in the Checkbook setup that you want to reuse the same check numbers. To do it, follow these steps:

    1. On the **Cards** menu, point to **Financial**, and then select **Checkbook**.
    2. In the Checkbook Maintenance window, select the checkbook that is used to process Payables checks in the **Checkbook ID** field.
    3. In the **Payables Options** section, mark the following check boxes:
        - **Duplicate Check Numbers**  
        - **Override Check Number**  
    4. In the Next Check Number field, set the Next Check Number back to the first check number that was originally used for the printed checks, so you can reprint the original checks again but to the screen and reuse the same check numbers. (Refer the Computer Check Edit List you printed.)

        > [!NOTE]
        > It assumes that no one else is printing checks, and the Next Check Number had advanced to the last check number that was printed in the interrupted check run.

    5. Select **Save**.

5. **Rebuild batch**: Re-create the checks

    You can re-create Payables checks from one of the following locations:

    - Select Payables Checks window

      To access the **Select Payables Checks** window, point to **Purchasing** on the **Transactions** menu, and then select **Select Checks**.

    - Edit Payables Check Batch window

      To access the **Edit Payables Check Batch** window, point to **Purchasing** on the **Transactions** menu, and then select **Edit Check Batch**.

    - Edit Payables Checks window

      To access the **Edit Payables Checks** window, point to **Purchasing** on the **Transactions** menu, and then select **Edit Check**.

      > [!NOTE]
      > Make sure that you set the check number back to the original beginning check number. Before you print and post the checks, verify the batch edit list and the information in the Payables Transaction Inquiry window to make sure that the invoices still have a status of Open .

6. **Print**: Print the checks to the screen or to plain paper.

    > [!NOTE]
    > You can print Payables checks from the location in which you created the checks.

7. **Post**: Post the batch

    To post the Payables check batch, follow these steps:

    1. On the **Transactions** menu, point to **Purchasing**, and then select **Post Checks**.
    2. In the Post Payables Checks window, select the batch ID that has to be posted in the **Batch ID** field.
    3. Enter the appropriate posting date for the checks.
    4. In the **Process** list, select **Post Checks**.
    5. Select **Process**.

### Method 3: All the checks in the check run were printed, but the checks were only partly posted

**Solution 1**  
If you have a backup, you can only restore and print the checks to the screen or to blank paper, and then post the checks.

> [!NOTE]
> Remember to verify that General Ledger items were posted correctly. If you are set up to Post to General Ledger, verify a saved batch exist in GL and is correct. If you're set up to Post Through to General Ledger Files, review the Detailed Trial Balance report to verify the posted GL entries are correct.

To verify the entries in General Ledger by printing the Detail Trial Balance report, point to **Financial** on the **Reports** menu, and then select **Trial Balance**.

To set up the ability to post transaction entries to General Ledger, point to Tools on the Microsoft Dynamics GP menu, point to **Setup**, point to **Posting**, and then select **Posting**. Select **Purchasing** for the Series and Computer Checks for the Origin. Mark if you want the batch to Post to General Ledger(stop the batch in GL), or Post Through to General Ledger Files.  
**Solution 2**

1. **Delete batch**: After you've completed the steps in [Step 1: Restore Microsoft Dynamics GP from a backup](#step-1-restore-microsoft-dynamics-gp-from-a-backup), and if the status of the batch is Available, delete the batch. To delete the Payables check batch, follow these steps:

    1. On the **Transactions** menu, point to **Purchasing**, and then select **Batches**.
    2. In the **Batch ID** field, select the batch that has to be deleted.
    3. Select **Delete**.
    4. When you're prompted to delete the batch, select **Delete**.

1. **Run Check Links**: Run Check Links on the Payables Transaction logical files and on the Payables History logical files. It's recommended to do it in a TEST company first and only do this step in the LIVE company if you agree with the results. If you do it in the LIVE company, be sure to make a current backup first and restore to the backup if you don't agree with the results. To do it, follow these steps:

    1. In Microsoft Dynamics GP, point to **Maintenance** on the **Microsoft Dynamics GP** menu, and then select **Check Links**.
    2. In the **Series** list, select **Purchasing**.
    3. In the **Logical Tables** list, select **Payables Transaction Logical Files**, and then select **Insert** to move this file to the **Selected Tables** list.
    4. In the **Logical Tables** list, select **Payables History Logical Files**, and then select **Insert** to move this file to the **Selected Tables** list.
    5. Select **OK**.
    6. When you're prompted, select a report destination, and then select **OK**.

1. **VERIFY**: Verify that the items that you posted are posted correctly. Make sure that both the Apply information and the Distribution information is correct for the Payables checks.

    To verify this information in the Payables Transaction Inquiry - Vendor window, follow these steps:

    1. On the **Inquiry** menu, point to **Purchasing**, and then select **Transaction by Vendor**.
    2. In the **Vendor ID** field, select the associated vendor ID.
    3. Select the document that you want, and then select the **Document Number** link.
    4. In the Payables Transaction Entry Zoom window, select **Apply** to view the information about invoice documents and about credit memos, returns, or payments that were applied to those documents.
    5. In the Payables Transaction Entry Zoom window, select **Distributions** to view distribution information for a transaction.
    6. Verify that the information is correct.

1. **Rebuild/Repost**: After you delete the batch and run Check links, find the unposted checks for the unapplied documents.

   1. Rebuild another computer check batch and reselect only those invoices that still have an OPEN status.

        > [!NOTE]
        >  Make sure that the checks that you select appear in the line that contains the check numbers that printed. Otherwise, you may have to process one vendor or a range of vendors at a time.

   1. Determine what 'check number' you previously printed that you need to 'start' on.  (You may need to go to **Cards** > **Financial** > **Checkbook**, and mark the option to **Allow duplicate check numbers** for now.)
   1. Proceed with the check run and update the check number as needed (to match what you printed earlier) and then Print the checks to the screen or to blank paper again if needed.
   1. Review to make sure the check numbers align with the vendor ID's to what was printed and if all is correct, then you can Post the Batch.
   1. Review for accuracy.

1. Verify that GL was updated correctly.

   - If any GL entries are missing, verify if there's a GL batch that is unposted. If not, you may need to key a GL entry directly in to GL under **Transactions** > **Financial** > **General**.
   - If there are duplicate Journal entries in GL, then go find the JE numbers, and go to **Transactions** > **Financial** > **General**, and select the **CORRECT** button, select the original JE and year, and back out the JE. (or you can just key an offsetting JE to reverse one of the duplicate JE's out.)

1. Verify that bank reconciliation was updated correctly.

   - Review that all checks are in the CM20200 table under the checkbook ID.
   - If checks are duplicated in bank reconciliation, it's recommended to key an offsetting increase adjustment in bank reconciliation to offset them (so the checkbook balance is increased and GL is updated). If you don't need GL updated, then stop the batch in GL and delete it, (or you can key a deposit without receipts instead of an increase adjustment, as deposits don't hit GL. Just put a good note on it.)
