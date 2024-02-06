---
title: Dynamic updates of DNS registrations are delayed
description: Discusses that a change in the DHCP DNS update behavior in Windows Server 2008 and later versions may delay DNS Registration. Provides a resolution.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-jesits
ms.custom: sap:dynamic-host-configuration-protocol-dhcp, csstroubleshoot
---
# DHCP dynamic updates of DNS registrations are delayed or not processed

This article discusses that a change in the DHCP Domain Name System (DNS) update behavior may delay DNS registrations and provides help to solve this issue.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 3069564

## Symptoms

Dynamic updates of DNS registrations that are performed by the DHCP server on behalf of a DHCP-enabled computer take a long time to process or are not processed after the DHCP service runs for a while.

Additionally, a fountain pen icon appears next to the lease record in DHCP. This icon indicates that the DNS registration is incomplete.

By default, the DHCP server registers the PTR records for dynamic update-aware clients. The PTR records may be the records that do not update in DNS and that cause reverse DNS lookups to fail.

## Cause

In versions of Windows Server that are earlier than Windows Server 2008, the DHCP server uses the DNS servers that are configured in the TCP/IP properties of the network connections as the target of the dynamic updates.

A change in the DHCP dynamic update behavior causes DHCP servers in Windows Server 2008 and later versions to select a DNS server by the following criteria in the given order:

- Scope options
- Server options
- TCP/IP configuration of the network connections

Assume that a scope is configured to have DHCP scope options and that DNS servers are configured. In this situation, the DNS servers that are specified in the scope options will be used as the target DNS servers by the DHCP server for dynamic updates for lease records from that scope.

If the DNS servers that are specified for the scope do not support dynamic updates, the update fails. The DHCP server retries several times to register the failing update. In the meantime, other dynamic updates are put into a queue for processing. Therefore, pending updates are delayed and registrations are not processed in a timely manner.

## Resolution

To prevent failing updates and delayed pending updates, specify DNS servers that support dynamic updates at the appropriate level.

## Workaround

Use the following registry value to override the default behavior in Windows Server.

> [!NOTE]
> This method works for IPv4 scopes only. This value lets you specify the DNS server that should be used for dynamic updates. This overrides the default functionality for all scopes and causes DHCP to use only the specified DNS server for all IPv4 dynamic updates.

`HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\DHCPServer\Parameters\AlternateDnsServer\IP_ADDRESS (Reg_Sz)`

## More information

At least one administrator has reported successfully preventing a delay in DNS updates registration by selecting the **Always dynamically update DNS A and PTR records** option on the DHCP server. We do not consider this action to be a viable workaround, and we have not determined why it might be effective. However, you might find this information helpful.
