---
title: Troubleshoot common issues with the Dynamics 365 Payment Connector for Adyen
description: Learn how to troubleshoot common issues with the Dynamics 365 Payment Connector for Adyen, including resolving stale authorization errors and configuration problems.
ms.reviewer: johnmichalak, v-shaywood
ms.custom: sap:Payments
ms.date: 10/15/2025
---

# Troubleshoot Dynamics 365 Payment Connector for Adyen

This article provides troubleshooting guidance for common errors with the Dynamics 365 Payment Connector for Adyen. The Dynamics 365 Payment Connector for Adyen facilitates communication between Microsoft Dynamics 365 Commerce (and associated components) and the Adyen payment service. The Dynamics 365 Payment Connector for Adyen takes advantage of the device-agnostic [Adyen Terminal API](https://www.adyen.com/knowledge-hub/introducing-the-terminal-api). It supports all payment terminals that this application programming interface (API) supports. For a complete list of Adyen payment terminals, see [Adyen POS terminals](https://www.adyen.com/pos-payments/terminals).

## Issue 1: Invoicing sales orders fail due to stale authorization

### Symptoms

Invoicing sales orders fail and generate the error `Exception has been thrown by the target of an invocation. System.ArgumentNullException: Value cannot be null.`. The underlying error in the logs is `The following error occurred during the capture call - Dynamics 365 Payment Connector for Adyen: Error code Decline message Capture failed due to stale authorization.`.

### Cause

This error happens when an authorization older than the **Authorization stale period (days)** property value is sent to the payment connector for capture.

### Solution

To solve this issue, follow these steps.

1. In Dynamics 365 Commerce headquarters, go to **Accounts receivable parameters** \> **Credit Card**.
1. In the **Number of days before expired** field, ensure that the value is set to one (1) day less than the value set in merchant properties for all channels. The recommended value for **Authorization stale period (days)** is 14 in Adyen merchant properties, and 13 in **Accounts receivables parameters**.
1. Retry invoicing.

## Issue 2: Store Commerce app or IIS Hardware Station configuration isn't updated

### Symptoms

The Store Commerce app generates the error `Sign in Error. The initialization data couldn't be loaded.`.

### Cause

This issue can occur when the point of sale (POS) is redeployed, but the dllhost.config file isn't updated.

### Solution

To solve this issue, follow these steps.

1. Follow the instructions in [Update the Store Commerce app or IIS Hardware Station configuration](/dynamics365/commerce/dev-itpro/adyen-connector-setup#update-the-store-commerce-app-or-iis-hardware-station-configuration).
1. In Task Manager, on the **Details** tab, end the dllhost.exe task.
1. Reopen the Store Commerce app. If you're using a Microsoft Internet Information Services (IIS) Hardware Station, reset IIS.

## Issue 3: EFT Terminal ID isn't set

### Symptoms

Payment authorization calls fail, and a hardware error occurs. An error message in the event log indicates that the **EFT Terminal ID** value isn't set.

### Cause

This issue can occur when the **EFT POS Register Number** field isn't set on the register or the IIS Hardware Station. It can also occur if the value is set but isn't correctly synced to the POS terminal, or when the value is cached.

### Solution

To solve this issue, follow these steps.

1. Follow the instructions in [Set up a Dynamics 365 register](/dynamics365/commerce/dev-itpro/adyen-connector-setup#set-up-a-dynamics-365-register).
1. Run the 1070 and 1090 distribution schedule jobs.
1. If the issue isn't resolved, consider reactivating the Store Commerce app, because the value of the **EFT POS Register Number** field may be cached and might need to be reset.

## Related content

- [Dynamics 365 Payment Connector for Adyen overview](/dynamics365/commerce/dev-itpro/adyen-connector)
- [Set up Dynamics 365 Payment Connector for Adyen](/dynamics365/commerce/dev-itpro/adyen-connector-setup)
- [Dynamics 365 Payment Connector for Adyen FAQ](/dynamics365/commerce/dev-itpro/adyen-connector-faq)
- [Payments FAQ](/dynamics365/unified-operations/retail/dev-itpro/payments-retail)
