---
title: This document has been posted 
description: Provides a solution to an error that occurs when you try to enter an unposted sales document in the Sales Transaction Entry window in Microsoft Dynamics GP.
ms.reviewer:
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "This document has been posted" Error message when you try to enter an unposted sales document in the Sales Transaction Entry window in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you try to enter an unposted sales document in the Sales Transaction Entry window in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2433102

## Symptoms

When you try to enter an unposted sales document in the Sales Transaction Entry window in Sales Order Processing in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains, you may receive the following error message:

> This document has been posted

## Cause

This problem may occur when records were incorrectly updated in the SOP10100 table or when the record was incorrectly removed from the SOP10100 table after the record was posted.

## Resolution

To resolve this problem, use an SQL query tool to discover why the document is displayed as posted. To do this, follow these steps:

1. Make a backup of your current database.
2. Have all users exit Microsoft Dynamics GP.
3. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio. To do it, use one of the following methods, depending on the program that you're using.

    **Method 1**: For SQL Server Desktop Engine

    If you're using SQL Server Desktop Engine (also known as MSDE 2000), start the Support Administrator Console. To do it, select **Start**, point to **All Programs**, point to **Microsoft Administrator Console**, and then select **Support Administrator Console**.

    **Method 2**: For SQL Server 2000

    If you're using SQL Server 2000, start SQL Query Analyzer. To do it, select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.

    **Method 3**: For SQL Server 2005  

    If you're using SQL Server 2005, start SQL Server Management Studio. To do it, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.

4. Run the following script against the company database:

    ```sql
    select a.SOPNUMBE, a.SOPTYPE from
    SOP10100 a, SOP30200 b where a.SOPNUMBE = b.SOPNUMBE and a.SOPTYPE = b.SOPTYPE
    ```

    If this script returns results, you have duplicate records in your Sales Transaction Work and Sales Transactions History tables.

5. Run the following script against the company database:

    ```sql
    Select PSTGSTUS, BCHSOURC, VOIDSTTS,TRXSORCE, DEX_ROW_ID * from SOP10100 where SOPNUMBE = 'Enter your SOP Document number with issue'
    ```

6. > [!NOTE]
   > The Dex_Row_ID value.
7. Check values in the following columns for the SOP Document. If any of these values are incorrect, the document may appear as posted.

    PSTGSTUS (For an unposted document, it should read "0.")  
    BCHSOURC (For an unposted document, it should read "Sales Entry.")  
    VOIDSTTS (For an unposted document, it should read "0.")  
    TRXSORCE (For an unposted document, it should be blank.)
8. Run the following scripts against the company database to correct any of the four values from step 6:

    ```sql
    Update SOP10100 set PSTGSTUS = '0' where DEX_ROW_ID = '*XXXX*'
    Update SOP10100 set BCHSOURC = 'Sales Entry' where DEX_ROW_ID = '*XXXX*'
    Update SOP10100 set VOIDSTTS = '0' where DEX_ROW_ID = '*XXXX*'
    Update SOP10100 set TRXSORCE = ' ' where DEX_ROW_ID = '*XXXX*'
    ```

    > [!NOTE]
    > In this script, the placeholder *XXXX* represents the Dex_Row_ID number for step 5.
9. On the **Transactions** menu, point to **Sales**, point to **Sales Transaction Entry**, and then accurately type the document number in question.
