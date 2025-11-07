---
title: Troubleshoot common issues with the Dynamics 365 Payment Connector for Adyen
description: Learn how to troubleshoot common issues with the Dynamics 365 Payment Connector for Adyen, including resolving stale authorization errors and configuration problems.
ms.reviewer: johnmichalak, v-shaywood
ms.custom: sap:Payments\Issues with Dynamics 365 Payment Connector for Adyen
ms.date: 10/15/2025
---

# Troubleshoot Dynamics 365 Payment Connector for Adyen

This article provides troubleshooting guidance for common errors with the Dynamics 365 Payment Connector for Adyen. The Dynamics 365 Payment Connector for Adyen facilitates communication between Microsoft Dynamics 365 Commerce (and associated components) and the Adyen payment service.

The Dynamics 365 Payment Connector for Adyen takes advantage of the device-agnostic [Adyen Terminal API](https://www.adyen.com/knowledge-hub/introducing-the-terminal-api). It supports all payment terminals that this application programming interface (API) supports. For a complete list of Adyen payment terminals, see [Adyen POS terminals](https://www.adyen.com/pos-payments/terminals).

## Issue 1: Invoicing sales orders fail due to stale authorization

### Symptoms

Invoicing sales orders fails and returns the following error message to the Commerce headquarters:

> Exception has been thrown by the target of an invocation. System.ArgumentNullException: Value cannot be null.

The following underlying error is also added to the event log:

> The following error occurred during the capture call - Dynamics 365 Payment Connector for Adyen: Error code Decline message Capture failed due to stale authorization.

For more info on accessing the Commerce-specific event logs, see [Commerce component events for diagnostics and troubleshooting](/dynamics365/commerce/dev-itpro/retail-component-events-diagnostics-troubleshooting#find-commerce-specific-events-in-event-viewer).

### Cause

This error happens when an authorization that's older than the **Authorization stale period (days)** property value is sent to the payment connector for capture.

### Solution

To resolve this issue, take the following steps:

1. In Dynamics 365 Commerce headquarters, go to **Accounts receivable parameters** \> **Credit Card**.
1. Ensure that the **Number of days before expired** property is set to at least one day less than the **Authorization stale period (days)** property for each channel.
   1. You can configure the **Authorization stale period (days)** property in **Payment services**, **Hardware profiles**, and **Online stores**.

      | Property                              | Recommended Value |
      | ------------------------------------- | ----------------- |
      | **Authorization stale period (days)** | 14 days           |
      | **Number of days before expired**     | 13 days           |

      :::image type="content" source="./media/adyen-connector/authorization-stale-period.png" alt-text="Screenshot of the payment services configuration menu, with the Authorization stale period (days) highlighted":::

1. Retry invoicing.

For more information on configuring the payment connector for Adyen, see [Set up Dynamics 365 Payment Connector for Adyen](/dynamics365/commerce/dev-itpro/adyen-connector-setup#set-up-a-processor-for-new-credit-cards).

## Issue 2: Store Commerce app or IIS Hardware Station configuration isn't updated

### Symptoms

The Store Commerce app returns the following error message dialog to the POS user:

> Sign in Error. The initialization data couldn't be loaded.

The following underlying error is also added to the event log:

> Hardware station an exception occurred when trying to open a payment device and begin a transaction.. Exception: System.ArgumentNullException: Value cannot be null.
> Parameter name: terminalSettings.TerminalId

### Cause

This issue can occur when you redeploy the point of sale (POS) but the `dllhost.config` file isn't updated.

### Solution

To resolve this issue, follow these steps:

1. Follow the instructions in [Update the Store Commerce app or IIS Hardware Station configuration](/dynamics365/commerce/dev-itpro/adyen-connector-setup#update-the-store-commerce-app-or-iis-hardware-station-configuration).
1. In Task Manager, on the **Details** tab, end the `dllhost.exe` task.
1. Reopen the Store Commerce app.
1. If you're using a Microsoft Internet Information Services (IIS) Hardware Station, reset IIS by running the following command in a Command Prompt or PowerShell terminal:

   ```powershell
   iisreset
   ```

## Related content

- [Dynamics 365 Payment Connector for Adyen overview](/dynamics365/commerce/dev-itpro/adyen-connector)
- [Set up Dynamics 365 Payment Connector for Adyen](/dynamics365/commerce/dev-itpro/adyen-connector-setup)
- [Dynamics 365 Payment Connector for Adyen FAQ](/dynamics365/commerce/dev-itpro/adyen-connector-faq)
- [Payments FAQ](/dynamics365/unified-operations/retail/dev-itpro/payments-retail)
