---
title: On-premises users not getting emails from Microsoft 365
description: Describes an issue in which on-premises users aren't getting email messages from Microsoft 365 users in an Exchange hybrid deployment. Provides a resolution.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: jhayes, v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 08/13/2024
---
# On-premises users can't get email messages from Microsoft 365 users in an Exchange hybrid deployment

_Original KB number:_ &nbsp; 2730609

## Symptoms

You have a Microsoft Exchange hybrid deployment in which cloud-based users in Microsoft 365 and on-premises users have the same email namespace (such as `alias@contoso.com`). However, on-premises users aren't getting email messages from Microsoft 365 users.

Additionally, when a Microsoft 365 user sends an email message to an on-premises user, the Microsoft 365 user receives a nondelivery report (NDR) error message that resembles the following:

> #550 5.1.1 RESOLVER.ADR.ExRecipNotFound; not found ##

## Resolution

This occurs if the domain that's set up in the hybrid deployment isn't set as an internal relay domain in Microsoft 365. To fix this issue, set up the domain as an internal relay domain:

1. Sign in to the [Exchange admin center](https://admin.exchange.microsoft.com) as a Microsoft 365 Exchange administrator.
2. Go to **Mail flow** > **Accepted domains**.
3. Select the domain that's set up for the hybrid deployment, and then select **Edit**.
4. In the **Accepted Domain** window, in the **This accepted domain is** section, select **Internal relay** as the domain type.
5. When you're finished, select **Save**.

## More information

The Exchange admin center lists the domains that you added to your account through the Microsoft 365 portal. It lets you manage how messages are delivered. In a hybrid scenario, Exchange Online must be set up correctly so that when a cloud-based user sends an email message to an on-premises user, Exchange Online routes the email message to the on-premises messaging environment.

For more information about accepted domains, see [Accepted domains in Exchange Server](/Exchange/mail-flow/accepted-domains/accepted-domains)

For more information about hybrid deployment, see [Exchange Server Deployment Assistant](/exchange/exchange-deployment-assistant?view=exchserver-2019&preserve-view=true)
