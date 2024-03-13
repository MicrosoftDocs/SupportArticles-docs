---
title: This Manufacturing Order has a Pending Component Transaction error when closing manufacturing order
description: Describes a problem in which you receive an error message when you try to close a complete manufacturing order in the Manufacturing Order Close window or the Edit Manufacturing Order Status window in Microsoft Dynamics GP.
ms.reviewer: beckyber
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "This Manufacturing Order has a Pending Component Transaction" error when closing a manufacturing order

This article provides methods for you to solve the error message that occurs when you try to close a manufacturing order in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 953438

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

## Symptoms

When you try to close a complete manufacturing order in the Manufacturing Order Close window or the Edit Manufacturing Order Status window in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains, you receive the following error message:

> This Manufacturing Order has a Pending Component Transaction. See picking document XXXXX for more information.

> [!NOTE]
> *XXXXXX* is a placeholder for the picking document number.

## Cause

This problem can occur for one of the following reasons:

- Saved, unposted picking documents exist for the manufacturing order (MO). See Resolution 1.
- The MOP1400 (MOP_Picklist_Site_QTY) table has pending quantities that are unsupported by data in other manufacturing tables. See Resolution 2.

## Resolution 1

To resolve this problem, use an SQL query tool to find and post unposted picking documents. To do this, follow these steps:

1. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio. To do this, use one of the following methods depending on the program that you are using.

    - Method 1 - For SQL Server Desktop Engine

      If you are using SQL Server Desktop Engine (also known as MSDE 2000), start the Support Administrator Console. To do this, select **Start**, point to **All Programs**, point to **Microsoft Administrator Console**, and then select **Support Administrator Console**.

    - Method 2 - For SQL Server 2000

      If you are using SQL Server 2000, start SQL Query Analyzer. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.

    - Method 3 - For SQL Server 2005

      If you are using SQL Server 2005, start SQL Server Management Studio. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.

2. Run the following script against the company database:

    ```sql
    Select PICKNUMBER from MOP1210 where MANUFACTUREORDER_I = 'XXXX'
    and MANUFACTUREORDER_I in (select MANUFACTUREORDER_I from MOP1400 
    where MANUFACTUREORDER_I in (select MANUFACTUREORDER_I where PENDING_REV_ISS_QTY_I > 0 
    or PENDING_ISSUE_QTY_I > 0 or PENDING_SCRAP_QTY_I > 0 or PENDING_REV_SCRAP_QTY_I > 0))
    and TRX_TYPE in (1,2,5,6) and PICKNUMBER in (select PICKNUMBER from MOP1200 where POSTED = 0)
    ```

    > [!NOTE]
    > In this script, you must replace the *XXXX* placeholder with the manufacturing order number.

3. Results that the script in step 2 returns indicate that an unposted picking document exists. To post the picking document or remove the items from the picking document, follow these steps:

   1. On the **Transactions** menu, point to **Manufacturing**, point to **Manufacturing Orders**, and then select **Component Trx Entry**.
   2. In the **Manufacture Pick Number** list, select the pick document number from step 2.
   3. Follow one of these steps:
      - If you want to post the items, select **Mark All**, and then select **Post**.
      - If you do not want to post the items, select the check box next to each item number, select **Edit**, and then select **Delete Row**.

        > [!NOTE]
        > If all items are removed from the pick document, you do not have to post the pick document.

## Resolution 2

The MOP1400 table may hold a pending quantity for a picking document even if there are no pending documents. To resolve this problem, use an SQL query tool to update the MOP1400 table. To do this, follow these steps:

1. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio. To do this, use one of the following methods depending on the program that you are using.

    - Method 1 - For SQL Server Desktop Engine

      If you are using SQL Server Desktop Engine (also known as MSDE 2000), start the Support Administrator Console. To do this, select **Start**, point to **All Programs**, point to **Microsoft Administrator Console**, and then select **Support Administrator Console**.

    - Method 2 - For SQL Server 2000

      If you are using SQL Server 2000, start SQL Query Analyzer. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.

    - Method 3 - For SQL Server 2005

      If you are using SQL Server 2005, start SQL Server Management Studio. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.

2. Run the following scripts against the company database:

    ```sql
    select PENDING_ISSUE_QTY_I, MANUFACTUREORDER_I from MOP1400 where PENDING_ISSUE_QTY_I > 0 and MANUFACTUREORDER_I = 'MOxxx' 
    select PENDING_REV_ISS_QTY_I, MANUFACTUREORDER_I from MOP1400 where PENDING_REV_ISS_QTY_I > 0 and MANUFACTUREORDER_I = 'MOxxx' 
    select PENDING_SCRAP_QTY_I, MANUFACTUREORDER_I from MOP1400 where PENDING_SCRAP_QTY_I > 0 and MANUFACTUREORDER_I = 'MOxxx' 
    select PENDING_REV_SCRAP_QTY_I, MANUFACTUREORDER_I from MOP1400 where PENDING_REV_SCRAP_QTY_I > 0 and MANUFACTUREORDER_I = 'MOxxx'
    ```

    > [!NOTE]
    > In this script, you must replace the *MOxxx* placeholder with the manufacturing order number.

3. Results that are returned from the script in step 2 indicate that the MOP1400 table must be updated. Run the following scripts against the company database:

    ```sql
    update MOP1400 set PENDING_ISSUE_QTY_I = 0 where PENDING_ISSUE_QTY_I > 0 and MANUFACTUREORDER_I = 'xxxx' 
    update MOP1400 set PENDING_REV_ISS_QTY_I = 0 where PENDING_REV_ISS_QTY_I > 0 and MANUFACTUREORDER_I = 'xxxx'
    update MOP1400 set PENDING_SCRAP_QTY_I = 0 where PENDING_SCRAP_QTY_I > 0 and MANUFACTUREORDER_I = 'xxxx' 
    update MOP1400 set PENDING_REV_SCRAP_QTY_I = 0 where PENDING_REV_SCRAP_QTY_I > 0 and MANUFACTUREORDER_I = 'xxxx' 
    ```

    > [!NOTE]
    > In this script, you must replace the *xxxx* placeholder with the manufacturing order number.
