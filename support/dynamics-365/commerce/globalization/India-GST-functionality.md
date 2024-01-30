---
title: Troubleshoot errors with Goods and Services Tax integration for India
description: Resolves an error that occurs when you calculate India Goods and Services Tax (GST) in Microsoft Dynamics 365 Commerce.
author: JialinHuang803
ms.author: jialinhuang
ms.reviewer: josaw, brstor
ms.date: 01/30/2024
---
# Troubleshoot errors with Goods and Services Tax (GST) integration for India

This article provides a solution for an error that occurs when you work with Goods and Services Tax (GST) integration for India in Microsoft Dynamics 365 Commerce.

## Symptoms

You might receive an error when trying to calculate GST.

## Resolution

To resolve this issue, confirm that the India-specific functionality has been enabled.

- If you use Dynamics 365 Commerce version 10.0.33 or earlier, make sure the following extensions are deployed:

  - `Microsoft.Dynamics.Commerce.Runtime.TaxRegistrationIdIndia`
  - `Microsoft.Dynamics.Commerce.Runtime.GenericTaxEngine`

- If you use Dynamics 365 Commerce version 10.0.34 or later, make sure the extensions listed above are removed and the following features are enabled:

  - (India) Enable Tax engine for Commerce for India
  - (India) Enable customer tax registration information in Retail POS

For more information, see [India GST functionality prerequisites](/dynamics365/commerce/localizations/india/apac-ind-cash-registers#prerequisites).

## More information

- [Goods and Services Tax (GST) integration for cash registers for India](/dynamics365/commerce/localizations/india/apac-ind-cash-registers)
- [Goods and Services Tax (GST) integration for e-commerce sites for India](/dynamics365/commerce/localizations/india/apac-ind-e-commerce#configure-gst-for-e-commerce)
- [India Goods and Services Tax (GST) overview](/dynamics365/finance/localizations/india/apac-ind-gst)
- [Deployment guidelines for cash registers for India](/dynamics365/commerce/localizations/india/apac-ind-loc-deployment-guidelines)
