---
title: You can't migrate a Yammer network across Office 365 tenants
description: Describes an issue in which you can't migrate a Yammer network across Office 365 tenants.
author: simonxjx
manager: willchen
audience: ITPro
ms.service: sharepoint-online
ms.topic: article
ms.author: v-six
---

# Cannot migrate a Yammer network across Office 365 tenants

## Problem

You plan to add or migrate a network domain from one Office 365 tenant to another Office 365 tenant, or you have already done this. Now, you want to associate your Yammer network, which is mapped from the domain of your original tenant, with your new tenant. In this situation, you may experience one or more of the following symptoms:

- Users in specific domains cannot sign in to a Yammer network when they use their Office 365 sign-in for Yammer.

- You want to migrate a network to your Yammer primary network. However, the domain doesn’t appear in the Network Migration Wizard.

## Solution

This is expected behavior. Migrating Yammer networks across Office 365 tenants isn't supported. For more information, see the following Microsoft websites:

- The "Network migration" section of [Administration and security features in Yammer](https://technet.microsoft.com/library/administration-and-security-features-in-yammer.aspx).

- [Yammer admin help](https://docs.microsoft.com/yammer/yammer-landing-page?redirectSourcePath=%252fen-us%252farticle%252fmanage-the-yammer-service-in-office-365-f1629b2c-5b22-4375-b1db-8b9c2cd5ca3c)

## More information

You can consolidate multiple Yammer networks, when the domains are verified in the same tenant. For more information, see [Network migration - Consolidate multiple Yammer networks](https://docs.microsoft.com/yammer/configure-your-yammer-network/consolidate-multiple-yammer-networks).
