---
title: Refund on a return order is declined in Dynamics 365 Commerce
description: Resolves an issue where a refund on a return order is declined if the credit card differs from that used for the original payment authorization in Microsoft Dynamics 365 Commerce.
author: josaw1 
ms.author: josaw
ms.reviewer: rassadi, brstor
ms.date: 05/22/2025
ms.custom: sap:Payments\Issues with refund transactions
---
# Refund on a return order is declined

This article provides a resolution for an issue where a refund on a return order is declined because the credit card that's used for invoicing differs from the card that was used during the original payment authorization in Microsoft Dynamics 365 Commerce.

## Symptoms

A refund is declined when the credit card that's used to invoice a return order differs from the card that was used during the original payment authorization. You receive the following error message:

> Some payments are not in the correct status for posting. Please re-validate the status of all payments prior to invoicing.

:::image type="content" source="media/refund-declined/refund-order-decline.png" alt-text="Screenshot that shows the some payments are not in the correct status for posting error that occurs when a refund is declined.":::

The payment authorization details include the following error message:

> Adyen gateway SendRequest() failed with status 'InternalServerError'.22144; Empty response returned from Adyen.(22001);

## Resolution

To solve this issue, contact the Adyen support team and request to enable blind returns on your Adyen merchant account. For more information, see [Troubleshoot issues with Dynamics 365 Payment Connector for Adyen](adyen-support.md).

## More information

- [Dynamics 365 Payment Connector for Adyen](/dynamics365/commerce/dev-itpro/adyen-connector)
- [Set up the Adyen payment connector for Dynamics 365](https://docs.adyen.com/plugins/microsoft-dynamics)

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]
