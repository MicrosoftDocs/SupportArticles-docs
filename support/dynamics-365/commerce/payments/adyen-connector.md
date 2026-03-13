---
title: Troubleshoot common issues in the Dynamics 365 Payment Connector for Adyen
description: Learn how to troubleshoot common issues that affect the Dynamics 365 Payment Connector for Adyen.
ms.reviewer: johnmichalak, Jiantong.Zhang, valitovgleb,v-shaywood
ms.custom: sap:Payments\Issues with Dynamics 365 Payment Connector for Adyen
ms.date: 10/15/2025
---

# Troubleshoot Dynamics 365 Payment Connector for Adyen

This article provides troubleshooting guidance for common errors that affect the Microsoft Dynamics 365 Payment Connector for Adyen. The Dynamics 365 Payment Connector for Adyen facilitates communication between Microsoft Dynamics 365 Commerce (and associated components) and the Adyen payment service.

The Dynamics 365 Payment Connector for Adyen takes advantage of the device-agnostic [Adyen Terminal API](https://www.adyen.com/knowledge-hub/introducing-the-terminal-api). It supports all payment terminals that this application programming interface (API) supports. For a complete list of Adyen payment terminals, see [Adyen POS terminals](https://www.adyen.com/pos-payments/terminals).

## Invoicing sales orders fails because of stale authorization

### Symptoms

The process of invoicing sales orders fails and returns the following error message to the Commerce headquarters:

> Exception has been thrown by the target of an invocation. System.ArgumentNullException: Value cannot be null.

The following underlying error is also logged in the event log:

> The following error occurred during the capture call - Dynamics 365 Payment Connector for Adyen: Error code Decline message Capture failed due to stale authorization.

For more information about how to access the Commerce-specific event logs, see [Commerce component events for diagnostics and troubleshooting](/dynamics365/commerce/dev-itpro/retail-component-events-diagnostics-troubleshooting#find-commerce-specific-events-in-event-viewer).

### Cause

This error occurs if an authorization that's older than the **Authorization stale period (days)** property value is sent to the payment connector for capture.

### Solution

To resolve this issue, take the following steps:

1. In Dynamics 365 Commerce headquarters, go to **Accounts receivable parameters** \> **Credit Card**.
1. Make sure that the **Number of days before expired** property is set to at least one day less than the **Authorization stale period (days)** property for each channel.
   1. You can configure the **Authorization stale period (days)** property in **Payment services**, **Hardware profiles**, and **Online stores**.

      | Property                              | Recommended value |
      | ------------------------------------- | ----------------- |
      | **Authorization stale period (days)** | 14 days           |
      | **Number of days before expired**     | 13 days           |

      :::image type="content" source="./media/adyen-connector/authorization-stale-period.png" alt-text="The payment services configuration menu that shows the Authorization stale period in days highlighted":::

      :::image type="content" source="./media/adyen-connector/days-before-expired.png" alt-text="The accounts receivable parameters menu that shows the Number of days before expired highlighted":::

1. Retry invoicing.

For more information about how to configure the payment connector for Adyen, see [Set up Dynamics 365 Payment Connector for Adyen](/dynamics365/commerce/dev-itpro/adyen-connector-setup#set-up-a-processor-for-new-credit-cards).

## EFT Terminal ID isn't set

### Symptoms

The following error is logged in Event Viewer:

> Hardware station an exception occurred when trying to open a payment device and begin a transaction.. Exception: System.ArgumentNullException: Value cannot be null.
> Parameter name: terminalSettings.TerminalId

The Store Commerce app also displays the following error message to the point of sale (POS) user:

> There was an error communicating with the hardware station.

:::image type="content" source="./media/adyen-connector/hardware-station-config-error.png" alt-text="Message about a hardware station error":::

### Cause

This issue might occur in one of the following scenarios:

- You don't set the **EFT POS Register Number** field on the register or the IIS Hardware Station.
- You configure the **EFT POS Register Number** value in Finance and Operations (F&O), but the Commerce Data Exchange (CDX) job for syncing data from F&O to the channel database hasn't run yet.
- An outdated **EFT POS Register Number** is cached on the retail server.

### Solution

To fix this issue, follow these steps:

1. Follow the instructions in [Set up a Dynamics 365 register](/dynamics365/commerce/dev-itpro/adyen-connector-setup#set-up-a-dynamics-365-register).
1. On the **Distribution schedule** page, run the **1070** and **1090** jobs.
1. If the issue isn't resolved, consider reactivating the Store Commerce app. The previous value of the **EFT POS Register Number** field might be cached and have to be reset by reactivating the Store Commerce App.

## Related content

- [Dynamics 365 Payment Connector for Adyen overview](/dynamics365/commerce/dev-itpro/adyen-connector)
- [Set up Dynamics 365 Payment Connector for Adyen](/dynamics365/commerce/dev-itpro/adyen-connector-setup)
- [Dynamics 365 Payment Connector for Adyen FAQ](/dynamics365/commerce/dev-itpro/adyen-connector-faq)
- [Payments FAQ](/dynamics365/unified-operations/retail/dev-itpro/payments-retail)

[!INCLUDE [Third-party information disclaimer](../../../includes/third-party-disclaimer.md)]

[!INCLUDE [Third-party contact disclaimer](../../../includes/third-party-contact-disclaimer.md)]
