---
title: Credit card entry page shows an error at checkout in Dynamics 365 Commerce
description: Provides a resolution for an issue where the PAYMENT METHOD section isn't loaded and shows an error message in Microsoft Dynamics 365 Commerce.
author: josaw1 
ms.author: josaw
ms.reviewer: rassadi, brstor
ms.date: 09/01/2023
ms.custom: sap:Payments\Issues with payment transactions
---
# Credit card entry page shows an error at checkout

This article provides a resolution for an issue where the **PAYMENT METHOD** section isn't loaded on an e-commerce site's [checkout page](/dynamics365/commerce/quick-tour-cart-checkout#checkout-page) and shows an error message in Microsoft Dynamics 365 Commerce.

## Symptoms

When you open the checkout page of an online store, the **PAYMENT METHOD** section isn't loaded, and the following error message occurs:

> Something went wrong. Please try again later.

:::image type="content" source="media/credit-card-entry-form-error/payment-module-error.png" alt-text="Screenshot that shows the error that occurs on the checkout page.":::

## Resolution

To solve this issue, wait for the Commerce Scale Unit cache to expire.

The payment service settings on the online store's checkout page are cached on the Commerce Scale Unit and can take up to 15 minutes to appear on the e-commerce site. These payment service settings include changes to the merchant account ID, cloud API key, and various configuration settings that are related to the payment method.

## More information

[Set up an online channel](/dynamics365/commerce/channel-setup-online)
