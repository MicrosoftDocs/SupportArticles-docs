---
title: Troubleshoot issues with currency and price lists
description: Provides resolutions for the known issues that are related to currency and price lists in Dynamics 365 Sales.
author: sbmjais
ms.reviewer: lavanyakr
ms.author: shjais
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Price list
---

# Troubleshoot issues with currency and price lists

This article helps you troubleshoot and resolve issues related to currency and price lists.

## Issue: Can't update the currency or price list for an opportunity, quote, order, or invoice

### Cause

When I change and try to save the currency or price list for an existing opportunity, quote, order, or invoice that's already associated with a product record or quote record, an error message is displayed.

The error occurs because the associated product record or quote record is already linked with a price list that was created by using a different transaction currency.

The following are the few error messages that will be displayed depending on the entity:

- For an opportunity, the error message is:
  > The currency cannot be changed because the opportunity has opportunity products, quotes, orders, or invoices associated with it. Remove the associated records and then change the currency.

- For a quote, the error message is:
  > The currency cannot be changed because the quote has quote products associated with it. Remove the associated records and then change the currency.

### Resolution

To resolve this issue, you must remove the product records or quote records, change the currency, and then add back the product records or quote records.

You can change the currency and price list for the entities in the following states only.

| Entity | Status | Change currency value? | Change price list value? |
|--------|--------|------------------------|--------------------------|
| **Opportunity** | Open | Yes, but only if there are no associated Opportunity Product, Order, Quote, or Invoice records. | Yes, but this can cause an error with the Opportunity record if the associated Opportunity Product records aren't part of the selected price list. |
|| Won | No | No |
|| Lost | No | No |
| **Quote** | Draft | Yes, but only if there are no associated Quote Product records. | Yes, but this can cause an error with the Quote record if the associated Quote Product records aren't part of the selected price list. |
|| Active | No | No |
|| Won | No | No |
|| Close | No | No |
| **Order** | Active | No | Yes, but this can cause an error with the Order record if the associated Order Product records aren't part of the selected price list. |
|| Submitted | No | No |
|| Canceled | No | No |
|| Fulfilled | No | No |
|| Invoiced | No | No |
| **Invoice** | Active | No | Yes, but this can cause an error if the associated Invoice Product records aren't part of the selected price list. |
|| Paid | No | No |
|| Canceled | No | No |

#### To update the currency or price list

1. Open the opportunity, quote, order, or invoice for which you want to change the currency or price list.

2. For an opportunity: go to the **Product Line Items** tab, and then delete the products from the list.

    :::image type="content" source="media/troubleshoot-currency-and-price-lists-issues/currency-opportunity-product-list.png" alt-text="Delete products from the product list in an opportunity form.":::

    For a quote, order, or invoice: On the **Summary** tab, go to the **PRODUCTS** section, and delete the products from the list.

    :::image type="content" source="media/troubleshoot-currency-and-price-lists-issues/currency-quote-order-or-invoice-product-list.png" alt-text="Delete products from the product list in quote, order, or invoice forms.":::

3. On the **Summary** tab, change the currency to the value you want, and then save the form.
4. Add back the product records or quote records, and then save the form.

> [!NOTE]
> You can change currency by using the entity attribute. To learn more, see [Transaction Currency (currency) entity](/dynamics365/customerengagement/on-premises/developer/transaction-currency-currency-entity).
