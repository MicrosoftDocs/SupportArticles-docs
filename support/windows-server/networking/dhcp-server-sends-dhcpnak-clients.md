---
title: DHCP Server sends a DHCPNAK to clients
description: Provides a solution to an issue when you start a Dynamic Host Configuration Protocol (DHCP) client.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, prasadk
ms.custom: sap:dynamic-host-configuration-protocol-dhcp, csstroubleshoot
ms.subservice: networking
---
# DHCP Server with Deactivated Scope sends a DHCPNAK to clients

This article provides a solution to an issue when you start a Dynamic Host Configuration Protocol (DHCP) client.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 228597

## Symptoms

When you start a Dynamic Host Configuration Protocol (DHCP) client, it tries to renew its lease on an existing IP address for its scope (Requesting state). Or in the case of the client never having an address, it will try to obtain a lease for an IP address for its scope (Initializing state). In the case where there are two or more DHCP servers on the network configured to service this segment, and a DHCP server has the scope for this segment disabled, the client may receive a negative acknowledgment (DHCPNAK) from the DHCP server with the disabled scope. If the client is running Windows NT Server or Workstation, the DHCPNAK would cause an event to be logged to the Windows NT System Event log. It will also increase network traffic and cause the client to needlessly fall back to an Initializing state.

Previous to Windows NT 4.0 Service Pack 4, this behavior wasn't present. It applies to Windows NT 4.0 Service Pack 5 as well.

## Resolution

- Windows NT Server or Workstation 4.0

    To resolve this problem, obtain the latest service pack for Windows NT 4.0 or the individual software update.

    For information on obtaining the individual software update, contact Microsoft Product Support Services.

- Windows NT Server 4.0, Terminal Server Edition

To resolve this problem, obtain the latest service pack for Windows NT Server 4.0, Terminal Server Edition.

## Status

Microsoft has confirmed that it's a problem in the Microsoft products that are listed at the beginning of this article. This problem was first corrected in Windows NT Server version 4.0, Terminal Server Edition Service Pack 6.

## More information

Administrators find that configuring two DHCP servers for the same scope then disabling one is an easy way to provide limited fault tolerance.

When the server with the active scope is unavailable, the DHCP server with the deactivated scope will assume the responsibilities for the DHCP clients of that scope.
