---
title: On-premises users not getting emails from Microsoft 365
description: Describes an issue in which on-premises users aren't getting email messages from Office 365 users in an Exchange hybrid deployment. Provides a resolution.
author: simonxjx
ms.author: v-six
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Hybrid
- CSSTroubleshoot
ms.reviewer: jhayes
appliesto:
- Exchange Online 
search.appverid: MET150
---
# On-premises users can't get email messages from Microsoft 365 users in an Exchange hybrid deployment

_Original KB number:_ &nbsp; 2730609

## Symptoms

You have a Microsoft Exchange hybrid deployment in which cloud-based users in Microsoft 365 and on-premises users have the same email namespace (such as `alias@contoso.com`). However, on-premises users aren't getting email messages from Microsoft 365 users.

Additionally, when a Microsoft 365 user sends an email message to an on-premises user, the Microsoft 365 user receives a nondelivery report (NDR) error message that resembles the following:

> #550 5.1.1 RESOLVER.ADR.ExRecipNotFound; not found ##

## Resolution

This occurs if the domain that's set up in the hybrid deployment isn't set as a shared domain in Microsoft 365. To fix this issue, set up the domain as a shared domain. To do this, follow these steps:

1. Sign in to the [Microsoft 365 portal](https://portal.office.com/) as a global admin.
2. Select **Admin**, and then select **Exchange** to open the Exchange admin center.
3. In the left navigation pane of the Exchange admin center, select **mail flow**, and then select **accepted domains**.
4. Double-click the domain that's set up for the hybrid deployment.
5. Select **Shared**, and then select **save**.

## More information

The Exchange admin center lists the domains that you added to your account through the Microsoft 365 portal. It lets you manage how messages are delivered. In a hybrid scenario, Exchange Online must be set up correctly so that when a cloud-based user sends an email message to an on-premises user, Exchange Online routes the email message to the on-premises messaging environment.

For more information about accepted domains, see [Accepted domains in Exchange Server](/Exchange/mail-flow/accepted-domains/accepted-domains)

For more information about hybrid deployment, see [Exchange Server Deployment Assistant](/exchange/exchange-deployment-assistant?view=exchserver-2019&preserve-view=true)

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
