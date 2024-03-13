---
title: Transaction Level Posting Has Not Completed error when using the Sales Transaction Entry window
description: Describes a problem that occurs for one specific user ID. This problem may occur if an invalid record exists in the SY00500 table. A resolution is provided.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Transaction Level Posting Has Not Completed" error when using the Sales Transaction Entry window

This article provides a resolution for the error that occurs when you use the Sales Transaction Entry window in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 853972

## Symptoms

When you try to use the Sales Transaction Entry window in Microsoft Dynamics GP, you receive the following error message:

> Transaction Level Posting Has Not Completed.
>
> Your previous transaction-level posting has not finished processing. Please allow time for it to finish. If you believe it has failed, log out of Microsoft Dynamics GP and log back in to recover transactions.

This problem occurs for one specific user ID.

## Cause

This problem may occur if an invalid record exists in the SY00500 table.

## Resolution

To resolve this problem, follow these steps;

1. Have the user that had the issue log out of Microsoft Dynamics GP. (Note the document number for the problem invoice.)
2. Open a query window in SQL Server Management Studio using the appropriate step:

   - If you are using Microsoft SQL Server 2005, start SQL Server Management Studio. To do this, select **Start**, point to **Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.
   - If you are using SQL Server 2000, start SQL Query Analyzer. To do this, select **Start**, point to **Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.
   - If you are using Microsoft SQL Server 2008 or Microsoft SQL Server 2008 R2, start SQL Server Management Studio. To do this, select **Start**, point to **Programs**, point to **Microsoft SQL Server 2008 or Microsoft SQL Server 2008 R2**, and then select **SQL Server Management Studio**.
   - If you are using Microsoft SQL Server 2012, start SQL Server Management Studio. To do this, select **Start**, point to **Programs**, point to **Microsoft SQL Server 2012**, and then select **SQL Server Management Studio**.

3. Execute the following statement against the company database and if you find a batch listed with the user's ID as the batch name, you can delete it.

    ```sql
    SELECT * from SY00500 whereBACHNUMB = 'xxx'
    Delete SY00500 where BACHNUMB = 'xxx'
    ```

    where xxx is the USER'S ID that had the issue.

4. If the user is logged out of Microsoft Dynamics GP, then they should not have any records in the SY00800 or SY00801 temp tables. If they do, remove these locked records:

    ```sql
    Select * from DYNAMICS..SY00800 where USERID = 'xxx'
    Select * from DYNAMICS..SY00801 where USERID = 'xxx'
    
    Delete DYNAMICS..SY00800 where USERID = 'xxx'
    Delete DYNAMICS..SY00801 where USERID = 'xxx'
    ```

    where xxx is the USER'S ID that had the issue.

5. Now have the user log back in to Microsoft Dynamics GP and review the transaction or rekey it, if needed.

If the problem persists, see [Error message when you try to open the Sales Transaction Entry window in Sales Order Processing in Microsoft Dynamics GP: "Your previous transaction-level posting session has not finished processing"](https://support.microsoft.com/topic/error-message-when-you-try-to-open-the-sales-transaction-entry-window-in-sales-order-processing-in-microsoft-dynamics-gp-your-previous-transaction-level-posting-session-has-not-finished-processing-64e5a44d-2859-d6c4-e7b1-2ed675576239).
