---
title: Power Automate approval email information
description: Describes the information about Power Automate approval emails.
ms.reviewer: mansong, hamenon
ms.date: 07/06/2023
ms.subservice: power-automate-flows
---
# Power Automate approval email delivery information

This article describes the information about Power Automate approval emails.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4559558

## Overview

Approval emails are sent from outside of the organization boundary and routed to the email domain of the specified recipient. Which is to ensure that all organizational policies for inbound mail are respected.

For customers whose MX record points at another filtering service (for instance, Proofpoint or Mimecast), messages will be routed to those services first per MX routing priorities, and not directly to Office 365 or on-premises mailboxes.

## Commercial

For commercial Power Automate (all geos), approval emails may come from any IP in the following Sender Policy Framework (SPF) record. We always recommend allowing the SPF record to be listed instead of individual IP addresses to make sure your emails aren't impacted.

> [!NOTE]
> SPF records can be updated when more servers and regions are added. For the most up-to-date IP address ranges, you can look up the SPF record for `_spf1-meo.microsoft.com`.

```output
v=spf1 ip4:52.165.175.144 ip4:52.247.53.144 ip4:157.55.254.216 ip4:13.74.143.28 ip4:104.214.25.77 ip4:207.46.225.107 ip4:51.137.58.21 ip4:138.91.172.26 ip4:52.250.107.196 ip4:13.92.31.129 ip4:51.144.100.179 ip4:52.160.39.140 ip4:52.244.206.214 ip4:13.72.50.45 ip4:20.118.139.208/30 ip4:20.98.194.68/30 ip4:20.83.222.104/30 ip4:20.88.157.184/30 ip4:20.59.80.4/30 ip4:20.51.6.32/30 ip4:20.97.34.220/30 ip4:20.107.239.64/30 ip4:20.105.209.76/30 ip4:20.98.148.156/30 ip4:20.69.8.108/30 ~all
```

All approval emails will be sent with a sender address of `flow-noreply@microsoft.com`.

## Sovereign Clouds

For US Government (GCC), US Government (GCC High), and US Department of Defense (DoD) regions for Power Automate, approval emails may come from any of the following IPs:

- 52.244.206.214
- 13.72.50.45

Approval emails will be sent in these environments with a sender address of `flow-noreply@microsoft.com`.

## China

Approval emails may come from any of the following IPs:

- 40.73.102.218
- 139.217.96.195

All approval emails will be sent with a sender address of `flow-noreply@oe.21vianet.com`.
