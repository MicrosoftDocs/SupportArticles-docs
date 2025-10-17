---
title: Dynamics 365 Payment Connector for Adyen - Invoicing sales orders fail due to stale authorization
description: Resolves an issue the Dynamics 365 Payment Connector for Adyen where invoicing sales orders fail due to stale authorization.
author: johnmichalak
ms.author: johnmichalak
ms.topic: troubleshooting
ms.date: 10/15/2025
---
# Dynamics 365 Payment Connector for Adyen - Invoicing sales orders fail due to stale authorization

This article provides a solution for an issue with the Dynamics 365 Payment Connector for Adyen where invoicing sales orders fail due to stale authorization.

## Symptoms

Invoicing sales orders fail and generate the error `Exception has been thrown by the target of an invocation. System.ArgumentNullException: Value cannot be null.`. The underlying error in the logs is `The following error occurred during the capture call - Dynamics 365 Payment Connector for Adyen: Error code Decline message Capture failed due to stale authorization.`.

### Root cause

This error happens when an authorization older than the **Authorization stale period (days)** property value is sent to the payment connector for capture.

## Resolution

To solve this issue, follow these steps.

1. In Dynamics 365 Commerce headquarters, go to **Accounts receivable parameters** \> **Credit Card**.
1. In the **Number of days before expired** field, ensure that the value is set to one (1) day less than the value set in merchant properties for all channels. The recommended value for **Authorization stale period (days)** is 14 in Adyen merchant properties, and 13 in **Accounts receivables parameters**.
1. Retry invoicing. 

## More information

[Dynamics 365 Payment Connector for Adyen overview](/dynamics365/commerce/dev-itpro/adyen-connector)

[Set up Dynamics 365 Payment Connector for Adyen](/dynamics365/commerce/dev-itpro/adyen-connector-setup)

[Dynamics 365 Payment Connector for Adyen FAQ](/dynamics365/commerce/dev-itpro/adyen-connector-faq)

[Payments FAQ](/dynamics365/unified-operations/retail/dev-itpro/payments-retail)



