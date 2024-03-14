---
title: This vendor has been assigned to a PO
description: Provides a solution to an error that occurs when you try to inactivate a vendor in the Vendor Maintenance window.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Financial - Payables Management
---
# "This vendor has been assigned to a purchase order or unposted receipt. The status can't be changed to Inactive." Error message when you inactivate a vendor in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you try to inactivate a vendor in the Vendor Maintenance window.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2601436

## Symptoms

When you try to inactivate a vendor in the Vendor Maintenance window, the following message appears:

> "This vendor has been assigned to a purchase order or unposted receipt. The status can't be changed to Inactive."

## Cause

The Vendor has open purchase orders that need to be received or open receipts that need to be posted so the purchase orders can be closed.  

### Cause 1

Check to see if there are open purchase orders for the vendor by doing the following steps:

1. Open the Purchase Order Processing Document Inquiry window: Select **Inquiry**, point to **Purchasing**, select **Purchase Order Documents**.

1. Enter the Vendor ID that you want to inactivate in the Vendors section

1. Documents set to PO Number, mark to include: Open Purchase Orders and Receipts Received select **Redisplay**.

1. It will show if the vendor has open Purchase Orders.

### Cause 2

Check to see if there are unposted receipts for the vendor by doing the following steps:

1. Open the Purchase Order Processing Document Inquiry window: Select **Inquiry**, point to **Purchasing**, select **Purchase Order Documents**.

1. Enter the Vendor ID in the Vendors section, choose Receipt Number on the Documents section, mark Unposted Receipts and Assigned PO and select **Redisplay**.

1. You'll see open POs where there Receipts haven't been posted.

> [!NOTE]
> Make sure that there isn't a Shipment or Shipment/Invoice that has a Work Receipt.

## Resolution

*RESOLUTION 1*  
If open purchase orders exist receive and invoice the purchase order as needed by going through the following steps:

1. Open the Receivings Transaction Entry window: Select **Transactions**, point to **Purchasing**, select **Receivings Transaction Entry**.

2. Select a Shipment and the Vendor you would like to receive the purchase order against.

    > [!NOTE]
    > You can also select **Shipment/Invoice** and then skip steps 5-7 below.

3. On the line for PO Number, pull up the open purchase order in question and enter the line items that are on the purchase order onto this Shipment/Invoice for receiving.

4. Select **Post**. It will process the Receivings Transaction. Now the purchase order will have a Received status.

5. Next, create an Invoice in Purchase Invoice Entry: Select **Transactions**, point to **Purchasing**, select **Enter/Match Invoice**. Let the Receipt Number default in. Enter the Vendor Doc. Number for Payables Management and enter the Vendor ID for the purchase order we just received against.

    > [!NOTE]
    > If you don't want to invoice the purchase order, you can go to Edit Purchase Order Status window: Select **Transactions**, point to **Purchasing**, select **Edit Purchase Orders**, pull up the purchase order and close the purchase order manually.

6. Enter the PO Number on the line and the line items related.

7. Select **Post**. It will process the Purchase Invoice. Now the purchase order will have a Closed status.

8. Once the purchase order is closed, you can move the purchase order to history in the Remove Completed Purchase Orders window: Select **Microsoft Dynamics GP** menu, point to **Tools**, point to **Routines**, point to **Purchasing**, select **Remove Completed Purchase Orders**.

After doing these steps you can then inactive the Vendor by selecting **Cards**, then **Purchasing** and then select **Vendor** to change the status drop-down from Active to Inactive.

*RESOLUTION 2*  
If unposted receipts exist post the receipts by following the steps below:

1. Open the Receiving Transaction Entry window: Select **Transactions**, point to **Purchasing**, select **Receivings Transaction Entry**.

2. Select the **Lookup** button next to **Receipt No.** It will display the unposted receipts.

3. Choose the receipt that hasn't been posted.

4. Make sure everything is correct and then select **Post**.

5. Repeat this same step for any unposted invoices in the Purchasing Invoice Entry window: Select **Transactions**, point to **Purchasing**, select **Enter/Match Invoices**.

After doing these steps you can then inactive the Vendor by selecting **Cards**, then **Purchasing** and then select **Vendor** to change the status drop-down from Active to Inactive.
