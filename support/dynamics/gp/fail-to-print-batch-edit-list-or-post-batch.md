---
title: Error when you print a batch edit list or post a batch in General Ledger
description: Describes steps to resolve the error message that occurs when you print a batch edit list or post a batch in General Ledger in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Financial - General Ledger
---
# Error message when you print a batch edit list or post a batch in General Ledger in Microsoft Dynamics GP: "The stored procedure glpBatchCleanup returned the following results: DBMS 0, Great Plains 20488"

This article provides help to solve an issue where you fail to print a batch edit list or post a batch in General Ledger in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 896545

## Symptoms

When you print a batch edit list or post a batch in General Ledger in Microsoft Dynamics GP, you receive the following error message:

> The stored procedure glpBatchCleanup returned the following results: DBMS 0, Great Plains 20488

## Cause 1

This problem may occur if the SY00500 - Posting Definitions Master table is damaged. To resolve this problem, see [Resolution 1](#resolution-1-may-get-dbms-errors-for-gp-20488-or-20486).

## Cause 2

The stored procedure for glpBatchCleanup may be corrupted. To re-create the stored procedures, see [Resolution 2](#resolution-2).

## Cause 3

Third-party products may be altering the stored procedures incorrectly. For information about how to disable third-party products, see [Resolution 3](#resolution-3).

## Cause 4

There are inconsistencies between the GL work tables for this batch. See [Resolution 4](#resolution-4-may-get-dbms-errors-for-gp-20488-or-20957).

## Cause 5

Users are stuck in the GL work tables. See [Resolution 5](#resolution-5-may-get-dbms-error-for-gp-20486-from-kb-860710).

## Cause 6

The user has a permissions issue. See [Resolution 6](#resolution-6-may-get-dbms-error-for-gp-229).

## Resolution 1 (May get DBMS errors for GP 20488 or 20486)

To resolve this problem, re-create the SY00500 - Posting Definitions Master table. To re-create this table, use one of the following methods.

> [!NOTE]
> If the SY00500 table contains a trigger, the trigger must be re-created after you follow these steps.

### Method 1: Use SQL Maintenance

1. Make a full backup of Microsoft Dynamics GP.
2. From the **Microsoft Dynamics GP** menu, point to **Maintenance**, and then click **SQL**.
3. Click the company database that is receiving the error.
4. In the **Table** list, click **Posting Definitions Master**.
5. On the right side of the window, click to select every check box, and then click **Process**.
6. Click **Yes** when you receive the following message:
1
    > You have selected to drop tables; this will delete any data in them. Are you sure you want to continue?

This procedure re-creates the SY00500 - Posting Definitions Master table. However, you will temporarily lose all unposted batches. To retrieve these unposted batches, run the Check Links program on the sub modules. Then, reconcile the batches for General Ledger. However, this sets any batches that are set to **Recurring** to**Single Use**. You must change these batches back to **Recurring**.

To retrieve the batches, follow these steps.

> [!NOTE]
> If you use the **Multicurrency** option in Payables Management in Microsoft Dynamics GP, run the Check Links program on the Payables Transaction History Logical file before you run the Check Links program on the Payables Transaction Logical file.

1. To run the Check Links program on the following files, from the **Microsoft Dynamics GP** menu, click **Maintenance**, click **Check Links**, click one of the following series names, and then type the corresponding file name. Follow this step for the following files:
   - Series name: Payables Management

    File name: Purchasing Series - Payables Transaction Logical
   - Series name: Purchase Order Processing

    File name: Purchasing Series - Purchasing Transaction Logical
   - Series name: Receivables Management

    File name: Sales Series - Receivables Open Transaction
   - Series name: Invoicing

    File name: Sales Series - Invoice Work File
   - Series name: Sales Order Processing

    File name: Sales - Sales Work File
   - Series name: Inventory

    File name: Inventory - Inventory Transaction Work file
   - Series name: Bill of Materials

    File name: Inventory - Inventory - Bill of Materials Transactions file

2. If you use Project Accounting with Microsoft Dynamics GP, you must also run Check Links on the following files. To run Check Links on the following files, on the **Microsoft Dynamics GP** menu, point to **Maintenance**, click **PA Check Links**, click **Insert**, and then click one of the following table names. Follow this step for the following files:
   - Timesheet Batches - PA Timesheet Transactions
   - Miscellaneous Log Batches - PA Miscellaneous Log Transactions
   - Equipment Log Batches - PA Equipment Log Transactions
   - Inventory Transfer Batches - PA Inventory Transfer Transactions
   - Receivings Batches - PA Purchasing Transactions
   - Revenue Recognition Batches - PA Revenue Recog Transactions
   - Employee Expense Batches - PA Employee Expense Transactions
   - Billing Batches - PA Billing Transactions

3. If any batches exist in Microsoft Great Plains General Ledger, on the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Utilities**, point to **Financial**, and then click **Reconcile**. Click to select the **Batches** check box, and then click **Reconcile** to reconcile your batches.

### Method 2: Use the free toolkit from Professional Services Tools Library

1. Make a full backup of Microsoft Dynamics GP.
2. Have all users log off from the system.
3. Install the Professional Services Tools Library (PSTL).

    > [!NOTE]
    > This download is located under **Downloads and Updates, Service Packs & Product Releases, Professional Services Tools Library (PSTL) for Microsoft Dynamics (North America Only)**. Installation instructions are included with the download.
4. After you install the PSTL, start Microsoft Dynamics GP. When you are prompted to include new code, click **Yes**.
5. Log on to Microsoft Dynamics GP as the system administrator.
6. To add Professional Services Tools Library to the shortcut bar, in your Home series, click **Add**, click **Other Window**, expand **Technical Service Tools**, expand **Project**, click **Professional Tools Library**, click **Add**, and then click **Done**.
7. On the Home series shortcut bar, click **Professional Service Tools**. Wait for the SQL objects build. When you are prompted to enter registration keys, click **Cancel**. You do not have to have registration keys to use this tool.
8. Click **Toolkit**, and then click **Next**.
9. Under **Toolkit Options**, click **Recreate SQL Objects**, and then click **Next**.
10. Next to **Series**, click **Company**.
11. Next to **Table**, click **SY00500**.
12. Under **Maintenance Options**, click to select the **Recreate Selected Table** check box, and then click to select the **Recreate data for selected table(s)** check box.
13. Click **Perform Selected Maintenance**.
14. When you receive the following messages, click **OK**:

    > Table will be recreated with data  
    SY00500 table will be recreated with data. Verify a backup has been made before proceeding
    SY00500 has been recreated

## Resolution 2

Re-create the stored procedures for both glpBatchCleanup and glpBatchPost by using Database Maintenance. To do this, follow these steps:

1. Make sure all users are logged off from Microsoft Dynamics GP.
2. Click the **Start**, click **All Programs**, click **Microsoft Dynamics GP**, click the version of Microsoft Dynamics GP on which this problem occurs, and then click **Database Management**.
3. Enter the Server Name for the Dynamics Server that you are using. For example, use the following: **COMPUTER_NAME** \ **SERVER_INSTANCE**
4. Click to select the **DYNAMICS Database ID** check box, and then click **Next**.
5. Click to select the **Microsoft Dynamics GP** check box, and then click **Next**.
6. Click to select the **Functions** check box, and then click **Next**.

## Resolution 3

Third-party products may be altering the stored procedures. Disable any third-party products from the Dynamics.set file, and test again. For more information about how to disable third-party products in the Dynamics.set file, see [How to disable third-party products or temporarily disable additional products in the Dynamics.set file in Microsoft Dynamics GP](https://support.microsoft.com/help/872087).

## Resolution 4 (may get DBMS errors for GP 20488 or 20957)

The information between the GL work tables is inconsistent. Run the script below against the company database and review the records for this batch in both tables. If you do not get records from both scripts, then review the whole table to make sure the batch number field is not blank in one table. The BACHNUMB should be the same between both tables for this batch.  

The GL10001 should contain records for the transactions in this batch.

```sql
select * from GL10000 where BACHNUMB = 'xxx'
select * from GL10001 where BACHNUMB = 'xxx'
--update the xxx placeholder with the GL batch name and run against the company database.
```

## Resolution 5 (may get DBMS error for GP 20486 from KB 860710)

Users may be stuck in the GP activity table for the GL work tables.

1. Ask all users to log out of all companies in Dynamics GP.
2. When all users are out of Dynamics GP, these tables should be empty:

    ```sql
    SELECT * FROM DYNAMICS..ACTIVITY
    ```

    ```sql
    SELECT * FROM DYNAMICS..SY00800
    ```

    ```sql
    SELECT * FROM DYNAMICS..SY00801
    ```

    ```sql
    SELECT * FROM TEMPDB..DEX_LOCK
    ```

    ```sql
    SELECT * FROM TEMPDB..DEX_SESSION
    ```

3. Run these scripts to delete any activity returned:

    ```sql
    DELETE DYNAMICS..ACTIVITY
    ```

    ```sql
    DELETE DYNAMICS..SY00800
    ```

    ```sql
    DELETE DYNAMICS..SY00801
    ```

    ```sql
    DELETE TEMPDB..DEX_LOCK
    ```

    ```sql
    DELETE TEMPDB..DEX_SESSION
    ```

## Resolution 6 (may get DBMS error for GP 229)

The 229 reference in the error message indicates a permissions issue. Run the grant.sql script against both the company and Dynamics databases. (The grant.sql script can be found in the GP code folder, SQL| UTIL folder)
