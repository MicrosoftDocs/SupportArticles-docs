---
title: How to set up and use the outsourcing features in Manufacturing
description: Explains how to set up and use the outsourcing features in Manufacturing in Microsoft Dynamics GP and in Microsoft Great Plains.
ms.reviewer: theley, ttorgers
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:Manufacturing Series
---
# How to set up and use the outsourcing features in Manufacturing in Microsoft Dynamics GP and in Microsoft Great Plains

This article describes how to set up and use the outsourcing features in Manufacturing in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 857209

To set up and use the outsourcing features in Manufacturing in Microsoft Dynamics GP and in Microsoft Great Plains, follow these steps:

1. Identify a cost bucket to use for tracking outsourcing costs. To do this, follow these steps:

   1. On the **Tools** menu, point to **Setup**, point to **Manufacturing**, point to **System Defaults**, and then select **WIP** to open the WIP Preference Defaults window.

   2. In the **Cost Bucket Used for Outsourcing Costs** area, select the bucket that you want to use to track outsourcing costs. Generally, this will be one of the buckets that you are not already using for another purpose.

   3. Select the **Rename Selected Cost Bucket as "Outsourcing"** check box.

        > [!NOTE]
        > This step is optional.

   4. Select **OK**.

2. Create an outsourcing work center. To do this, follow these steps:

   1. On the **Cards** menu, point to **Manufacturing**, point to **Work Centers**, and then select **Setup** to open the Work Center Setup window.
   2. In the **Work Center ID** box, type your work center ID.

   3. Select **Add** if you receive the following message:

      > This site ID doesn't exist. Do you want to add it? The Site Maintenance window opens. Add the site information, and then select **Save**.

   4. In the **Outsourced** list, select **Yes**. The Outsourced Work Center Setup window opens.
   5. In the **Vendor ID** box, type your vendor ID.

        > [!NOTE]
        > When you create a purchase order, the vendor ID can be changed.
   6. Select **OK**.

   7. In the **Service Item Number** box, type the number of a service item, or leave the box empty. If you type the number of a service item, you will be able to use the Item Vendor Maintenance window to set a different cost for the service item for each vendor.
   8. In the **PO Release Offset Days** box, type the number of days by which the purchase order for the vendor's services should be offset from the required date for the items.
   9. Select **OK**.
   10. In the Work Center Setup window, type a date in the **Display Date** box. This date will become the effective date for the work center.
   11. Select **OK**.

3. Set up a labor code or a machine ID to track the outsourcing costs. To do this, use one of the following methods.

    Method 1. Set up a labor code

    If you chose a labor bucket in step 1b, you must set up a labor code. To do this, follow these steps:

    1. On the **Cards** menu, point to **Manufacturing**, and then select **Labor Codes** to open the Labor Code Definition window.

    2. In the **Labor Code** box, type your labor code.
    3. In the **Description** box, type the description of your labor code.
    4. In the **Primary Pay Code** list, select the primary pay code for this labor code.
    5. In the **Shop Rate** box, type the shop rate.
    6. If you are using fixed overhead, type information in the **Fixed Overhead** area.
    7. If you are using variable overhead, type information in the **Variable Overhead** area.
    8. In the **Labor Costing Accounts** area, type the account numbers of the applicable accounts.
    9. Select **Save**.

    Method 2. Set up a machine ID

    If you chose a machine bucket in step 1b, you must set up a machine ID. To do this, follow these steps:

    1. On the Cards menu, point to Manufacturing, and then select **Machines** to open the Machine Definition window.

    2. Type information in the following required boxes:
        1. **Machine ID**
        2. **Machine Applied**
    3. In the **Vendor ID** box, type the vendor ID that is associated with the machine ID.
    4. In the **Operating Cost** box, type the cost per hour if applicable.
    5. In the **Piece Cost** box, type the cost per piece if applicable.
    6. If you are using fixed overhead, type information in the **Fixed Overhead** area.
    7. If you are using variable overhead, type information in the **Variable Overhead** area.
    8. In the **Machine Costing Accounts** area, type the account numbers of the applicable accounts.
    9. Select **Save**.

4. Add an outsourced sequence to your existing routing for the applicable finished good. To do this, follow these steps:
  
    1. On the **Cards** menu, point to **Manufacturing**, point to **Routings**, and then select **Routing Entry**.
    2. In the Routing Sequence Entry window, select the applicable item number and routing name.
    3. In the **Sequence Number** box, type a new sequence number.
    4. In the **Description** box, type a description.
    5. In the **Work Center ID** list, select the work center that you created in step 2, and then select **Select**.
    6. In the **Time and Costing** area, type any additional information that is required.
    7. Select **Save**.
    8. Select **OK** if you receive the following message:

       > You might want to update the previous sequence's WIP Output per MO Start Quantity because this sequence is outsourced.

5. Use outsourcing together with a new manufacturing order. To do this, follow these steps:
  
    1. On the **Transactions** menu, point to **Manufacturing**, point to **Manufacturing Orders**, and then select **Entry** to open the Manufacturing Order Entry window.

    2. In the **MO Number** box, accept the default manufacturing order number.
    3. In the **Item Number** box, type the item number for which you created the outsourced sequence in step 4.
    4. Type information in the following required boxes:
          - **Routing Name**
          - **Scheduling Preference**
          - **Ending Quantity**
          - **Draw Inventory From Site**
          - **Post Finished Goods To**
    5. In the **MO Status** list, select **Open**.
    6. In the **Start Date** box, type your start date.
    7. Select **Schedule MO**.
    8. In the **MO Status** list, select **Released**.
    9. In the **Outsourcing** area, select the right arrow button next to Purchasing to open the Manufacturing Order/Purchase Order Link window.
    10. Select the **Outsourced Sequence** check box, and then select **Create PO** to create a purchase order. The Purchase Order Entry window opens.
    11. Select **Save**.
    12. Close the Manufacturing Order/Purchase Order Link window. You are prompted to print the MO/PO Links Report Sort by MO report.
    13. In the **Outsourcing** area, select the right arrow button next to Shipping to open the Manufacturing Order Shipments window. Use this window to record the fact that you have shipped the item to the outsourced vendor.
    14. Select the **Ship From Sequence** check box, and then select **Record Shipment**.
    15. Close the Manufacturing Order Shipments window. You are prompted to print the Manufacturing Shipment Report.
