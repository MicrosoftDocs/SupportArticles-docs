---
title: One or more line items contain warnings
description: Provides a solution to an error that occurs when you print the SOP Posting Journal report or the Sales Edit List report in Microsoft Dynamics GP.
ms.reviewer: theley, ppeterso
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Distribution - Sales Order Processing
---
# "One or more line items contain warnings or errors" Error message when you print the SOP Posting Journal report or the Sales Edit List report in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you print the SOP Posting Journal report or the Sales Edit List report in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 943954

## Symptoms

When you print the SOP Posting Journal report or the Sales Edit List report in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains, you receive the following error message:

> One or more line items contain warnings or errors.

This problem occurs even if the following conditions are true:

- Valid posting accounts exist in the Sales Line Distribution Entry window for the cost of goods sold account and for the inventory account.
- The Reconcile Sales Documents procedure has been performed.
- The Inventory Reconcile Quantities procedure has been performed.
- The Check Links procedure has been performed.
- You've transferred the transactions in the batch to a new batch.

## Cause

This problem occurs when invalid values exist in one or more fields in the SOP10200 table.

## Resolution

To resolve this problem, follow these steps.

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

1. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio. To do it, use one of the following methods depending on the program that you're using.

    - Method 1: For SQL Server Desktop Engine

        If you're using SQL Server Desktop Engine (also known as MSDE 2000), start the Support Administrator Console. To do it, select **Start**, point to **All Programs**, point to **Microsoft Administrator Console**, and then select **Support Administrator Console**.

    - Method 2: For SQL Server 2000

        If you're using SQL Server 2000, start SQL Query Analyzer. To do it, select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.

    - Method 3: For SQL Server 2005
  
        If you're using SQL Server 2005, start SQL Server Management Studio. To do it, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.  

2. Run the appropriate statement against the company database. For one transaction, run the following statement:

    ```sql
    SELECT SOPLNERR, * FROM SOP10200 where SOPNUMBE = '<xxx>'
    ```

    For a range of transactions, run the following statement:

    ```sql
    SELECT SOPLNERR, * FROM SOP10200 where SOPNUMBE BETWEEN '<xxx>' and '<xxx>'
    ```

    > [!NOTE]
    > In each statement, replace the *\<xxx>* placeholder with a document number.

3. Note the value in the SOPLNERR field, and then compare it to the following values.

    |Value|Description|
    |---|---|
    |1|The master record for the item doesn't exist.|
    |2|The site record for the item doesn't exist.|
    |3|The serial numbers and the extended quantity of the item don't balance.|
    |4|The lot quantities and the extended quantity of an item don't balance.|
    |5|The serial number already exists for this item in the serial number file.|
    |6|The serial number is missing for the item and for the site in the serial number file.|
    |7|The lot number is missing for this item and for this site in the lot number file.|
    |8|The line accounts are missing or invalid.|
    |9|The returned quantities weren't distributed correctly.|
    |10|The lot number already exists for the item in the lot number file.|
    |11|The intrastate information is missing or invalid.|
    |12|The line quantity is zero.|
    |13|A severe error occurred while the program was adjusting the inventory. Revert to a backup if you can do it.|
    |14|The line quantity isn't distributed.|
    |15|A part of the line quantity is backordered.|
    |16|The line quantity isn't correctly allocated.|
    |17|The line quantity isn't correctly fulfilled.|

4. Determine whether the errors are valid. Make corrections as appropriate. For example, if the value in the SOPLNERR field is **2**, follow these steps:

    1. On the **Cards** menu, point to **Inventory**, and then select **Quantities/Sites**.
    2. In the **Item Number** list, select an item.
    3. In the **Site Lookup** area, select **All**.
    4. In the **Sites** area, select **Site ID**.
    5. In the **Sites** list, select a site.
    6. Select **Save**.
