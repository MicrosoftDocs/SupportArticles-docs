---
title: Enter and view the shipping history for inventory items in Microsoft Dynamics GP Manufacturing
description: Contains information about how to enter and view the shipping history including tracking numbers and BOL numbers for inventory items in Manufacturing of Microsoft Dynamics GP.
ms.reviewer: theley, aeckman
ms.topic: how-to
ms.date: 03/13/2024
ms.custom: sap:Distribution - Inventory
---
# How to enter and view the shipping history for inventory items in Microsoft Dynamics GP Manufacturing

This article describes how to enter and view the shipping history for inventory items in Microsoft Dynamics GP Manufacturing. Shipping history includes information such as tracking numbers, Bill of Lading (BOL) numbers, and the number of boxes for each line item of a sales order.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 949166

> [!NOTE]
> Before you enter the shipping history for an item, you must use a separate fufillment method for sales order processing. This method depends on your type ID.

## Enter the shipping history

To enter the shipping history for an item, follow these steps:

1. Set the item to maintain the shipping history by following these steps:
    1. On the **Cards** menu, point to **Inventory**, and then click **Item**.
    1. In the Item Maintenance window, select the item for which you want to track the shipping history in the **Item Number** field, click **Go To** > **Fulfillment Detail**.
    1. In the Fulfillment Detail window, select the **Maintain Shipping History** check box, and then click **OK**.
2. Create an order type ID that's set to use a separate fulfillment process. To do it, follow the steps for the product that you're using.

    **Microsoft Business Solutions - Great Plains 8.0 and Microsoft Dynamics GP 9.0**

    1. On the **Tools** menu, point to **Setup** > **Sales**, and then click **Sales Order Processing**.
    1. Click **Order**.
    1. In the Sales Order Setup window, enter a name for the order type ID in the **Order ID** field.
    1. In the **Allocate by** list, select **Document/Batch**.
    1. In the **Use Fulfillment Order/Invoice ID** field, select a sales type ID that has the Invoice type.
    1. In the **Options** section, select the **Use Separate Fulfillment Process** check box.
    1. Click **Save**.

    **Microsoft Dynamics GP 10.0**

    1. On the **Microsoft Dynamics GP** menu, point to **Tools** > **Setup** > **Sales**, and then click **Sales Order Processing**.
    1. Click **Sales Document Setup** > **Order**.
    1. In the Sales Order Setup window, enter a name for the order type ID in the **Order ID** field.
    1. In the **Allocate by** list, select **Document/Batch**.
    1. In the **Use Fulfillment Order/Invoice ID** field, select a sales type ID that has the Invoice type.
    1. In the **Options** section, select the **Use Separate Fulfillment Process** check box.
    1. Click **Save**.

3. Create a sales order by using the order type ID that you created in step 2.
    1. On the **Transactions** menu, point to **Sales**, and then click **Sales Transaction Entry**.
    1. In the Sales Transaction Entry window, select **Order** in the **Type/Type ID** field, and then select the order type ID in the field that is next to the **Type/Type ID** field.
    1. Tab through the **Document No.** field, and then note the document number that automatically appears.
    1. In the **Customer Name** field, select a customer name.
    1. In the **Batch ID** field, enter a new batch ID, and then press TAB.
    1. Click **Add** when you receive the following message:
        Do you want to add this batch?
    1. Click **Save**.
    1. In the **Item Number** field, select the same item number that you selected in step 1.
    1. In the **U of M** field, leave the default. If no default option is selected, select an option, and then press TAB.
    1. In the **Qty Ordered** field, enter *2*, and then tab through the line.
    1. In the Sales Transaction Entry window, click the **Options** menu, and then click **Allocate or Fulfill**.
    1. Click to select the **Allocate** check box, and then click **OK**.
    1. Click **Save**, and then exit the Sales Transaction Entry window.

4. Fulfill the order by using the separate fulfillment method by following these steps:
    1. On the **Transactions** menu, point to **Sales**, and then click **Order Fulfillment**.
    1. In the Sales Order Fulfillment window, enter the document number in the **Doc. Number** field.
    1. In the **Qty Fulfilled** field, enter the quantity, and then press TAB.
        The Fulfillment History Entry window opens.
    1. In the Fulfillment History Entry window, specify the following fields:
    **Date/Time**  
        - **Shipping Method**  
        - **Shipping BOL**  
        - **Weight**  
        - **No. Packages**  
        - **UPS Zone**  
        - **FOB**  
        - **Fulfilled by**  
        - **Variable U of M of Purchasing**  
    1. Click **OK**.
    1. In the Sales Order Fulfillment window, click **Save** to process the request.

## View the shipping history before the invoice is posted

> [!NOTE]
> You can only see the shipping history on orders or on invoices before the invoice document is posted. If the invoice has been posted, you can't see the shipping history.

To view the shipping history before the invoice is posted, open the Order Fulfillment History window. To do it, follow the steps for the product that you're using.

### Microsoft Business Solutions - Great Plains 8.0 and Microsoft Dynamics GP 9.0

1. On the **Transactions** menu, point to **Sales**, and then click **Sales Transactions Entry**.
2. In the Sales Transactions Entry window, select **Invoice** or **Order** in the **Type/Type ID** field.
3. In the **Document No.** field, select the invoice or the order that you want.
4. On the **Extras** menu, point to **Additional**, and then click **Order Fulfillment History**.

    > [!NOTE]
    > The Extras window is unavailable when you view the historical SOP transactions.

### Microsoft Dynamics GP 10.0

1. On the **Transactions** menu, point to **Sales**, and then click **Sales Transactions Entry**.
2. In the Sales Transactions Entry window, select **Invoice** or **Order** in the **Type/Type ID** field.
3. In the **Document No.** field, select the invoice or the order that you want.
4. On the **Additional** menu, click **Order Fulfillment History**.

## View the information for shipping historical transactions

To view the information for shipping historical transactions, you must read directly from the IS010210 table. This table stores the shipping history information for both the outstanding transactions and the historical SOP transactions.

To find the data in the IS010210 table before and after the posting process is complete, use one of the following options.

### Option 1: Run a statement by using SQL Server

1. Start the Support Administrator Console, Microsoft SQL Query Analyzer, or SQL Server Management Studio. Use the method for the program that you're using.
   - For SQL Server Desktop Engine (also known as MSDE 2000), start the Support Administrator Console. To do it, click **Start**, point to **All Programs** > **Microsoft Administrator Console**, and then click **Support Administrator Console**.
   - For SQL Server 2000, start SQL Query Analyzer. To do it, click **Start**, point to **All Programs** > **Microsoft SQL Server**, and then click **Query Analyzer**.
   - For SQL Server 2005, start SQL Server Management Studio. To do it, click **Start**, point to **All Programs** > **Microsoft SQL Server 2005**, and then click **SQL Server Management Studio**.
2. Run the following statement against the company database:

    ```console
    SELECT * FROM IS010210
    ```

    > [!NOTE]
    > You can modify your script to return the information that you want to see. This table lists both orders and invoices. This table also lists both unposted data and posted data.

### Option 2: Create a custom report

Use Report Writer to create a custom report. Note, however, that this option is outside the scope of technical support.

For more information about how to create a custom report, contact your MBS Partner or your MBS Professional.

### Option 3: Use SmartList Builder

Use SmartList Builder to create a SmartList object to display the data.

For more information about how to create a custom report in SmartList Builder or for a quote, contact your MBS Partner or your MBS Professional.
