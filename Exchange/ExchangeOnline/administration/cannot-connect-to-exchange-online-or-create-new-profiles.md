---
title: Cannot connect to Exchange Online or create new profiles
description: Resolves Outlook connectivity issues that occur if a user is located in a restricted network environment that blocks port 443 in Microsoft 365.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:Administrator Tasks
  - Exchange Online
  - CSSTroubleshoot
ms.reviewer: v-six
appliesto: 
  - Exchange Online
search.appverid: MET150
ms.date: 01/24/2024
---
# Outlook can't connect to Exchange Online or a user can't create new Outlook profiles in Microsoft 365

_Original KB number:_ &nbsp; 2879429

## Symptoms

In Microsoft 365, a user experiences one of the following issues:

- Outlook can't connect to Exchange Online.
- The user can't create new Outlook profiles.

## Cause

Local network configuration issues may prevent access to Exchange Online servers, as in the following scenarios.

### Scenario 1

The user is located in a restricted network environment that blocks port 443. To enable the following features, port 443 must be open:

- Exchange Autodiscover service: this service sets up Outlook profiles.
- Outlook Anywhere feature: this feature lets Outlook communicate with Exchange Online.

### Scenario 2

Network proxy configuration redirects clients to one particular Microsoft 365 IP address range or URL.

## Resolution for scenario 1

To resolve this issue, open port 443 in the network environment through which the user accesses Outlook and Exchange Online.

Restricted network access may affect all the Microsoft 365 connectivity. For more information about the ports that are used in Microsoft 365, the addresses ranges, and ports that are used in Exchange Online, see [Microsoft 365 URLs and IP address ranges](/microsoft-365/enterprise/urls-and-ip-address-ranges?view=o365-worldwide&preserve-view=true).

## Resolution for scenario 2

Local Domain Name System (DNS) resolvers and related firewall applications at users' ISPs and corporate networks should never prune the DNS results lists. Instead, they should provide all results to clients to enable application retries. Additionally, Local Domain Name System (LDNS) resolvers and proxy servers shouldn't use any kind of persistent or IP affinity behavior that prefers a single IP address. That kind of behavior my affect performance by prohibiting client retry operations.

To achieve the highest availability, Microsoft 365 uses an array of IP address for DNS queries. Multiple results are provided to give the client applications several endpoints to try, all with equivalent functionality.

This article is intended only to address local network configuration issues that prevent Outlook from connecting to Exchange Online.

Still need help? Go to [Microsoft Community](https://answers.microsoft.com/).
