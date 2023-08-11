---

title: Payments are automatically settled before orders are invoiced or shipped
description: This article provides troubleshooting guidance that can help when a payment is settled in the Adyen portal immediately after an order is placed, even though the sales order hasn't been invoiced or shipped.
author: Reza-Assadi
ms.author: josaw
ms.topic: troubleshooting
ms.date: 03/11/2021

---

# Payments are automatically settled before orders are invoiced or shipped

This article provides troubleshooting guidance that can help when a payment is settled in the Adyen portal immediately after an order is placed, even though the sales order hasn't been invoiced or shipped.

## Description

After an order is placed, the payment is immediately settled in the Adyen portal, even though the sales order hasn't been invoiced or shipped.

## Resolution

### Configure manual capture for e-commerce payments in the Adyen portal

To configure manual capture for e-commerce payments in the Adyen portal, follow these steps.

1. Sign in to the Adyen portal.
1. In the upper-right corner, select your merchant account for the e-commerce channel.
1. On the top navigation, select **Account**, and then select **Settings**.
1. In the **Capture Delay** field, select **manual**.

    ![Capture Delay setting in the Adyen portal.](../../../media/common/adyen-capture-delay.jpg)

## Additional resources

[Adyen payment capture](https://docs.adyen.com/point-of-sale/capturing-payments)

[Dynamics 365 Payment Connector for Adyen](/dynamics365/commerce/dev-itpro/adyen-connector)

[Set up the Adyen payment connector for Dynamics 365](https://docs.adyen.com/plugins/microsoft-dynamics)
