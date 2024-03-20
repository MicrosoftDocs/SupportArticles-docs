---
title: Purchase Order Receiving integration uses Purchase Price Variance account from Posting Accounts Setup
description: Discusses that a Purchase Order Receiving integration incorrectly uses the Purchase Price Variance from the Posting Accounts Setup window in Microsoft Dynamics GP and in Microsoft Great Plains 8.0. A service pack is available to resolve the problem.
ms.reviewer: theley, lmuelle
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Distribution - Purchase Order Processing
---
# Purchase Order Receiving integration uses the Purchase Price Variance account from Posting Accounts Setup instead of Item Account Maintenance

This article provides a resolution for the issue that the Purchase Price Variance account that is used is from the Posting Accounts Setup window instead of from the Item Account Maintenance window when integrating a Purchase Order Receiving transaction in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 917944

## Symptoms

When you integrate a Purchase Order Receiving transaction in Microsoft Dynamics GP 9.0 or in Microsoft Business Solutions - Great Plains 8.0, the Purchase Price Variance account that is used is from the Posting Accounts Setup window instead of from the Item Account Maintenance window.

This problem occurs when the following conditions are true for the integrated data:

- The transaction does not have a purchase order number.
- The item has a periodic valuation method.
- The cost differs from the **Standard Cost** value.
- The **Distributions** mapping folder is set to **Use Default**.

## Resolution for Microsoft Dynamics GP 9.0

To resolve this problem, obtain the latest service pack for Integration Manager for Microsoft Dynamics GP.
