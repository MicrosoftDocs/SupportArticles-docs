---
title: Order summary subtotal doesn't include taxes on charges when using customized order summary modules
description: Resolves an issue where the order summary subtotal doesn't include taxes on charges in the price includes sales tax scenario in Microsoft Dynamics Commerce.
author: josaw1
ms.author: josaw
ms.reviewer: brstor
ms.date: 09/08/2023
---
# Order summary subtotal doesn't include taxes on charges when using customized order summary modules

This article provides a resolution for an issue where the order summary subtotal doesn't include taxes on charges in the "price includes sales tax" scenario when you use customized order summary modules in Microsoft Dynamics Commerce.

## Symptoms

As of Microsoft Dynamics 365 Commerce version 10.0.27, the following changes have been made to the "price includes sales tax" scenario to provide a consistent experience in order summary modules across e-commerce site pages.

- Two new fields have been added: `TaxOnShippingCharge` and `TaxOnNonShippingCharges`.
- The `GetSalesOrderBySalesId` and `GetSalesOrderByTransactionId` application programming interfaces (APIs) have accurate values for the following fields in the "price includes sales tax" scenario:

  - `SubtotalSalesAmount`
  - `SubtotalAmountWithoutTax`
  - `SubtotalAmount`
  - `ShippingChargeAmount`
  - `OtherChargeAmount`

However, if you use customized order summary modules, these changes might affect order summary subtotal values by not including taxes on charges.

## Resolution

If you use customized order summary modules and don't want to inherit the changes that have been made to the "price includes sales tax" scenario in Dynamics 365 Commerce version 10.0.27 and later, you can revert to the previous (before version 10.0.27) order summary behavior of the `salesTransaction.SubtotalAmount` and `salesTransaction.SubtotalAmountWithoutTax` fields. This will restore the inclusion of the total charge tax amount (`TaxOnShippingCharge` and `TaxOnNonShippingCharges`) in the subtotal amounts (`SubtotalAmount` and `SubtotalAmountWithoutTax`).

To revert to the previous order summary behavior, follow these steps:

1. In Commerce headquarters, go to **Retail and Commerce** > **Headquarters setup** > **Parameters** > **Commerce parameters** to open the **Commerce parameters** page.
1. In the left navigation pane, select **Configuration parameters**.
1. Add the following configuration parameters, and set the value of each to **true**:

    - `IsLegacyTaxOnChargeInSubtotalAmountIncludedInTaxIncusiveEnabled`
    - `IsLegacyOrderSummaryHydrationEnabled`

> [!NOTE]
> If you've previously used the `IsUpdatedPriceIncludesTaxSubtotalCalculationEnabled` configuration parameter and want to retain the same behavior for the `order.NetAmountWithoutTax` property, you should also add the `IsLegacyPriceIncludesTaxNetAmountWithoutTaxCalculationEnabled` configuration parameter and set its value to **true**.

## More information

For more information, see [Hide tax breakup information in order summaries](/dynamics365/commerce/hide-taxes-breakup).
