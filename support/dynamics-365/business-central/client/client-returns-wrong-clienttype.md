---
title: Troubleshoot client returns wrong `ClientType`
description: Learn how to ensure that the correct client type is returned for each client.
ms.custom: na
ms.date: 02/26/2024
ms.reviewer: na
ms.topic: troubleshooting
author: SusanneWindfeldPedersen
ms.author: solsen
---

# Troubleshoot client returns wrong `ClientType`

When you run the Business Central tablet client and the Business Central phone client simultaneously in the same browser session, you might get the same `ClientType` returned for both clients.

## Prerequisites

First you must check that the environment meets the prerequisites for the mobile app. For more information, see [Preparing the environment](/dynamics365/business-central/dev-itpro/deployment/install-business-central-app#prereqs).

## Symptoms

Running, for example, the Business Client tablet client and the Business Client phone client simultaneously in the same browser session will return the same `ClientType`.

## Resolution

If you have implemented code that checks for the `CurrentClientType`, you must run each of the different clients in separate browser windows to make sure that the correct client type is returned for each of the clients.  
  
## Next steps

[Designing for different screen sizes on tablet and phone](/dynamics365/business-central/dev-itpro/developer/devenv-designing-different-screen-sizes-tablet-and-phone)   
[CurrentClientType method](/dynamics365/business-central/dev-itpro/developer/methods-auto/session/session-currentclienttype-method)   
[DefaultClientType method](/dynamics365/business-central/dev-itpro/developer/methods-auto/session/session-defaultclienttype-method)