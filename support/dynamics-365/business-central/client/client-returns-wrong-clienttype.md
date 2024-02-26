---
title: Troubleshoot client returns wrong CLIENTTYPE
description: Learn how to ensure that the correct client type is returned for each client.
ms.custom: na
ms.date: 02/26/2024
ms.reviewer: na
ms.topic: troubleshooting
author: SusanneWindfeldPedersen
ms.author: solsen
---

# Troubleshoot client returns wrong CLIENTTYPE

## Prerequisites

First you must check that the environment meets the prerequisites for the mobile app. For more information, see [Preparing the environment](/dynamics365/business-central/dev-itpro/deployment/install-business-central-app#prereqs).

## Symptoms

Running, for example, the [!INCLUDE[nav_tablet](includes/nav_tablet_md.md)] and the [!INCLUDE[nav_phone](includes/nav_phone_md.md)] simultaneously in the same browser session will return the same `CLIENTTYPE`.

## Resolution

If you have implemented code that checks for the `CURRENTCLIENTTYPE`, you must run each of the different clients in separate browser windows to make sure that the correct client type is returned for each of the clients.  
  
## Next steps

[Designing for Different Screen Sizes on Tablet and Phone](devenv-designing-different-screen-sizes-tablet-and-phone.md)   
[CurrentClientType Method](methods-auto/session/session-currentclienttype-method.md)   
[DefaultClientType Method](methods-auto/session/session-defaultclienttype-method.md)