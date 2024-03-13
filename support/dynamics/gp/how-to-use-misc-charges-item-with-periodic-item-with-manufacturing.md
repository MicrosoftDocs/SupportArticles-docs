---
title: How to use Misc Charges item with Periodic item
description: The article describes how to use a Misc Charges item with Microsoft Dynamics GP Manufacturing so it will process correctly with the correct accounts.
ms.reviewer: BeckyBer
ms.topic: how-to
ms.date: 03/13/2024
---
# How to use a Misc Charges item with a Periodic item (Standard Cost) with Microsoft Dynamics GP Manufacturing

The article describes how to use a Misc Charges item with Microsoft Dynamics GP Manufacturing so it will process correctly with the correct accounts. The same can be done with Service or Flat Fee items.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2217082

## Step By Step

To set up a Misc Charges item with Microsoft Dynamics GP Manufacturing, follow these steps:

1. You first have to use SQL Query Analyzer to update the correct Valuation Method on the Misc Charges item: You cannot add a Misc Charges item to a Periodic (Standard Cost) Bill of Materials. Make sure you have a good functional backup before using SQL to update any table.Valuation Method Values are the following:

    Null (Item does not track costs) = 0  
    FIFO Perpetual = 1  
    LIFO Perpetual = 2  
    Average Perpetual = 3  
    FIFO Periodic = 4  
    LIFO Periodic = 5

    1. Depending on the version of Microsoft SQL Server that you use, start SQL Server Management Studio, or start SQL Query Analyzer. To do this, use one of the following steps:

        - If you are using SQL Server 2005, open SQL Server Management Studio. To do this, select **Start**, point to **Programs**, point to Microsoft SQL Server 2005, and then select **SQL Server Management Studio**.

        - If you are using SQL Server 2000 or SQL Server 7.0, open SQL Query Analyzer. To do this, select **Start**, point to **Programs**, point to Microsoft SQL Server, and then select **Query Analyzer**.

    2. Use one of the following steps:

        - In SQL Server Management Studio, expand **Databases** in Object Explorer, and then select **Dynamics**. select **New Query**, type the following select statements in the query pane, and then select Execute. You will have to provide the Misc Charges item in the first script to get the correct DEX_ROW_D for the second update script.

        ```sql
        SELECT * FROM IV00101 where ITEMNMBR='MISC CHARGES ITEM'

        UPDATE IV00101 SET VCTNMTHD ='4' where DEX_ROW_ID ='<XXX>"
        ```

        - In SQL Query Analyzer, type the following select statement in the Query pane, and then select **Execute**.

        ```sql
        SELECT * FROM IV00101 where ITEMNMBR='MISC CHARGES ITEM'

        UPDATE IV00101 SET VCTNMTHD ='4' where DEX_ROW_ID ='<XXX>"
        ```

        When you update the item to set the `VCTNMTHD ='4'`, it also will add a record to the ICIV0323 and CT00003 tables.

        These are required for standard cost items in order to Rollup and revalue them correct. If the items are imported, it is necessary to check the Standard Cost tables.

2. The next step is to add cost to your Misc Charges item. Make sure you only have Cost in the Material cost bucket only!

    Method 1: Use the **Roll Up and Revalue Inventory** dialog box

    1. Enter the revalued costs in the **Standard Item Material Costs** dialog box or in the **Standard Cost Maintenance** dialog box.

        > [!NOTE]
        > You can use the **Standard Item Material Costs** dialog box to revalue items that have the Replenishment Method field set to **Buy**. You can use the **Standard Cost Maintenance** dialog box to revalue items that have the Replenishment Method field set to **Buy** or to **Make**.

        - To enter the revalued costs in the **Standard Item Material Costs** dialog box, follow these steps:

          1. Select **Cards**, point to **Manufacturing**, point to **Inventory**, and then select **Std Item Mat Costs**.
          2. In the **Standard Item Material Costs** dialog box, enter the revalued costs for the item in the **Pending** area, and then select **Save**.

        - To enter the revalued costs in the **Standard Cost Maintenance** dialog box, follow these steps:

          1. Select **Cards**, point to **Manufacturing**, point to **Inventory**, and then select **Std Cost Maintenance**.
          2. Select the **Override** check box.
          3. In the **Override Standard** area, enter the revalued costs for the item, and then select Save.

    2. Select **Tools**, point to Routines, point to **Manufacturing**, and then select **Rollup** and **Revalue**.
    3. Type a date in the **Roll up Date** Field or leave the today's default date.
    4. Select **Roll up**, and then select **Process**.
    5. When you receive the following message, select **OK**:

       > Rollup Complete.
    6. When you are prompted to print the Item Cost Revaluation Report, select a print destination, and then select **ok**. Make sure the costs are correct on the report.

    7. Select **Revalue**, and then select **Process**.
    8. When you receive the following message, select **OK**.

       > A standard cost revaluation batch was created. Standard unit cost changes will take effect.

    Method 2: Use the **Standard Cost Changes** dialog box

    1. Select **Cards**, point to **Manufacturing**, point to **Inventory**, and then select **Standard Cost Changes**.

    2. Enter the revalued costs for the item in the **Proposed Standard Cost** column, and then select **Save**.

3. In the **Standard Cost Changes** dialog box, select **Roll Up**.
4. When you are prompted to save changes, select **Save**.
5. When you receive the following message, select **OK**:
   > Rollup Complete
6. When you are prompted to print the Item Cost Revaluation Report, select a print destination, and then select **ok**. Make sure the costs are correct on the report.
7. In the **Standard Cost Changes** dialog box, select **Replace Costs**.
8. When you receive the following message, select **OK**.

   > A standard cost revaluation batch was created. Standard unit cost changes will take effect.

9. When you receive the following message, select **OK**:

   > All proposed costs have been deleted

When the Standard Cost is changed and revalued, go to the Item Maintenance window and make sure the Current Cost is equal to the new Standard Cost.

In the future if you change the Standard Cost the Current Cost has to be updated to be equal to the new Standard Cost.
