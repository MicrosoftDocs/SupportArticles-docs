---
title: Dynamics 365 Payment Connector for Adyen - EFT Terminal ID isn't set
description: Resolves an issue with the Dynamics 365 Payment Connector for Adyen where the payment authorization calls fail, and a hardware error occurs because the electronic funds transfer (EFT) Terminal ID isn't set.
author: v-chgri
ms.author: johnmichalak
ms.topic: troubleshooting
ms.date: 10/03/2025
---
# Dynamics 365 Payment Connector for Adyen - EFT Terminal ID isn't set

This article provides a solution for an issue with the Dynamics 365 Payment Connector for Adyen where the payment authorization calls fail, and a hardware error occurs because the electronic funds transfer (EFT) Terminal ID isn't set.

## Symptoms

Payment authorization calls fail, and a hardware error occurs. An error message in the event log indicates that the **EFT Terminal ID** value isn't set.

### Root cause

This issue can occur when the **EFT POS Register Number** field isn't set on the register or the IIS Hardware Station. It can also occur if the value is set but isn't correctly synced to the POS terminal, or when the value is cached.

## Resolution

To solve this issue, follow these steps.

1. Follow the instructions in [Set up a Dynamics 365 register](/dynamics365/commerce/dev-itpro/adyen-connector-setup#set-up-a-dynamics-365-register).
1. Run the 1070 and 1090 distribution schedule jobs.
1. If the issue isn't resolved, consider reactivating the Store Commerce app, because the value of the EFT POS Register Number field may be cached and might need to be reset.

## More information

[Dynamics 365 Payment Connector for Adyen overview](/dynamics365/commerce/dev-itpro/adyen-connector)

[Set up Dynamics 365 Payment Connector for Adyen](/dynamics365/commerce/dev-itpro/adyen-connector-setup)

[Dynamics 365 Payment Connector for Adyen FAQ](/dynamics365/commerce/dev-itpro/adyen-connector-faq)

[Payments FAQ](/dynamics365/unified-operations/retail/dev-itpro/payments-retail)

