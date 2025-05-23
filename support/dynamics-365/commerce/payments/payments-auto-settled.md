---
title: Payments are automatically settled before orders are invoiced or shipped in Dynamics 365 Commerce
description: Resolves an issue where a payment is settled in the Adyen portal immediately after an order is placed, even if the sales order hasn't been invoiced or shipped in Microsoft Dynamics 365 Commerce.
author: josaw1 
ms.author: josaw
ms.reviewer: rassadi, brstor
ms.date: 05/22/2025
ms.custom: sap:Payments\Issues with payment transactions
---
# Payments are automatically settled before orders are invoiced or shipped

This article provides a resolution for an issue where a payment is settled in the Adyen portal immediately after an order is placed, even though the sales order hasn't been invoiced or shipped in Microsoft Dynamics 365 Commerce.

## Symptoms

After an order is placed, the payment is immediately settled in the Adyen portal, even though the sales order hasn't been invoiced or shipped.

## Resolution

To solve this issue, follow these steps to configure manual capture for e-commerce payments in the Adyen portal:

1. Sign in to the [Adyen portal](https://www.adyen.com/).
1. In the upper-right corner, select your merchant account for the e-commerce channel.
1. On the top navigation, select **Account** > **Settings**.
1. In the **Capture Delay** field, select **manual**.

    :::image type="content" source="media/payments-auto-settled/adyen-capture-delay.png" alt-text="Screenshot that shows the Capture Delay setting in the Adyen portal.":::

## More information

- [Adyen payment capture](https://docs.adyen.com/point-of-sale/capturing-payments)
- [Dynamics 365 Payment Connector for Adyen](/dynamics365/commerce/dev-itpro/adyen-connector)
- [Set up the Adyen payment connector for Dynamics 365](https://docs.adyen.com/plugins/microsoft-dynamics)

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]
