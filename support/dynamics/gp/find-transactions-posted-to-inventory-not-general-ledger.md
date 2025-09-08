---
title: How to find transactions that are posted to Inventory but not to General Ledger in Microsoft Dynamics GP
description: Describes how to find transactions that are posted to Inventory, but that aren't posted to General Ledger.
ms.reviewer: theley
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:Financial - General Ledger
---
# How to find transactions that are posted to Inventory but not to General Ledger in Microsoft Dynamics GP

This article describes how to find transactions that are posted to Inventory in Microsoft Dynamics GP, but that aren't posted to General Ledger in Microsoft Dynamics GP. These transactions aren't posted to General Ledger because the **Post to General Ledger** check box in the Inventory Batch Entry window isn't selected.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 932023

To find transactions that are posted to Inventory, but that aren't posted to General Ledger, use one of the following methods.

## Method 1

1. Reprint the inventory posting journals by following these steps:
    1. On the **Reports** menu, point to **Inventory**, and then click **Posting Journals**.
    1. In the Reprint Inventory Journals window, click **New** to create a report option.
    1. In the Reprint Inventory Journal Options window, type a name in the **Option** box, select **Date Posted** in the **Ranges** list, set the starting date in the **From** field, set the ending date in the **To** field, and then click **Insert**.
    1. Click **Save**.
    1. Close the Inventory Journal Options window.
    1. In the Reprint Inventory Journals window, select the new option that you created in step 1c in the **Options** section, click **Insert**, and then click **Print**. You can see the amount that was posted. You can also see the accounts that should have been posted to General Ledger.
1. Reprint distributions that were posted to General Ledger by following these steps:
    1. On the **Reports** menu, point to **Inventory**, and then click **History**.
    1. In the Inventory History Reports window, select **Distribution History** in the **Reports** list.
    1. Click **New** to create a report option.
    1. In the Inventory History Report Options window, type a name in the **Option** box, select **Date Posted** in the **Ranges** list, and then set the same date range that you set in step 1c.
    1. Click **Save**.
    1. Close the Inventory History Report Options window.
    1. In the Inventory History Reports window, select the new option that you created in step 2c in the **Options** section, click **Insert**, and then click **Print**.
1. Compare the transactions that are posted to Inventory and the transactions that are posted to General Ledger, and then reprint the cross reference journals. To do it, follow these steps:
    1. On the **Reports** menu, point to **Financial**, and then click **Cross-Reference**.
    1. Create a new report option that uses the same date restriction as the previous inventory transactions.
    > [!NOTE]
    > If these are all Inventory Adjustment transactions, you can restrict the report results to the same inventory transactions. To do this, select **Source Document** in the **Range** list, and then select **IVADJ** in the **From** field and in the **To** field.

## Method 2

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

To find the transactions, run a script in Microsoft SQL Server 2005 Management Studio or in SQL Query Analyzer.

### SQL Server Management Studio

1. Click **Start**, point to **All Programs** > **Microsoft SQL Server 2008orMicrosoft SQL Server 2005**, and then click **SQL Server Management Studio**.
2. In the "Connect to Server" window, select the server that is running SQL Server in the **Server name** list, select **SQL Authentication** in the **Authentication** list, type sa in the **User name** box, type the password for the sa user in the **Password** box, and then click **Connect**.
3. On the **File** menu, point to **New**, and then click **Query with Current Connection**.
4. Type the following script.

    ```SQL
    select * from IV30100 where TRXSORCE
    NOT IN (select ORTRXSRC from GL20000) and BCHSOURC = 'IV_Trxent'
  
    ```

5. Click **Query** > **Execute**.

### SQL Query Analyzer

1. Click **Start**, point to **All Programs** > **Microsoft SQL Server**, and then click **Query Analyzer**.
2. In the "Connect to Server" window, select the server that is running SQL Server in the **Server name** list, select **SQL Authentication** in the **Connect using** list, type sa in the **User name** box, type the password for the sa user in the **Password** box, and then click **OK**.
3. In the Query window, type the following script.

    ```SQL
    select * from IV30100 where TRXSORCE
    NOT IN (select ORTRXSRC from GL20000) and BCHSOURC = 'IV_Trxent'
    ```

4. Click **Query**, and then click **Execute**.

The script in Method 2 can be used to look in the "Year-to-Date Transaction Open" table (GL20000). The "Year-to-Date Transaction Open" table (GL20000) contains open posted transactions in Financials and in General Ledger. If you want to look in the Transaction Work table (GL10000) or in the Account Transaction History table (GL30000), change GL20000 to GL10000 or to GL30000 in the script.

If you want to look for inventory transfers, change "BCHSOURC = 'IV_Trxent'" to "BCHSOURC='IV_Trans'." "BCHSOURC='IV_Trans'" indicates that the transactions originate from the Inventory Transfer Entry window and that the transactions are batch posted.

If you change "BCHSOURC = 'IV_Trxent'" to "BCHSOURC='IV_Trans'," the complete script resembles the following script.

```SQL
select * from IV30100 where TRXSORCE
NOT IN (select ORTRXSRC from GL20000) and BCHSOURC='IV_Trans'
```
