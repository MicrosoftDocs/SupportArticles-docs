---
title: Requirements to link orders
description: Discusses how to link an order from Purchase Order Processing to Sales Order Processing in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.
ms.reviewer: theley
ms.date: 04/17/2025
ms.custom: sap:Distribution - Sales Order Processing
---
# Requirements to successfully link orders from Purchase Order Processing to Sales Order Processing

This article discusses how to link an order from **Purchase Order Processing** to **Sales Order Processing** in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 855887

## Introduction

To link a Purchase Order line item to a line item on a Sales Order Processing document, follow these steps:

1. On the **Transactions** menu, point to **Purchasing**, and then select **Purchase Order Entry**.
2. Select the **Purchase Order**.
3. Select the **Allow Sales Documents Commitments** check box.
4. Select the purchase order line item that has to be linked to a **Sales Order**.
5. Select the **Sales Commitments for Purchase Order** icon (Paper with paper clip next to **Quantity Ordered**) to open the **Sales Commitments for Purchase Order** window.
6. Select **Add Sales Doc**.

    > [!NOTE]
    > The **Sales Assignments for Purchase Order** window will list the **Sales Order** document line items that are available to be linked to the **Purchase Order**.

7. In the **Sales Assignments for Purchase Order** window, select the **Sales Order document** line item, and then select the **Select** button.
8. Select **OK**.

## Requirements to link a Purchase Order line item to a Sales Order Document line item

1. The **Allow Sales Documents Commitments** check box is selected in the **Purchase Order Entry** window.
2. Documents in Sales Order Processing that can be linked to a purchase order:

    - **Order**

        The sales line item must have a value in the **Qty to Back Order** field that is less than or equal to the **Quantity Available** in the **Sales Commitments for Purchase Order** window for the PO Line.
    - **Back Order**

        The sales line item must have a value in the **Qty Backordered** field that is less than or equal to the **Quantity Available** in the **Sales Commitments for Purchase Order** window for the PO Line.

3. The following fields must be the same for the Purchase Order line item and the Sales document line item. Which applies to both Inventory and Non-Inventory items and all Purchase order document types:
    - **Item Number**, or **Vendor Item Number** if you're using a Vendor Item Display in Purchase Order Processing Setup
    - **U of M**
    - **Site ID**
4. For **drop-ship** purchase orders, the following special requirements apply:
    - The **Customer ID** assigned to the drop-ship PO must be the same as the **Customer ID** assigned to the sales document.
    - The sales order line item must be marked as **drop-ship**.- The following fields must be the same for the purchase order line item and the sales line item:
        - **Shipping Method**
        - **Ship To Address ID**
        - **The Ship to Address ID address details** can't be edited on either the purchase order line or the sales line item. An indicator is placed next to the Ship to Address ID when the details are changed.  
5. For **Blanket** or **Drop-Ship Blanket** Purchase Orders, the control line item cannot be linked to sales order documents. However, the other blanket items can be linked.
