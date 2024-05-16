---
title: Client returns a wrong client type in Business Central
description: Provides a resolution to ensure that the correct client type is returned for each client in Dynamics 365 Business Central.
ms.date: 05/16/2024
ms.reviewer: solsen
author: SusanneWindfeldPedersen
ms.author: solsen
ms.custom:
---
# A Business Central client returns a wrong client type

This article provides a resolution for the issue that you might get the same [ClientType](/dynamics365/business-central/dev-itpro/developer/methods-auto/clienttype/clienttype-option) when you run the Business Central tablet client and the Business Central phone client simultaneously in the same browser session.

## Symptoms

Running the Business Client tablet client and the Business Client phone client simultaneously in the same browser session will return the same [ClientType](/dynamics365/business-central/dev-itpro/developer/methods-auto/clienttype/clienttype-option).

## Prerequisites

First you must check that the environment meets the prerequisites for the mobile app. For more information, see [Preparing the environment](/dynamics365/business-central/dev-itpro/deployment/install-business-central-app#prereqs).

## Resolution

If you have implemented code that checks for the [CurrentClientType](/dynamics365/business-central/dev-itpro/developer/methods-auto/session/session-currentclienttype-method), you must run each client in a separate browser window to make sure that the correct client type is returned.

## More information

- [Designing for different screen sizes on tablet and phone](/dynamics365/business-central/dev-itpro/developer/devenv-designing-different-screen-sizes-tablet-and-phone)
- [CurrentClientType method](/dynamics365/business-central/dev-itpro/developer/methods-auto/session/session-currentclienttype-method)
- [DefaultClientType method](/dynamics365/business-central/dev-itpro/developer/methods-auto/session/session-defaultclienttype-method)
