---
title: POP Back Ordered Items Received report
description: Describes the Back Ordered Items Received report in Microsoft Dynamics GP.
ms.reviewer: theley
ms.date: 03/20/2024
ms.custom: sap:Distribution - Purchase Order Processing
---
# POP Back Ordered Items Received report in Microsoft Dynamics GP

This article describes the Back Ordered Items Received report in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4132667

## The Back-ordered items received report is coming up empty

The items have been received and aren't given and should be showing on the report.

The Back Ordered Items Received Report shows items that you've received from vendors (after posting a shipment) and are back-ordered in Sales Order Processing. This report indicates which items were received and which customers have requested the item via back order. The reason why you aren't seeing any information on the report is because you've already posted the receipt when you receive the committed PO.

The only time that you can see information from this report is when you save the Receipt (Receivings Transaction Entry) into a batch first before posting. If you post the receipt, the Back Ordered Items Received Report will be part of your posting journal reports.

The back ordered items received report shows items on a backorder that have already been transferred to an Order by an increase adjustment in Inventory.

If you need to see the back ordered quantities before you post the shipment receipt, you can print the PO Analysis report.  The PO Analysis report will show basically the same thing at one time, but it will only show for Shipments that are saved in a batch.

## Can reprint the Back-Ordered Items Received Report?

You can reprint the unposted Back-Ordered Items Received Report by going to **Reports**>> **Purchasing**>> **Analysis**>> **Back-Ordered Items Received**. This report shows items received from vendors and is back-ordered in Sales Order Processing. You can print the Back-Ordered Items Received Report for posted transactions as part of the posting process in the Receivings Transaction Entry window or for unposted receipts using the report window. This report can't be printed after the shipment or shipment/invoice batch is posted.

This report only shows the orders that have a back-ordered qty and there's an unposted (or saved) receipt in POP. Once the item has been received in and the back ordered items received report is either printed or the option to cancel the printing of the report is complete, the report is no longer available.  This report can't be reprinted. The reason that the report isn't available is that the quantities are no longer backordered. This report is only generated at the time of receiving the items as it is essentially a transfer from backorder to available quantities.

The only option to get the report to print would be to restore to a point prior to printing the report so the items can be received in again.

## Is there a way that you can see all orders that have any PO commitments?

The only way to view the documents with PO commitment is through Inquiry >> Sales >> Sales Items >> Document Number link >> Purchasing button. You can restrict your search by selecting a range by document type, Item Number, and Document number.
