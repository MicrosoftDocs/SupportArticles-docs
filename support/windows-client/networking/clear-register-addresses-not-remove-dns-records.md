---
title: Clearing the "Register This Connection's Addresses in DNS" Option Doesn't Remove DNS Records
description: Provides a resolution to an issue in which a client doesn't remove its Domain Name System (DNS) records from the server after you clear the Register this connection's addresses in DNS checkbox on the client computer.
ms.date: 07/25/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, v-lianna
ms.custom:
- sap:network connectivity and file sharing\dns
- pcy:WinComm Networking
---
# Clearing the "Register this connection's addresses in DNS" option doesn't remove DNS records for Windows clients using static IP addresses

## Symptoms

After you clear the **Register this connection's addresses in DNS** checkbox on a client computer, the client doesn't remove its Domain Name System (DNS) records from the server. For more information about the setting, see the following screenshot:

:::image type="content" source="media/clear-register-addresses-not-remove-dns-records/register-connection-address-dns.png" alt-text="Screenshot of the Advanced TCP/IP Settings window with the Register this connection's addresses in DNS unchecked.":::

## Resolution

To resolve the issue, follow these steps according to the client computer's configuration.

### For client computers that are configured to use a static IP address

If the client computer is using a static IP address, follow these steps on the client computer to remove the record from the DNS server:

1. Clear the **Register this connection's addresses in DNS** checkbox.
2. Trigger the registration of the DNS record. To do this, use one of the following steps, which are listed in the order of preference:

    - Restart the DNS Client service.
    - Restart the Windows-based computer.
    - Open a command prompt window as administrator, and then run the `ipconfig /registerdns` command.

> [!NOTE]
> If one or more adapters on a multi-homed client or server are configured by using a Dynamic Host Configuration Protocol (DHCP) address, see the last note in the "For client computers that are configured to use a dynamic IP address" section.

### For client computers that are configured to use a dynamic IP address

If you configure the client computer to obtain anIP address by using DHCP, the client or DHCP server will try to remove dynamically registered records after you clear the **Register this connection's addresses in DNS** checkbox.

> [!NOTE]
> After you clear the **Register this connection's addresses in DNS** checkbox on the DNS tab of the **Advanced TCP/IP Settings** property window of either TCP/IPv4 or TCP/IPv6, the following node is deleted from that computer's local registry:
>
> `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\DNSRegisteredAdapters\{<36 character GUID corresponding to the network adapter that TCPIP was bound to>}`
>
> This applies to both clients that use static IP addresses and clients that use dynamic IP addresses.

> [!NOTE]
> If an adapter is configured to use dynamic IP addressing (DHCP) on the computer, don't run the `ipconfig /registerdns` command. Dynamic IP addressing uses a DHCP server to register "PTR" records and optionally Host "A" and "AAAA" records on behalf of DHCP clients. DHCP server configuration determines how "A" and "AAAA" registrations are added. After you run the `ipconfig /registerdns` command, the DNS records are registered by using the local machine's security descriptor. This prevents the DHCP server from updating those records until the record is manually removed. Restated, if the DHCP server doesn't have the permission to update the DNS record, the DHCP registration silently fails.

For DHCP clients, we recommend that you follow these steps:

1. Restart the "DNS Client" service. To do this, run the following commands:

    ```console
    net stop DNSCACHE
    net start DNSCACHE
    ```

2. Run the following commands to update DNS registrations for DHCP clients:

    ```console
    ipconfig /release
    ipconfig /renew
    ```

For more information, see:

- [DNS Processes and Interactions](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd197552(v=ws.10)).
- [General information about IPv4 and IPv6 advanced DNS tab](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754143(v=ws.11)).

## More Information

To determine whether a network adapter is using static an IP address or a dynamic IP address, follow these steps:

1. Open a command prompt window.
2. Run the `ipconfig /all` command.
3. In the returned result, if the **DHCP Enabled** field under the network adapter is displayed as **Yes**, the network adapter is using a dynamic IP address. If it's displayed as **No**, the network adapter is using a static IP address.
