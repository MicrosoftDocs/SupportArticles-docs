---
title: Your previous transaction-level posting session has not finished processing error when opening the Sales Transaction Entry window
description: Describes a problem that may occur when records are locked in the SY00500 table, in the SY00800 table, or in the SOP10100 table. A resolution is provided.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Your previous transaction-level posting session has not finished processing" error when opening the Sales Transaction Entry window in Sales Order Processing

This article provides a resolution for the **Your previous transaction-level posting session has not finished processing** error that may occur when you try to open the Sales Transaction Entry window in Sales Order Processing in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 852623

## Symptoms

You may receive the following error message when you try to open the Sales Transaction Entry window in Sales Order Processing in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains:

> Your previous transaction-level posting session has not finished processing. Please allow time for it to finish. If you believe it has failed, log out of Great Plains and log back in to recover transactions.

> [!NOTE]
> To open the Sales Transaction Entry window, select **Transactions**, point to **Sales**, and then select **Sales Transaction Entry**.

## Cause

This problem may occur when records are locked in the SY00500 table, in the SY00800 table, or in the SOP10100 table. Records have a batch number that is blank, or the User ID is listed as the batch number.

## Resolution

To resolve this problem, follow these steps:

1. Have all users exit Microsoft Dynamics GP.
2. Make a backup of the company database.
3. In SQL Query Analyzer, run the following delete statement on the SY00800 table against the DYNAMICS database.

    ```sql
    DELETE SY00800
    ```

4. Look for the problem records in the SY00500 table by running both the following statements against the company database.

    > [!NOTE]
    >  In the following statements, **xxx** represents the user ID that contains the error.

    ```sql
    SELECT * from SY00500 where BACHNUMB = ''
    SELECT * from SY00500 where BACHNUMB = 'xxx'
    ```

5. If you have records that are returned with a blank BACHNUMB field, use the following delete statement.

    ```sql
    DELETE SY00500 where BACHNUMB = ''
    ```

6. If you have records that are returned with a User ID in the BACHNUMB field, use the following delete statement.

    > [!NOTE]
    > In the following statement, **xxx** represents the user ID that contains the error.

    ```sql
    DELETE SY00500 where BACHNUMB ='xxx'
    ```

7. Verify that you can select existing documents in the Sales Transaction Entry window. To open this window, select **Transactions**, point to **Sales**, and then select **Sales Transaction Entry**. If you want to delete an existing document, select **Delete**. If you want to void an existing document, select **Void**.

8. If you continue to receive the error message, or if you cannot select the existing documents in the Sales Transaction Entry window, run the following scripts in SQL Query Analyzer against the company database to locate problem records in the SOP10100 table.

    > [!NOTE]
    > In the following scripts, **xxx** represents the user ID that contains the error.

    ```sql
    SELECT BACHNUMB,* from SOP10100 where BACHNUMB = '' SELECT BACHNUMB,* from SOP10100 where BACHNUMB = '<xxx>'
    SELECT * FROM SOP10200 where SOPNUMBE in (SELECT SOPNUMBE from SOP10100 where BACHNUMB = 'xxx')
    SELECT * FROM SOP10200 where SOPNUMBE in (SELECT SOPNUMBE from SOP10100 where BACHNUMB = ' ')
    SELECT * FROM SOP10102 where SOPNUMBE in (SELECT SOPNUMBE from SOP10100 where BACHNUMB = 'xxx')
    SELECT * FROM SOP10102 where SOPNUMBE in (SELECT SOPNUMBE from SOP10100 where BACHNUMB = ' ')
    ```

9. Note any records that are returned, and then run the following statement in SQL Query Analyzer to delete the problem records from the SOP10100 table.

   > [!NOTE]
   >
   > - You must verify that the transactions are posted to the Inventory module and to the Receivables Management modules. If the transactions did not post to the Inventory module and to the Receivables Management module, you must reenter the transactions in the Sales Transaction Entry window after you run the delete statements.
   > - In the following statements, **xxx** represents the user ID that contains the error.

    ```sql
    DELETE SOP10200 where SOPNUMBE in (SELECT SOPNUMBE from SOP10100 where BACHNUMB = 'xxx')
    DELETE SOP10200 where SOPNUMBE in (SELECT SOPNUMBE from SOP10100 where BACHNUMB = ' ')
    DELETE SOP10102 where SOPNUMBE in (SELECT SOPNUMBE from SOP10100 where BACHNUMB = 'xxx')
    DELETE SOP10102 where SOPNUMBE in (SELECT SOPNUMBE from SOP10100 where BACHNUMB = ' ')
    DELETE SOP10100 where BACHNUMB = '' DELETE SOP10100 where BACHNUMB = 'xxx'
    ```

10. In Microsoft Dynamics GP, point to **Maintenance** on the Microsoft Dynamics GP menu, and then select **Check Links**.
11. In the **Series** list, select **Sales**, and then run the check links procedure on the **Sales Work** table group.
12. If the transactions did not post in the Receivables Management module and in the Inventory module, reenter the transactions in the Sales Transaction Entry window.
