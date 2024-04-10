---
title: Save for my next payment option doesn't appear in Dynamics 365 Commerce
description: Provides a resolution for an issue where the Save for my next payment option doesn't appear under PAYMENT METHOD on an e-commerce site's checkout page in Microsoft Dynamics 365 Commerce.
author: josaw1 
ms.author: josaw
ms.reviewer: rassadi, brstor
ms.date: 09/08/2023
ms.custom: sap:Payments\Issues with payment method or digital wallet configuration
---
# "Save for my next payment" option doesn't appear

This article provides a resolution for an issue where the **Save for my next payment** option doesn't appear under the **PAYMENT METHOD** section on an e-commerce site's [checkout page](/dynamics365/commerce/quick-tour-cart-checkout#checkout-page) in Microsoft Dynamics 365 Commerce.

## Symptoms

The **Save for my next payment** option doesn't appear in the **PAYMENT METHOD** section on an e-commerce site's checkout page.

The following screenshot shows an example of a checkout page that includes the **Save for my next payment** option.

:::image type="content" source="media/next-payment-link-not-appearing/payment-module-save-payment.png" alt-text="Screenshot that shows the Save for my next payment option under the PAYMENT METHOD section on the checkout page." lightbox="media/next-payment-link-not-appearing/payment-module-save-payment.png":::

## Resolution

To solve this issue, follow these steps to make sure that the Dynamics 365 Payment Connector for Adyen is correctly configured in Commerce headquarters:

1. Go to **Retail and Commerce** > **Channels** > **Online Stores**.
1. Select the online store.
1. On the **Payment accounts** FastTab, make sure that the **Allow saving payment information in e-commerce** field is set to **True**.

:::image type="content" source="media/next-payment-link-not-appearing/payment-connector-save-payment.png" alt-text="Screenshot that shows the Allow saving payment information in e-commerce field in Commerce headquarters." lightbox="media/next-payment-link-not-appearing/payment-connector-save-payment.png":::

## More information

- [Payment module](/dynamics365/commerce/payment-module)
- [Saving online payment instruments with the Adyen connector](/dynamics365/commerce/dev-itpro/adyen-connector-listpi)

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]
