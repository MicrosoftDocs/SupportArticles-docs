---
title: Documents reference the same master number
description: Provides a solution to an issue where multiple customers have documents that reference the same master number in Sales Order Processing in Microsoft Dynamics GP.
ms.reviewer: theley, ppeterso
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Distribution - Sales Order Processing
---
# Multiple customers have documents that reference the same master number in Sales Order Processing in Microsoft Dynamics GP

This article provides a solution to an issue where multiple customers have documents that reference the same master number in Sales Order Processing in Microsoft Dynamics GP.

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 856311

## Symptoms

Multiple customers have documents that reference the same master number in Sales Order Processing in Microsoft Dynamics GP.

## Resolution

To resolve this problem, follow these steps:

1. Run the check links procedure. To do it, follow these steps:
    1. On the **File** menu, point to **Maintenance**, and then select **Check Links**.
    2. In the **Series** list, select **Sales**.
    3. Select **Sales Setup**, select **Insert**, and then select **OK**.
    4. When you're prompted to print the Error Log report, select a destination.
2. If you still experience the problem after you run the check links procedure, run the statements below against the company database to find the master numbers with the problem. To do it, follow these steps:
    1. If you're using Microsoft SQL Server 2005, start SQL Server Management Studio. To do it, select
    **Start**, point to **Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.
    2. If you're using Microsoft SQL Server 2008, start SQL Server Management Studio. To do it, select
    **Start**, point to **Programs**, point to **Microsoft SQL Server 2008**, and then select **SQL Server Management Studio**.
    3. To search the documents that are open and to note the results, run the following statements against the company database.

        ```sql
        SELECT * INTO MSTRNMBRWORK from SOP10100
        SELECT h.MSTRNUMB, h.CUSTNMBR from MSTRNMBRWORK w, SOP10100 h where
        
                          w.MSTRNUMB = h.MSTRNUMB AND
        
                          W. CUSTNMBR <> h.CUSTNMBR
        ```

    4. To search the History documents and to note the results, run the following statements against the company database.

        ```sql
        SELECT * INTO MSTRNMBRHIST from SOP30200
        Select h.MSTRNUMB, h.CUSTNMBR from MSTRNMBRHIST w, SOP30200 h where
        
                          w.MSTRNUMB = h.MSTRNUMB AND
        
                          w. CUSTNMBR <> h.CUSTNMBR
        ```

    5. Search the Work documents and the History documents and note the results. To fix this problem, run the following cmdlets:

        ```sql
        SELECT h.MSTRNUMB, h.CUSTNMBR from SOP10100 w, SOP30200 h where
        
                          w.MSTRNUMB = h.MSTRNUMB AND
                          w. CUSTNMBR <> h.CUSTNMBR
        ```

    6. To delete the temporary tables that were created in the previous steps, run the following statements against the company database.

        ```sql
        DROP TABLE MSTRNMBRWORK
        
        DROP TABLE MSTRNMBRHIST
        ```

3. The results of the statements in step 2 provide the problematic master numbers. Follow these steps to correct the problematic master numbers:

    1. To determine the maximum value of the master number in the Sales Master Number Setup table, run the following statement against the company database, and note the results.

        ```sql
        SELECT MAX(MSTRNUMB)FROM SOP40500
        ```

    2. To find the transactions that share a master number between two customers, run the following statement against the company database, and note the results. The transactions exist in the work table or in the history table.

        ```sql
        SELECT MSTRNUMB, DEX_ROW_ID, * FROM SOP10100 where MSTRNUMB=xx

        SELECT MSTRNUMB, DEX_ROW_ID, * FROM SOP30200 where MSTRNUMB=xx
        ```

        > [!NOTE]
        > Replace xx by using the problematic master numbers that you noted in step 2.
    3. Run statements to update the transactions for one customer and to reflect a new unique master number. When you run the statements, use the results from steps 3a and 3b. You may have to update multiple records. For example, you may have to update an order and an invoice.

        - If the transaction is in Work, run the following statement.

            ```sql
            UPDATE SOP10100 SET MSTRNUMB=XXXX WHERE DEX_ROW_ID=Y
            ```

            > [!NOTE]
            > Replace XXXX by using a number that is equal to the maximum value of the master number plus 1. The maximum value of the master number was noted in step 3a. Replace Y with the correct DEX_ROW_ID value that you noted in step 3b.

        - If the transaction is in History, run the following statement.

            ```sql
            UPDATE SOP30200 SET MSTRNUMB=XXXX WHERE DEX_ROW_ID=Y
            ```

            > [!NOTE]
            > Replace XXXX by using a number that is equal to the maximum value of the master number plus 1. The maximum value of the master number was noted in step 3a. Replace Y with the correct DEX_ROW_ID value that you noted in step 3b.
4. Run the script in step 3a again to determine the new maximum value of the master number.
5. On the **Tools** menu, point to **Setup**, point to **Sales**, and then select **Sales Order Processing**. Type a number in the **Next Master Number** field. Type a number that is equal to the new maximum value of the master number plus 2. The new maximum value of the master number was determined in step 4.
