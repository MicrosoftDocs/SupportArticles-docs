---
title: The Purchasing purchase option for an item does not exist error when transferring requisition to purchase order
description: Describes a problem where you receive an error that the purchase option for an item does not exist in Requisition Management when you transfer a requisition to a purchase order in Microsoft Dynamics GP. Provides a resolution.
ms.reviewer: theley, ppeterso
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "The Purchasing purchase option for an item does not exist" error when you transfer a requisition to a purchase order

This article provides a resolution for the issue that you can't transfer a requisition to a purchase order in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 948799

## Symptoms

When you transfer a requisition to a purchase order, you receive the following error message in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains 8.0:

> Purchase Order Failure  
The Purchasing purchase option for item **XXX** does not exist.

> [!NOTE]
> *XXX* is a placeholder for any item number.

## Cause 1

The case of the value in the **Default Purchasing U of M** field is incorrect. See Resolution 1 in the Resolution section.

## Cause 2

In the Purchase Order Setup window, the value in the **Purchase Orders Code** field does not correspond with the value in the **Purchase Orders Next Number** field. See Resolution 2 in the Resolution section.

## Resolution

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a complete backup copy of the database that you can restore if a problem occurs.

### Resolution 1

1. Verify that a value exists in the **Default Purchasing U of M** field. To do this, follow these steps:

   1. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio. To do this, use one of the following methods depending on the program that you are using.

      Method 1- For SQL Server Desktop Engine

      If you are using SQL Server Desktop Engine (also known as MSDE 2000), start the Support Administrator Console. To do this, select **Start**, point to **All Programs**, point to **Microsoft Administrator Console**, and then select **Support Administrator Console**.

      Method 2 - For SQL Server 2000

      If you are using SQL Server 2000, start SQL Query Analyzer. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server**, and then select **Query Analyzer**.

      Method 3 - For SQL Server 2005

      If you are using SQL Server 2005, start SQL Server Management Studio. To do this, select **Start**, point to **All Programs**, point to **Microsoft SQL Server 2005**, and then select **SQL Server Management Studio**.

   2. Run the following script against your company database.

      ```sql
      SELECT PRCHSUOM, * from IV00101 where ITEMNMBR = '**XXX**'
      ```

      In the above script, replace the placeholder *XXX* with the item number in the error message.

2. Note the value in the **PRCHSUOM** field.
3. In Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains 8.0, on the **Cards** menu point to **Inventory**, and then select **Item**.

4. In the **Item Number** list, select the appropriate item number.
5. Click **Go To**, and then select **Purchasing**.

6. The value in the **Default Purchasing U of M** field is used for requisitions, and should match the value in the **U of M** column in the table. The values are case-sensitive. For example, **Each** and **EACH** do not match.

7. Change the value in the **Default Purchasing U of M** field to match what is displayed in the **U of M** column in the table, and then select **Save**.

    > [!NOTE]
    > You can also start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio and run the following script to update the value in the **Default Purchasing U of M** field for all items:

    ```sql
    UPDATE IV00101 set PRCHSUOM = ' **XXXX** ' where PRCHSUOM = ' **YYYY**'
    ```

    In this script, replace the placeholder *XXXX* with the new value for the **Default Purchasing U of M** field. Replace the placeholder *YYYY* with the value that you noted in step 2.

8. Run the Following script to update the **UnitofMeasure** field for all items in the ReqMgmtLines table:

    ```sql
    UPDATE DYNAMICS..ReqMgmtLines set UnitOfMeasure = ' **XXXX** '
    ```

    In the above script, replace the placeholder *XXXX* with the new value for the **Default Purchasing U of M** field.

### Resolution 2

Verify that the value in the **Purchase Orders Code** field corresponds with the value in the **Purchase Orders Next Number** field. To do this, follow these steps:

1. Follow the appropriate step:

   - In Microsoft Dynamics GP 10.0, on the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Setup**, point to **Purchasing**, and then select **Purchase Order Processing**.
   - In versions earlier than Microsoft Dynamics GP 10.0, on the **Tools** menu, point to **Setup**, point to **Purchasing**, and then select **Purchase Order Processing**.

2. Note the value in the **Purchase Orders Code** field. For example, the value in the **Purchase Orders Code** field might be **PO**.

3. Note the value in the **Purchase Orders Next Number** field. The value in the **Purchase Orders Next Number** field should begin with the value in the **Purchase Orders Code** field. For example, the value in the **Purchase Orders Next Number** field might be **PO1234**.

4. Change a value in either the **Purchase Orders Code** field or the **Purchase Orders Next Number** field so that they correspond.
5. Select **OK**.
