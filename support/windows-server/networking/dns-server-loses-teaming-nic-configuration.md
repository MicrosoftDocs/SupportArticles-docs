---
title: DNS server loses its NIC Teaming configuration
description: Describes an issue in which a DNS server that's configured to use NIC Teaming reverts to using physical adapters after the computer restarts.
ms.date: 02/08/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, v-tappelgate
ms.custom: sap:dns, csstroubleshoot
ms.subservice: networking
keywords: DNS, listen, IP address, restart, ListenAddresses
---

# DNS server reverts to listening on all IP addresses instead of the configured NIC Teaming IP address

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016

## Symptoms

Consider the following scenario:  

- The DNS server computer has multiple network adapters that you use in a NIC Teaming configuration.
- You configure the DNS server to listen on the IP address of the teaming network adapter. 
- On the **Interfaces** tab of the DNS server properties dialog box in DNS Manager, you can configure the IP address that you want to use.

:::image type="content" source="./media/dns-server-loses-teaming-nic-configuration/dc-properties-interfaces.png" alt-text="Screenshot of the DNS server properties that shows a specific IP address on the Interfaces tab.":::  

In this scenario, when you set this configuration, Windows stores it in a registry value under the `HKLM\SYSTEM\CurrentControlSet\Services\DNS\Parameters\ListenAddresses` subkey.

After you restart the DNS server, Windows deletes both the setting and the registry value. The DNS server starts listening on all IP addresses again.

When this change occurs, Windows logs Event ID 410 in the DNS server event log:

> The DNS server list of restricted interfaces does not contain a valid IP address for the server computer. The DNS server will use all IP interfaces on the machine. Use the DNS manager server properties, interfaces dialog, to verify and reset the IP addresses the DNS server should listen on. For more information, see "To restrict a DNS server to listen only on selected addresses" in the online Help.

## Cause

As indicated by DNS Event ID 410, this behavior is expected.

When the DNS server starts, it checks the IP addresses of the available network adapters and notes that none of the addresses match the configured NIC Teaming address. Because of this mismatch, the DNS server determines that the configuration isn't valid. The DNS server then deletes the configuration, and reverts to listening on all available IP addresses.

NIC Teaming isn't available until after the physical adapters have come online. The issue occurs because the **DNS Server** service starts after the physical adapters come online. However, it doesn't wait for NIC Teaming adapter to become available.

## Resolution

To resolve this issue, change the startup type of the **DNS Server** service to **Automatic (Delayed Start)**. This setting delays the startup of the service so that the NIC Teaming adapter is available.
