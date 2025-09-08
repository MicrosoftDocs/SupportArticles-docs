---
title: Payment type must be credit card error on the sales order page in Dynamics 365 Commerce
description: Solves the payment type must be credit card error that occurs after an order is synchronized in Microsoft Dynamics 365 Commerce.
author: josaw1 
ms.author: josaw
ms.reviewer: rassadi, brstor
ms.date: 05/22/2025
ms.custom: sap:Payments\Issues with payment method or digital wallet configuration
---
# "Payment type must be credit card" error on the sales order page

This article provides a resolution for the "payment type must be credit card" error message shown on the sales order page after an order is synchronized in Microsoft Dynamics 365 Commerce.

## Symptoms

When you open the sales order page after you synchronize an order, you receive the following error message:

> The payment type must be credit card, since the credit card number has been specified.

:::image type="content" source="media/payment-type-credit-card-error/payment-type-must-be-credit-card.png" alt-text="Screenshot that shows the payment type must be credit card error.":::

## Resolution

To solve this issue, set the **Payment type** to **Credit card** in Commerce headquarters:

1. Go to **Accounts receivable** > **Payment setup** > **Terms of payment**.
1. In the left navigation, select your terms of payment.
1. In the **Payment type** field, make sure that **Credit card** is selected.

## More information

[Posting of online sales and payments](/dynamics365/commerce/tasks/posting-online-sales-payments)
