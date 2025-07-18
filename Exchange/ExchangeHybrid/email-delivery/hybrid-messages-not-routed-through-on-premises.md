---
title: Messages aren't routed through on-premises in hybrid
description: Describes a by-design behavior in which some messages aren't routed through the on-premises organization when you use centralized mail transport in a hybrid deployment.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Mail Flow
  - Exchange Hybrid
  - CSSTroubleshoot
ms.reviewer: joelric, v-six
appliesto: 
  - Exchange Online
  - Exchange Online Protection
  - Exchange Server 2016 Enterprise Edition
  - Exchange Server 2016 Standard Edition
  - Exchange Server 2013 Enterprise
  - Exchange Server 2013 Standard Edition
search.appverid: MET150
ms.date: 01/24/2024
---
# Some messages aren't routed through the on-premises organization when you use centralized mail transport

_Original KB number:_ &nbsp; 3194415

## Problem

Consider the following scenario:

- You have a hybrid deployment of on-premises Microsoft Exchange Server and Exchange Online.
- You configured the outbound send connector in Exchange Online to use a remote domain of "*", and you enabled centralized mail transport on that connector.
- A user or application in the on-premises organization sends an email message to a mailbox that's hosted in Exchange Online, for example, *bill@contoso.com*. And the Exchange Online recipient, *bill@contoso.com*, has a forwarding SMTP address that's set to an external recipient (*bill@tailspintoys.com*).

In this scenario, the message tracking logs show the message that was forwarded to *bill@tailspintoys.com* isn't routed back through the on-premises organization, as expected. Instead, the message is sent directly through Exchange Online Protection.

## More information

This behavior is by design. To forward the message, an exact copy of the original message is created and sent to the external recipient. Mail routing logic sees that this new message originated in the on-premises environment and therefore doesn't send the message back to the on-premises environment. Instead, it's routed directly to the external recipient domain through Exchange Online Protection.

This behavior also applies to other similar scenarios. For example, email is sent from on-premises to a distribution group hosted in Exchange Online, and there is an external recipient in the distribution group. In this scenario, email sent to that external recipient will be routed directly instead of following centralized mail routing, because the message originates from the on-premises environment.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com) or the [Exchange TechNet Forums](https://social.technet.microsoft.com/forums/exchange/home?category=exchange2010%2cexchangeserver).
