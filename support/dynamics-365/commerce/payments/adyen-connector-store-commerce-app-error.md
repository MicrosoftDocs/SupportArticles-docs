---
title: Dynamics 365 Payment Connector for Adyen - Store Commerce app or IIS Hardware Station configuration isn't updated
description: Resolves an issue with the Dynamics 365 Payment Connector for Adyen where the Store Commerce app generates a sign-in error.
author: v-chgri
ms.author: johnmichalak
ms.topic: troubleshooting
ms.date: 10/15/2025
---
# Dynamics 365 Payment Connector for Adyen - Store Commerce app or IIS Hardware Station configuration isn't updated

This article provides a solution for an issue with the Dynamics 365 Payment Connector for Adyen where the Store Commerce app generates a sign-in error.

## Symptoms

The Store Commerce app generates the error `Sign in Error. The initialization data couldn't be loaded.`.

### Root cause

This issue can occur when the point of sale (POS) is redeployed, but the dllhost.config file isn't updated.

## Resolution

To solve this issue, follow these steps.

1. Follow the instructions in [Update the Store Commerce app or IIS Hardware Station configuration](/dynamics365/commerce/dev-itpro/adyen-connector-setup#update-the-store-commerce-app-or-iis-hardware-station-configuration).
1. In Task Manager, on the **Details** tab, end the dllhost.exe task.
1. Reopen the Store Commerce app. If you're using a Microsoft Internet Information Services (IIS) Hardware Station, reset IIS.

## More information

[Dynamics 365 Payment Connector for Adyen overview](/dynamics365/commerce/dev-itpro/adyen-connector)

[Set up Dynamics 365 Payment Connector for Adyen](/dynamics365/commerce/dev-itpro/adyen-connector-setup)

[Dynamics 365 Payment Connector for Adyen FAQ](/dynamics365/commerce/dev-itpro/adyen-connector-faq)

[Payments FAQ](/dynamics365/unified-operations/retail/dev-itpro/payments-retail)

