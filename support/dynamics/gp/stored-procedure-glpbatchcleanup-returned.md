---
title: Stored Procedure GLpBatchCleanup Returned
description: Provides a solution to an error that occurs when you post a batch in the general ledger in Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Financial - General Ledger
---
# "The Stored Procedure GLpBatchCleanup Returned the Following Results: DBMS: 0, Dynamics: 20486" Error message when you post a batch in the general ledger in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you post a batch in the general ledger in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 860710

## Symptoms

When you post a batch in the general ledger in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains, you receive the following error message:

> The stored procedure glpBatchCleanup returned the following results: DBMS: 0, Dynamics: 20486

If you select **More Info**, you receive the following error message:

> glpBatchCleanup. Error occurred attempting to update the Batch Headers

## Cause

This problem can have either of the following causes.

### Cause 1

This problem occurs if the current year that is being posted to is marked as a historical year. See [Resolution 1](#resolution-1).

### Cause 2

This problem occurs if invalid records exist in the SY00800 table or in the SY00801 table. See [Resolution 2](#resolution-2).

## Resolution 1

To resolve this problem, change the setting for the historical year. To do it, follow these steps:

1. In Microsoft Dynamics GP, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Company**, and then select **Fiscal Periods**.
2. Select to clear the **Historical Year** check box, and then select **Save**.  
3. On the **Transactions** menu, point to **Financial**, and then select **Batches**.  
4. **Post** the batch.  

## Resolution 2

To resolve this problem, clear the records in the SY00800 table or in the SY00801 table. To do it, follow these steps:

1. Back up the Microsoft Dynamics GP company database.  
2. Back up the Dynamics database.  
3. Have all users sign out of Microsoft Dynamics GP.  
4. Stop and then start the computer that is running Microsoft SQL Server to clear out the temporary tables.  
5. Start SQL Server Management Studio. To do it, use the appropriate step depending on the program that you're using:

    - If you're using SQL Server 2005, start SQL Server Management Studio. To do it, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.
    - If you're using SQL Server 2008, start SQL Server Management Studio. To do it, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2008**, and then select **SQL Server Management Studio**.
    - If you're using SQL Server 2012, start SQL Server Management Studio. To do it, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2012**, and then select **SQL Server Management Studio**.

6. Select the Dynamics database. Then, use the following statements to delete all the records from the ACTIVITY table, the SY00800 table, and the SY00801 table:

    ```sql
    DELETE DYNAMICS..ACTIVITY 
    DELETE DYNAMICS..SY00800 
    DELETE DYNAMICS..SY00801
    ```

7. Select the TEMPDB database. Then, use the following statements to delete all the records from the DEX_LOCK table and the DEX_SESSION table:

    ```sql
    DELETE TEMPDB..DEX_LOCK
    DELETE TEMPDB..DEX_SESSION
    ```

## More information

The SY00800 table is the Batch Activity table. This table is used to track the status of batches. If a batch record is in this table, the batch is being edited, posted, posted to, or deleted.

The SY00801 table is the Resource Activity table. It's typically used by batches. This table is used to report some items or information that couldn't be updated.
