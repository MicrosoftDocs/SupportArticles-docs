---
title: Access Denied when you visit Microsoft websites hosted on Akamai CDN
description: When you visit certain Microsoft websites, you may be denied access if you or your organization makes too many connections attempts too quickly. This article provides a solution to this problem.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:tcp/ip-communications, csstroubleshoot
---
# Error message when you visit a Microsoft website that is hosted on Akamai CDN: Access Denied

This article provides a solution to an issue where you receive an "Access Denied" message when you go to certain Microsoft websites that are hosted by the Akamai content delivery network (CDN).

_Applies to:_ &nbsp; Windows Server 2016, Windows 10 - all editions  
_Original KB number:_ &nbsp; 4492050

## Symptoms

When you go to a Microsoft website that is hosted by the Akamai CDN, you frequently receive an "Access Denied" message that resembles the following:

> Access Denied  
You don't have permission to access `http://www.microsoft.com` on this server.  
Reference #18.85c5d617.1549635923.277a7a1

> [!NOTE]
> In this message, the URL value is the URL of the site the user tried to reach and the reference number is a unique identifier for that user and access attempt.

Examples of common CDN-hosted Microsoft websites include but aren't limited to the following:

- `www.microsoft.com`
- `support.microsoft.com`
- `oneapi.microsoft.com`
- `products.office.com`
- `partner.microsoft.com`
- `visualstudio.microsoft.com`
- `www.xbox.com`
- `technet.microsoft.com`
- `msdn.microsoft.com`
- `privacy.microsoft.com`
- `account.microsoft.com`
- `developer.microsoft.com`

## Cause

This issue occurs because of the measures that Akamai has implemented to protect its websites from denial-of-service attacks. If a single origin or source tries to connect too frequently, these measures automatically block any IP addresses from that origin or source. The exact thresholds that are used to determine when to block addresses are based on connection volume.

The blockage is usually temporary. As soon as the connection volume remains below the defined thresholds for a while, the block on the affected TCP/IP address is expected to be removed.

## Resolution

To resolve this issue, make sure that you (or your organization) are not trying to connect to these websites too frequently within a short time.

For example, this issue can occur in an enterprise environment that uses devices that test network connectivity. Such a device tests Internet connectivity from an internal network by connecting to one or more Internet addresses that are considered reliable and responsive (such as Microsoft websites). The device reconnects to these sites at an interval that is set by the enterprise administrator. If that interval is too short, the protection measures on the Akamai CDN may identify the device as a potential threat and then block it. To fix the issue, the enterprise administrator may have to only reduce the recurrence interval of the test connections.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
