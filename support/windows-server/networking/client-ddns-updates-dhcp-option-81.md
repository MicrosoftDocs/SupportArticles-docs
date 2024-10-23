---
title: Client machines don't send DDNS updates
description: Helps resolve the issue in which Windows client machines don't send DDNS updates when the DHCP server stops sending Option 81 in REQ-ACK packets of the DHCP response.
ms.date: 10/23/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, hichauhan, v-lianna
ms.custom: sap:Network Connectivity and File Sharing\Dynamic Host Configuration Protocol (DHCP), csstroubleshoot
---
# Client machines don't send DDNS updates when DHCP server stops sending Option 81

This article helps resolve the issue in which Windows client machines don't send dynamic Domain Name System (DNS) updates when the Dynamic Host Configuration Protocol (DHCP) server stops sending Option 81 (also known as the client FQDN option) in DHCPREQUEST (REQ) and DHCPACK (ACK) packets of the DHCP response.

You have a DHCP server that is leasing out IP addresses to client machines, and you have enabled the Option 81 configuration from the DHCP server side. Option 81 is configured to perform dynamic DNS (DDNS) updates for the incoming DHCP client requests. With this configuration, the DHCP server performs the DDNS updates for clients and always sends Option 81 back to the client.

> [!NOTE]
> The configuration on the DHCP server is set to:
>
> - Always dynamically update DNS records
> - Discard A and PTR records when lease is deleted
> - Dynamically update DNS records for DHCP clients that do not request updates (for example, clients running Windows NT 4.0)

A client machine continuously runs and keeps performing the REQ-ACK process (without completing the DORA process) for the IP address lease extension according to the DHCP lease time. The DHCP renewal ideally occurs at 50% and 87.5% of the lease duration.

> [!NOTE]
> DORA stands for Discover, Offer, Request, and Acknowledge.

When the DHCP server stops sending Option 81, the client machine assumes the DHCP server is still handling DDNS updates and doesn't trigger updates itself as expected. Even if you restart the client machine (considering the lease isn't completely expired), the client machine doesn't perform DDNS updates on REQ-ACK packets.

Therefore, the DNS record won't be populated as neither the DHCP server nor the client machine updates the record. If the DNS scavenging is enabled, the record might be deleted for the impacted machine.

## Client machine doesn't receive Option 81 and relies on cache

The client machine updates and caches the DHCP Option 81 configuration received from the DHCP server within the ACK frame. This update happens every time an ACK is back from the DHCP server with Option 81 attached. This cache is stored in the following registry value:

`Computer\HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{Interface GUID}\DCHPInterfaceOptions`

> [!IMPORTANT]
> Don't make any change to this registry, as the registry contains information that should not be manually changed.

The client machine doesn't receive Option 81, so it has nothing to update and relies completely on cache.

## The client machine needs to perform a complete DORA process

To fix this issue, the client machine needs to perform a complete DORA process to update the cache. The DORA process can be initiated by one of the following methods:

- Make the client machine's IP address expire. For example, turn off the operating system for the lease duration.
- Run the `ipconfig /release` and `ipconfig /renew` commands on the machine.
- Run a script to set a device to manually register the DNS using the `ipconfig /registerdns` command.
