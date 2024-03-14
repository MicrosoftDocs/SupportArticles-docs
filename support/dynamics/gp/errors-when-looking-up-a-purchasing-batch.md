---
title: Errors when looking up a Purchasing batch
description: Provides a solution to errors that occur when trying to look up a Purchasing batch in Payables Management using Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Financial - Payables Management
---
# "Index 0 of array 'VerifyBatchTotals' is out of range in script" Error messages when trying to look up a Purchasing batch in Payables Management using Microsoft Dynamics GP

This article provides a solution to errors that occur when trying to look up a Purchasing batch in Payables Management using Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2316165

## Symptoms

When you go to the Payables Batch Entry window and try to look up a batch, you receive the following error message:

> Unhandled Script exception:  
Index 0 of array 'VerifyBatchTotals' is out of range in script.  
'Batch_Lookup_Scrolling_Window SCROLL_FILL', Script terminated.

Then scroll down in the window to see the rest of the message:

> EXCEPTION_CLASS_SCRIPT_OUT_OF_RANGE  
SCRIPT_CMD_INDEX

When you select **OK**, you receive the following message:

>The selected record has been deleted.

## Cause

This message may be caused by a damaged record for a check batch in the SY00500 Posting Definitions Master table. This table holds the information on the batches in the system.

## Resolution

To resolve this issue, recreate the SY00500 Posting Definitions Master table by using one of the two options listed below. You can recreate this table by using SQL Maintenance within Microsoft Dynamics GP or by using the free Toolkit in Professional Services Tools Library. Both options are listed below:

> [!NOTE]
> Before proceeding, make sure you have a current restorable backup, or test these steps in a test environment first before applying the steps to your production database. Restore immediately to your backup if you get any unexpected results.

### OPTION 1 - USING SQL MAINTENANCE

1. Make a full backup of Microsoft Dynamics GP.
2. Select Microsoft Dynamics GP, point to **Maintenance**, and then select **SQL**.
3. Select the company database that is receiving the error.
4. In the Table list, select **Posting Definitions Master**.
5. On the right side of the window, select every check box, and then select **Process**.
6. Select **Yes** to the following message:
    > "You have selected to drop tables; this will delete any data in them. Are you sure you want to continue?"

> [!NOTE]
> This procedure re-creates the SY00500 - Posting Definitions Master table. However, you will temporarily lose all unposted batches. To retrieve these unposted batches, run the Check Links program on the sub modules. Then, reconcile the batches for Microsoft Great Plains General Ledger. However, it sets any batches that are set to Recurring to Single Use. You must change these batches back to Recurring if needed.

To retrieve the batches, follow these steps.

1. If you use the Multi-currency option in Microsoft Dynamics GP Payables Management, run the Check Links program on the Payables Historical Logical files before you run the Check Links program on the Payables Transaction Logical file. If you do use Multi-currency, then you can skip this step and go to step 2.

2. To run the Check Links program on the following files, select Microsoft Dynamics GP, point to **Maintenance**, select **Check Links**, select one of the following series names, and then type the corresponding Logical Table name. Follow this step for the following files:

    - Module: Payables Management  
    Series/Logical Table: Purchasing Series - Payables Transaction Logical

    - Module: Purchase Order Processing  
    Series/Logical Table: Purchasing Series - Purchasing Transaction Logical

    - Module: Receivables Management  
    Series/Logical Table: Sales Series - Receivables Open Transaction

    - Module: Invoicing  
    Series/Logical Table: Sales Series - Invoice Work File

    - Module: Sales Order Processing  
    Series/Logical Table: Sales - Sales Work File

    - Module: Inventory  
    Series/Logical Table: Inventory - Inventory Transaction Work file

    - Module: Bill of Materials  
    Series/Logical Table: Inventory - Inventory - Bill of Materials Transactions file

3. If you use Microsoft Dynamics GP Project Series (PS) Time & Expense, you must also run Check Links on the following files. To run Check Links on the following files, select **File**, select **Maintenance**, select **PS Check links**, and then select one of the following file names. Follow this step for the following files:

    - Timesheet Batches - PS Timesheet Transactions
    - Asset Log Batches - PS Asset Log Transactions
    - Expense Log Batches - PS Expense Log Transactions
    - Inventory Transfer Batches - PS Inventory Transfer Transactions
    - Purchase Order Batches - PS Purchase Order Transactions
    - Series name: Vendor Invoice Batches - PS Vendor Invoice Transactions
    - Employee Expense Batches - PS Employee Expense Transactions
    - Billing Batches - PS Billing Time & Materials Transactions

4. If any batches exist in Microsoft Dynamics GP General Ledger, select **Tools** on the Microsoft Dynamics GP menu, point to **Utilities**, point to **Financial**, and then select **Reconcile**. Select **Batches**, and then select **Reconcile** to reconcile your batches.

5. Retest to verify if the error message has been resolved.

### OPTION #2 - Using Professional Services Tools Library (PSTL)

1. Make a full backup of Microsoft Dynamics GP.

2. Have all the users sign out of Microsoft Dynamics GP.

3. Use the steps below to install Professional Services Tools Library (PSTL) and add it as a shortcut in Microsoft Dynamics GP. If you've already done it, you can skip this step.

    Steps to install Professional Tools Services Library (PSTL):

    1. Visit this CustomerSource site to download PSTL: (Installation instructions are included with the download.)

        - [Services tools library](https://partner.microsoft.com/solutions/business-applications/dynamics-onprem?printpage=false&stext=professional)

    1. After you install PSTL, sign into Microsoft Dynamics GP as the system administrator ('sa' user).

    1. Select **Yes** when prompted to include new code.

    1. To add PSTL to your shortcut bar, select **Add**, select **Other Window**, expand **Technical Service Tools**, expand **Project**, select **Professional Tools Library**, select **Add**, and then select **Done**.

4. On the shortcut bar, select **Professional Service Tools**. Wait for the SQL objects to build. When you're prompted to enter registration keys, just select **Cancel**. You don't need to use registration keys to use the free toolkit.

5. Select **Toolkit**. Select **Next**.

6. Under Toolkit Options, select **Recreate SQL Objects** and then select **Next**.

7. Next to **Series**, select **Company**.

8. Next to **Table**, select **SY00500**.

9. Under **Maintenance Options**, select both the **Recreate Selected Table** and **Recreate data for selected table(s)**.

    > [!IMPORTANT]
    > You must select the **Recreate data for selected table(s)**  check box so that the current data in the table is retained. If you forget to mark it, then you'll lose all your current data and would have to restore to your backup immediately.

10. Select **Perform Selected Maintenance**.

11. When you receive the following messages, select **OK**:

    > Table will be recreated with data
    >
    > SY00500 table will be recreated with data. Verify a backup has been made before proceeding
    SY00500 has been recreated

12. Retest to see if the error message has been resolved.

13. If you continue to get the error message, we'll need to recreate the indexes for the SY00800 (batch activity). To do it, follow the steps below to resolve the issue: (*Make sure that you have a restorable backup of your company database in case there's unwanted data loss.)

    1. Select the **Professional Services Tools Library link** from your Shortcuts tab, and then choose to enable Toolkit. The Toolkit window will appear.

    1. Select **Recreate SQL Objects** from the Toolkit window, and then select **Next**.

    1. Select **System** for the Series and SY00800 for the table.

    1. Under the **Maintenance Options**, select **Rebuild Indexes** for the Selected Table.

        > [!NOTE]
        > Verify that no one is posting or editing a batch when the indexes are being recreated for this table. The SY00800 table has a record in it any time a user is editing or posting a batch in any module.

    1. Select **Perform Selected Maintenance** button to recreate the indexes.

## More information

If you have any batches that go to batch recovery, see [KB - A batch is held in the Posting, Receiving, Busy, Marked, Locked, or Edited status in Microsoft Dynamics GP](https://support.microsoft.com/help/850289) for instructions on how to set the batch back to **Available** status.
