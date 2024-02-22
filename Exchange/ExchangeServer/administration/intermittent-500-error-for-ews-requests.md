---
title: Intermittent 500 error for EWS requests
description: Discusses an intermittent 500 error that occurs in an Exchange Server 2013 and 2007 coexistence environment. Provides a resolution.
ms.date: 01/24/2024
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: Normal
ms.custom: 
  - Exchange Server
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Server 2013 Standard Edition
  - Exchange Server 2013 Enterprise
search.appverid: MET150
---
# Intermittent 500 error occurs for EWS requests in an Exchange Server 2013 and 2007 coexistence scenario

_Original KB number:_ &nbsp; 3152392

## Symptoms

Consider the following scenario:

- You deploy Exchange Server 2013 and Exchange Server 2007 in a coexistence environment.
- Either of the following conditions are true:

  - You don't configure a [legacy namespace](/previous-versions/exchange-server/exchange-150/dn130105(v=exchg.150)) for Exchange Server 2007 EWS traffic.
  - You configure a legacy namespace, but you don't configure your EWS application to utilize Autodiscover.

In this scenario, you intermittently receive **500** error responses from the Exchange Server 2013 mailbox role for EWS traffic that is directed toward mailboxes that are hosted on Exchange Server 2007. These responses can be identified in the Internet Information Services (IIS) log and HttpProxy log of the Exchange Server 2013 Client Access server (CAS) role.

## Resolution

To resolve or avoid this problem, you must use a legacy namespace. We strongly recommended that you use Autodiscover. Otherwise, the decision to use the Exchange Server 2013 namespace or the Exchange Server 2007 legacy namespace based on the location of the mailbox would involve a manual effort that will add to administrative overhead.

## More information

In an Exchange Server 2013 and Exchange Server 2007 coexistence configuration, legacy namespaces are required for both EWS and OWA services for client connectivity. The proxying of EWS traffic from the Exchange 2013 mailbox server to the Exchange 2007 CAS is unsupported and will cause inconsistent results.

OWA uses silent redirection to the legacy namespace. However, EWS does not support silent redirection. Therefore, the default behavior for Exchange Server 2013 is to proxy the traffic that is directed to legacy servers. While this works as expected for Exchange Server 2010 EWS traffic, it is not reliable in Exchange Server 2007. Instead, you should manually redirect the EWS client traffic to the legacy namespace.

## References

- For more information about client connectivity in an Exchange Server 2013 coexistence environment, see [Client Connectivity in an Exchange 2013 Coexistence Environment](https://techcommunity.microsoft.com/t5/exchange-team-blog/client-connectivity-in-an-exchange-2013-coexistence-environment/ba-p/587265).
- For more information about namespace planning in Exchange Server 2013, see [Namespace Planning in Exchange 2013](https://techcommunity.microsoft.com/t5/exchange-team-blog/namespace-planning-in-exchange-2013/ba-p/587472).
- For more information about Legacy namespaces in Exchange 2013, see [Create a legacy Exchange host name](/previous-versions/exchange-server/exchange-150/dn130105(v=exchg.150)).
