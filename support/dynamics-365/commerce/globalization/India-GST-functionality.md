---
title: Troubleshoot issues with Goods and Services Tax (GST) integration for India
description: Resolves Indian Goods and Services Tax (GST) integration issues in Microsoft Dynamics 365 Commerce.
author: jialinhuang
ms.author: jialinhuang
ms.reviewer: josaw, brstor
ms.date: 01/15/2024
---

# Troubleshoot issues with Goods and Services Tax (GST) integration for India

This article provides a solution for the common issues about Goods and Services Tax (GST) integration for India in Microsoft Dynamics 365 Commerce.

## Symptoms

You may face some errors when attempting to calculate GST.

## Resolution

To resolve this issue, please confirm that India specific functionality has been enabled by following the steps below:

1. If you're using Commerce version 10.0.33 or earlier, make sure the following extensions are deployed:

- Microsoft.Dynamics.Commerce.Runtime.TaxRegistrationIdIndia
- Microsoft.Dynamics.Commerce.Runtime.GenericTaxEngine

2. If you're using Commerce version 10.0.34 or later, make sure extensions above are removed and the following features are enabled:

- (India) Enable Tax engine for Commerce for India
- (India) Enable customer tax registration information in Retail POS

For more information, see [India GST functionality prerequisites](/dynamics365/commerce/localizations/india/apac-ind-cash-registers#prerequisites).

## More information

[Goods and Services Tax (GST) integration for cash registers for India](/dynamics365/commerce/localizations/india/apac-ind-cash-registers)

[Goods and Services Tax (GST) integration for e-commerce sites for India](/dynamics365/commerce/localizations/india/apac-ind-e-commerce#configure-gst-for-e-commerce)

[India Goods and Services Tax (GST) overview](/dynamics365/finance/localizations/india/apac-ind-gst)

[Deployment guidelines for cash registers for India](/dynamics365/commerce/localizations/india/apac-ind-loc-deployment-guidelines)
