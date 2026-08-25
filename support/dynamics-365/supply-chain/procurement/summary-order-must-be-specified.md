---
title: Summary Order Must Be Specified Error on Vendor Invoice
description: Summary order must be specified error blocks vendor invoice posting in Dynamics 365 Supply Chain Management. Fix the summary order selection in the posting dialog.
ms.date: 08/24/2026
ms.search.form: PurchSummaryParameters, VendEditInvoice
ms.reviewer: kamaybac, sugaur, vaibhpandey
ms.search.region: Global
ms.search.validFrom: 2021-05-31
ms.dyn365.ops.version: 10.0.13
ms.custom: sap:Purchase order procurement and sourcing\Issues with invoicing
ai-usage: ai-assisted
---
# "Summary order must be specified" error when you post a vendor invoice

## Summary

The error "Summary order must be specified" blocks vendor invoice posting in Microsoft Dynamics 365 Supply Chain Management when you set **Summary update for** to **Order** in the posting dialog but don't select a valid summary order. Summary update controls whether multiple purchase orders are consolidated into a single vendor invoice, and the **Order** option requires one purchase order to act as the summary order. This article explains why the error appears in some legal entities but not others, and how to fix it by correcting the posting dialog value or by changing the default in **Summary update parameters**.

## Symptoms

When you post a [vendor invoice](/dynamics365/finance/accounts-payable/vendor-invoices-overview) from one or more purchase orders, posting fails and the following error message appears:

> Summary order must be specified.

The same scenario might succeed in another legal entity or environment.

## Cause

For the current posting attempt, **Summary update for** is set to **Order**, but one of the following conditions is true:

- No summary order is selected.
- The selected summary order can't be resolved from the purchase orders included in the posting.

The **Default values for summary update** setting for the legal entity supplies the initial value for future posting dialogs. The editable **Summary update for** value in the posting dialog governs the current attempt.

The **Order** option requires the posting process to identify a purchase order to use as the summary order, so posting stops when that order is missing or can't be matched.

Two settings control this behavior:

- **Default values for summary update** in **Summary update parameters** supplies the initial value that appears in future posting dialogs for the legal entity.
- **Summary update for** in the vendor invoice posting dialog is editable and governs only the current posting attempt.

Because the posting dialog value takes precedence, changing the parameter setup alone doesn't unblock an invoice that's already open for posting.

## Solution

Follow these steps to post the failed invoice:

1. Reopen the vendor invoice posting dialog for the failed, unposted invoice.
1. Check that **Summary update for** is **Order**, and review the summary-order selection.
   
   If the posting attempt uses another value, or if a valid summary order is already selected from the selected purchase orders, stop and [contact Microsoft Support](/power-platform/admin/get-help-support).
1. Use the option that matches your intended business process:
   - If summary updating isn't required for this posting attempt, set **Summary update for** to **None**. Each purchase order is then invoiced separately.
   - If **Order** is intended, select a valid summary order from the selected purchase orders and revalidate the selected set.
1. Post the vendor invoice again.

> [!IMPORTANT]
> The current invoice remains unposted until the retry succeeds. A successful retry posts it by using the values selected for that attempt.

## Change the default summary update value for future postings

If the error occurs repeatedly because the legal entity default doesn't match how your organization invoices purchase orders, update the default for future posting attempts:

1. Go to **Procurement and sourcing** > **Setup** > **Summary update parameters**.
1. On the **General** tab, set the applicable **Default values for summary update** value to **None** only when no summary updating is your organization's intended default for future postings in that legal entity.

Consider the following scope and timing behavior before you change this setting:

- The change affects only the default that initializes future posting attempts in that legal entity.
- The change doesn't modify already posted documents or repair historical records.
- The change doesn't affect the invoice that's currently open. Reopen the posting dialog and set **Summary update for** to **None** for the current unposted invoice before you retry.

If the error persists even when the posting attempt already uses **None**, or it uses **Order** with a valid summary order from the selected set, then [contact Microsoft Support](/power-platform/admin/get-help-support). In your support request, include information about the affected legal entity, selected purchase orders, invoice posting path, posting-dialog values, exact error, and a trace of the failed attempt.

## Related content

- [Purchase order overview](/dynamics365/supply-chain/procurement/purchase-order-overview)
- [Accounts payable invoice matching](/dynamics365/finance/accounts-payable/accounts-payable-invoice-matching)
- [Product receipt against purchase orders](/dynamics365/supply-chain/procurement/product-receipt-against-purchase-orders)
- [Summary update error when you invoice a direct delivery purchase order](summary-update-error-direct-delivery-po-invoice.md)
