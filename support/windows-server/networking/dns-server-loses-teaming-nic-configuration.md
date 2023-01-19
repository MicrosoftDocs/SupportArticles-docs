---
title: DNS server reverts to listening on all IP addresses instead of the configured teaming NIC IP address
description: Describes an issue where a DNS server that's configured to use a teaming NIC reverts to using physical NICs after the computer restarts.
ms.date: 1/26/2023
author: v-tappelgate
ms.author: v-tappelgate
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.prod: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: <sap/see CI>
ms.technology: networking
keywords: DNS, listen, IP address, restart, ListenAddresses
---

# DNS server reverts to listening on all IP addresses instead of the configured teaming NIC IP address

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016

## Symptoms

Consider the scenario where the DNS server computer has multiple network adapters that you use in a teaming NIC configuration. You've configured the DNS server to listen on the IP address of the teaming NIC. You can configure the IP address to use in DNS Manager, on the **Interfaces** tab of the DNS server properties:  

:::image type="content" source="./media/dns-server-loses-teaming-nic-configuration/dc-properties-interfaces.png" alt-text="Screenshot of the DNS server properties that shows a specific IP address on the Interfaces tab.":::  

When you set this configuration, Windows stores it in a registry value under the **HKLM\System\CurrentControlSet\Services\DNS\Parameters\ListenAddresses** subkey.

After you restart the DNS server, Windows deletes both the setting and the registry value. The DNS server starts listening on all IP addresses again.

When this change occurs, Windows logs the following event in the DNS server event log:

> Event 410: The DNS server list of restricted interfaces does not contain a valid IP address for the server computer. The DNS server will use all IP interfaces on the machine. Use the DNS manager server properties, interfaces dialog, to verify and reset the IP addresses the DNS server should listen on. For more information, see "To restrict a DNS server to listen only on selected addresses" in the online Help.

## Cause

As indicated by DNS Event 410, this behaviour is expected.

When the DNS server starts, it checks the IP addresses of the available NICs and notes that none of the addresses match the configured teaming NIC address. Because of this mismatch, the DNS server determines that the configuration is not valid. The DNS server deletes the configuration and reverts to listening on all available IP addresses.

The teaming NIC is not available until after the physical NICs have come online. The problem is that the **DNS Server** service starts after the physical NICs come online, but it doesn't wait for the teaming NIC to become available.

## Resolution

To resolve this issue, change the startup type of the **DNS Server** service to **Automatic (Delayed Start)**. This delays the startup of the service so that the teaming NIC is available.
