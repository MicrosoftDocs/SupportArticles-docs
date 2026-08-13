---
title: Summary Update Error Blocks Direct Delivery Invoice Posting
description: Fix summary update errors when you invoice a direct delivery purchase order. Check the posting sequence and the Accounts receivable summary update parameters.
ms.reviewer: kamaybac, shubhamshr, maupadhyaya
ms.search.form: SalesTable, SalesEditLines, PurchTable, CustParameters
audience: Application User
ms.search.region: Global
ms.custom: sap:Purchase order procurement and sourcing\Issues with purchase orders
ms.date: 08/12/2026
ai-usage: ai-assisted
---

# Summary update error when you invoice a direct delivery purchase order

## Summary

A summary update error can block invoice posting on a direct delivery purchase order in Microsoft Dynamics 365 Supply Chain Management. Errors like "The update has been cancelled", "Packing slip \<number\> cannot be found or has not been posted", and "The selected records cannot be summarized" have two common causes: you invoiced the linked sales order before the purchase order product receipt posted the customer packing slip, or the summary update parameters in Accounts receivable conflict with the direct delivery flow. This article explains the correct posting sequence and how to review those parameters so the invoice posts successfully.

## Symptoms

When you try to post an invoice for a purchase order (PO) that uses direct delivery, the system generates an error similar to one of the following messages:

> The update has been cancelled.

> Packing slip \<number\> cannot be found or has not been posted.

> The selected records cannot be summarized.

## Cause: Invoice posted before packing slip on the intercompany sales order

In a [direct delivery](/dynamics365/supply-chain/sales-marketing/direct-deliveries) scenario, the vendor ships goods directly to the customer without passing through your warehouse. Because no warehouse shipment occurs, the customer packing slip comes from the purchase order receipt. You must follow the posting sequence in strict order:

1. Post the [**Product receipt**](/dynamics365/supply-chain/procurement/product-receipt-against-purchase-orders) on the direct delivery purchase order.
1. This step automatically creates and posts the **packing slip** on the linked sales order.
1. Invoice the **sales order** (or intercompany sales order) after the packing slip is posted.

If you try to invoice the sales order or intercompany sales order before completing step 1 and step 2, the system can't find a valid packing slip to base the invoice on, and the posting fails.

### Solution: Follow the correct posting sequence for direct delivery

Ensure the product receipt on the purchase order is posted before you invoice the sales order.

1. Go to **Procurement and sourcing** > **Purchase orders** > **All purchase orders**.
1. Open the direct delivery purchase order.
1. On the Action Pane, on the **Receive** tab, select **Product receipt**.
1. Post the product receipt. This action automatically posts the packing slip on the linked sales order.
1. After the product receipt is posted, go to **Accounts receivable** > **Orders** > **All sales orders**.
1. Open the linked sales order, and then on the Action Pane, on the **Invoice** tab, select **Invoice**.
1. Post the invoice.

## Cause: Summary update parameters misconfigured in Accounts receivable

The **Summary update for** field on the **Posting invoice** dialog controls how the system consolidates multiple sales orders or packing slips into a single invoice. If the **Summary update parameters** in Accounts receivable aren't configured correctly, the system might be unable to match the packing slip from the direct delivery PO to the invoice being posted. For a description of each option, see [Create a customer invoice](/dynamics365/finance/accounts-receivable/configure-customer-invoices).

Common misconfiguration examples:

- The **Summary update parameters** require matching on a field (such as **Terms of payment** or **Mode of delivery**) that differs between the PO and the linked sales order.
- The **Summary update for** setting is set to **Packing slip** but no packing slip is posted yet.
- The **Split based on invoice site** or **Split based on invoice delivery information** options create unexpected splits that prevent the invoice from matching the packing slip. These options create a separate invoice for each site or each sales order line delivery address.

### Solution: Review the Summary update parameters in Accounts receivable

1. Go to **Accounts receivable** > **Setup** > **Accounts receivable parameters**.
1. Select the **Summary update** tab.
1. Review the **Summary update parameters** section. Ensure the matching criteria don't include fields that differ between the purchase order and the linked sales order in your direct delivery scenario.
1. If the **Split based on invoice site** or **Split based on invoice delivery information** option is enabled, verify that this splitting behavior is intentional and doesn't conflict with the direct delivery invoice flow.
1. Save any changes, and then retry the invoice posting.

> [!NOTE]
> In the **Posting invoice** dialog, the **Summary update for** field defaults to the value configured in Accounts receivable parameters. You can override it for a single posting by selecting **None** in the **Summary update for** field, which posts a separate invoice for each sales order without applying summary consolidation.

## Related content

- [Create a customer invoice](/dynamics365/finance/accounts-receivable/configure-customer-invoices)
- [Direct deliveries](/dynamics365/supply-chain/sales-marketing/direct-deliveries)
- [Ship orders as direct deliveries](/dynamics365/supply-chain/sales-marketing/tasks/ship-orders-direct-deliveries)
- [Product receipt against purchase orders](/dynamics365/supply-chain/procurement/product-receipt-against-purchase-orders)
