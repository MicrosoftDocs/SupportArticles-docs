---

title: Save for my next payment option doesn't appear
description: This article provides troubleshooting guidance that can help when the Save for my next payment check box doesn't appear under Payment method on an e-commerce site's checkout page.
author: Reza-Assadi
ms.author: josaw
ms.topic: troubleshooting
ms.date: 03/11/2021

---

# "Save for my next payment" option doesn't appear

This article provides troubleshooting guidance that can help when the **Save for my next payment** check box doesn't appear under **Payment method** on an e-commerce site's checkout page.

## Description

The **Save for my next payment** check box doesn't appear in the **Payment method** section on an e-commerce site's checkout page.

The following illustration shows an example of a checkout page that includes the **Save for my next payment** check box.

![Save for my next payment check box in the Payment module.](../../../media/common/payment-module-save-payment.jpg)

## Resolution

### Verify that the Dynamics 365 Payment Connector for Adyen is correctly configured in Commerce headquarters

To verify that the Dynamics 365 Payment Connector for Adyen is correctly configured in Commerce headquarters, follow these steps.

1. Go to **Retail and Commerce \> Channels \> Online Stores**.
1. Select the online store.
1. On the **Payment accounts** FastTab, make sure that the **Allow saving payment information in e-commerce** field is set to **True**.

![Allow saving payment information in e-commerce field in Commerce headquarters.](../../../media/common/payment-connector-save-payment.jpg)

## Additional resources

[Payment module](/dynamics365/commerce/payment-module)

[Saving online payment instruments with the Adyen connector](/dynamics365/commerce/dev-itpro/adyen-connector-listpi)
