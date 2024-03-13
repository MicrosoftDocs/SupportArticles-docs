---
title: Error when you post a batch in Dynamics GP
description: Describes that you receive an error message when you try to post a batch in Microsoft Dynamics GP, or in Microsoft Business Solutions - Great Plains 8.0. Provides a resolution.
ms.reviewer:
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Error when you try to post a batch in Microsoft Dynamics GP: "The stored procedure glpPostBatch returned the following results: DBMS: 0, Great Plains: 20286"

This article provides a solution to an error that occurs when you post a batch in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 898996

## Symptoms

When you try to post a batch in Microsoft Dynamics GP, you receive the following error message:

> The stored procedure glpPostBatch returned the following results: DBMS: 0, Great Plains: 20286  
glpPostBatch. Select on Batch_Headers failed.

## Cause

This problem occurs for one of the following reasons:

- Posting Definitions Master table (SY00500) is corrupted.
- Missing or damaged stored procedure for 'dbo.glpPostBatch'.
- Missing trigger on the SY00500 table after rebuilding it.
- Stuck record in the SY00800/SY00801 activity tables in Dynamics database.

## Resolution

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

To resolve this problem, re-create the **Posting Definitions Master** table (SY00500). To do this, you can use either of two options. The steps in [Option 1: Use file maintenance](#option-1-use-file-maintenance) delete all batch records that are in the Posting Definitions Master table. The steps in [Option 2: Use the free toolkit from Professional Services Tools Library](#option-2-use-the-free-toolkit-from-professional-services-tools-library) keep the existing batch records by using the Professional Services Tools Library (PSTL) tool. This tool will help you re-create the Posting Definition Master table and re-create the stored procedures and the auto procedures without losing data.

### Option 1: Use file maintenance

1. Have all users exit Microsoft Dynamics GP.
2. On the **Microsoft Dynamics GP** menu, point to **Maintenance**, and then click **SQL**.
3. In the **Database** list, select the company database.
4. In the table list, click **Posting Definitions Master**. (which is the SY00500 table)
5. Click to select the following check boxes:
   - **Recompile**  
   - **Update Statistics**  
   - **Drop Table**  
   - **Create Table**  
   - **Drop Auto Procedure**  
   - **Create Auto Procedure**
6. Click **Process**.
7. Re-create the batches for each module in which you have unposted batches. To do this, follow the steps for each module.

   - General Ledger
        1. On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Utilities**, point to **Financial**, and then click **Reconcile**.
        2. In the **Reconcile Financial Information** dialog box, click to select the **Batches** check box, and then click **Reconcile**.
        3. When you are prompted to print the Error Log report, click **Cancel**.

   - Payables Management
        1. On the **Microsoft Dynamics GP** menu, point to **Maintenance**, and then click **Check Links**.
        2. In the **Series** list, click **Purchasing**.

            > [!NOTE]
            > If you do not use the Multicurrency module, go to step 7.
        3. In the **Logical Tables** list, select **Payables History Logical Files**, and then click
        **Insert**.
        4. Click **OK**.
        5. In the **Report Destination** dialog box, click to select the **Screen** check box, and then click **OK**.
        6. Close the **File Maintenance Error Report** dialog box.
        7. On the **Microsoft Dynamics GP** menu, point to **Maintenance**, and then click **Check Links**.
        8. In the **Series** list, click **Purchasing**.
        9. In the **Logical Tables** list, select **Payables Transaction Logical File**, and then click **Insert**.
        10. Click **OK**.
        11. In the **Report Destination** dialog box, click to select the **Screen** check box, and then click **OK**.

   - Purchase Order Processing
        1. On the **File** menu, point to **Maintenance**, and then click **Check Links**.
        2. In the **Series** list, click **Purchasing**.
        3. In the **Logical Tables** list, select **Purchasing Transactions**, and then click
        **Insert**.
        4. Click **OK**.
        5. In the **Report Destination** dialog box, click to select the **Screen** check box, and then click **OK**.

   - Receivables Management
        1. On the **Microsoft Dynamics GP** menu, point to **Maintenance**, and then click **Check Links**.
        2. In the **Series** list, click **Sales**.
        3. In the **Logical Tables** list, select **Receivables Open Transaction Files**, and then click **Insert**.
        4. Click **OK**.
        5. In the **Report Destination** dialog box, click to select the **Screen** check box, and then click **OK**.

   - Invoicing
        1. On the **Microsoft Dynamics GP** menu, point to **Maintenance**, and then click **Check Links**.
        2. In the **Series** list, click **Sales**.
        3. In the **Logical Tables** list, select **Invoice Work**, and then click **Insert**.
        4. Click **OK**.
        5. In the **Report Destination** dialog box, click to select the **Screen** check box, and then click **OK**.

   - Sales Order Processing
        1. On the **Microsoft Dynamics GP** menu, point to **Maintenance**, and then click **Check Links**.
        2. In the **Series** list, click **Sales**.
        3. In the **Logical Tables** list, select **Sales Work**, and then click **Insert**.
        4. Click **OK**.
        5. In the **Report Destination** dialog box, click to select the **Screen** check box, and then click **OK**.

   - Inventory
        1. On the **Microsoft Dynamics GP** menu, point to **Maintenance**, and then click **Check Links**.
        2. In the **Series** list, click **Inventory**.
        3. In the **Logical Tables** list, select **Inventory Transaction Work**, and then click
        **Insert**.
        4. Click **OK**.
        5. In the **Report Destination** dialog box, click to select the **Screen** check box, and then click **OK**.
        6. On the **Transactions** menu, point to **Inventory**, and then click **Batches**.
        7. Click the next record button to display the first inventory batch.
        8. Click to select the **Post to General Ledger** check box.
        9. Repeat steps 7 and 8 for each batch.

   - Bill of Materials
        1. On the **Microsoft Dynamics GP** menu, point to **Maintenance**, and then click **Check Links**.
        2. In the **Series** list, click **Inventory**.
        3. In the **Logical Tables** list, select **Bill of Materials Transactions**, and then click
        **Insert**.
        4. Click **OK**.
        5. In the **Report Destination** dialog box, click to select the **Screen** check box, and then click **OK**.

   - Project Accounting
        1. On the **Microsoft Dynamics GP** menu, point to **Maintenance**, and then click **PA Check Links**.
        2. In the **Logical Tables** list, click the first table that is listed and that corresponds to a Project Accounting transaction type that you use. Then, click **Insert**.

            The following table lists the transaction types and the tables that are available in Project Accounting.

            |Transaction type|Table|
            |---|---|
            |Timesheet|PA Timesheet Transactions|
            |Equipment Log|PA Equipment Log Transactions|
            |Miscellaneous Log|PA Miscellaneous Log|
            |Inventory Transfer|PA Inventory Transfer Transactions|
            |Purchasing Transactions|PA Purchasing Transactions|
            |Revenue Recognition|PA Revenue Recog Transactions|
            |Employee Expense|PA Employee Expense Transactions|
            |Billing Batches|PA Billing Transactions|

        3. Repeat step 2 by selecting the next applicable table that is listed in that step. Repeat step 2 as many times as required to insert all the applicable tables. Then, click **OK**.
        4. In the **Report Destination** dialog box, click to select the **Screen** check box, and then click **OK**.

### Option 2: Use the free toolkit from Professional Services Tools Library

1. Obtain the Professional Services Tools Library (PSTL) tool for Microsoft Dynamics GP 2010 or for Microsoft Dynamics GP 10.0.

    For more information about the Professional Services Tools Library, use one of the following options:

    Customers:
    For more information about PSTL, contact your partner of record. If you do not have a partner of record, visit the following web site to identify a partner: [Microsoft Pinpoint](https://pinpoint.microsoft.com/home)

    Partners:
    For more information about PSTL, visit the following web site:

    [Sell Dynamics on-premises](https://partner.microsoft.com/solutions/business-applications/dynamics-onprem)

2. Install the PSTL tool.
3. When the installation is complete, start Microsoft Dynamics GP.
4. When you are prompted to include a new code, click **Yes**.
5. Log in to Microsoft Dynamics GP as the system administrator (sa).
6. To add the PSTL tool to the shortcut bar, click **Add**, click **Other Window**, expand **Technical Service Tools**, expand **Project**, click **Professional Tools Library**, click **Add**, and then click **Done**.
7. On the shortcut bar, click **Professional Service Tools**.

    > [!NOTE]
    > You must wait for the SQL objects to build.
8. When you receive the prompt to enter registration keys, click **Cancel**.

    > [!NOTE]
    > You do not have to have registration keys to use Toolkit.
9. Click **Toolkit**. The, click **Next**.
10. Under **Toolkit Options**, click **Recreate SQL Objects**, and then click **Next**.
11. In the **Series** field, click **Company**.
12. In the **Table** field, click **SY00500**.
13. Under **Maintenance Options**, click to select the **Recreate Selected Table** check box, and then click to select the **Recreate data for selected table(s)** check box.
14. Click **Perform Selected Maintenance**.
15. Click **OK** when you receive the following messages:

    > Table will be recreated with data.  
    SY00500 table will be recreated with data. Verify a backup has been made before proceeding.  
    SY00500 has been recreated.

Additionally, you may have to re-create a trigger that is advised by Toolkit. (see Option 3).

### Option 3

After rebuilding the SY00500 table, check to see if the 'glpBatchHeadersDeletetrigger' exists on the table. If not, script it out from a working install to recreate it.

```sql
sp_helptrigger sy00500
```

### Option 4: Have all users log completely out of Dynamics GP and clear out the activity tables

These tables should be empty when all users are out.

```sql
SELECT * FROM DYNAMICS..ACTIVITY --shows users currently logged into GP
SELECT * FROM DYNAMICS..SY00800
SELECT * FROM DYNAMICS..SY00801
SELECT * FROM TEMPDB..DEX_LOCK
SELECT * FROM TEMPDB..DEX_SESSION

DELETE DYNAMICS..ACTIVITY
DELETE DYNAMICS..SY00800
DELETE DYNAMICS..SY00801
DELETE TEMPDB..DEX_LOCK
DELETE TEMPDB..DEX_SESSION
```
