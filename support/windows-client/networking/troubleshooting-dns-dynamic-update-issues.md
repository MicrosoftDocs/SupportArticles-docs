---
title: Troubleshooting DNS dynamic update issues
description: Introduces the troubleshooting suggestions for DNS dynamic update issues.
ms.date: 10/22/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom: sap:Network Connectivity and File Sharing\DNS, csstroubleshoot
---
# Troubleshooting DNS dynamic update issues

This guide addresses common issues related to domain name system (DNS) dynamic updates, and provides the relevant troubleshooting steps. Dynamic updates are crucial for maintaining accurate DNS records, especially in environments where IP addresses change frequently, such as Dynamic Host Configuration Protocol (DHCP). The guide covers common scenarios, recommendations, and troubleshooting tips for DNS clients, DHCP servers, and DNS servers.

## General causes

Here are the general causes of dynamic update failures:

- The DNS client doesn't send dynamic updates.
- DHCP is supposed to update the record, but that functionality isn't working as expected.
- The DNS server doesn't update the record due to permissions issues.

Before troubleshooting, we recommend that you implement the following best practices.

## Microsoft standard recommendations

### Client-side DNS registration

In many environments, DHCP updates the DNS record on behalf of the client. Given the hybrid nature of the infrastructure these days and employees using virtual private networks (VPNs) to connect to the office, there's often more than one IP associated with one endpoint. This situation can be avoided if the client registers its records. Thus, the recommendation is not to use DHCP option 81 and instead let the client register its records.

For more information on how DHCP option 81 works, see the following two articles:

- [2.2.7 DHCPv4 Option Code 81 (0x51) - Client FQDN Option](/openspecs/windows_protocols/ms-dhcpe/e4c46e9d-5013-4ab0-9434-ccd11f1347f5)
- [Unexpected DNS record registration behavior if DHCP server uses "Always dynamically update DNS records"](../../windows-server/networking/dns-registration-behavior-when-dhcp-server-manages-dynamic-dns-updates.md) (This article mentions Windows DNS client behavior.)

### Configure dynamic updates as "Secure only"

The dynamic update on the domain zone should be configured as **Secure only**.

If client computers performing dynamic registration are domain-joined (which should be verified by the domain's administrator or solution architect), configure the domain zone to allow dynamic updates with **Secure only** to ensure consistent behavior on the dynamic registration.

### Enable timestamps for dynamic records

By default, dynamic records don't include a timestamp. When configuring zone properties, you can enable the **Scavenge Stale Records** option under the **Aging** section of the zone's properties dialog. Once this option is enabled, newly registered records include a timestamp.

The timestamps are required if you plan to scavenge stale records. Without a timestamp, a DNS record can't be compared to the current time and won't be considered stale, even if it was dynamically registered.

> [!NOTE]
> If you recently enabled the given option, the records that were registered before the change won't carry a timestamp or be scavenged.

### Scavenge settings for the DNS in an AD-integrated zone

The **Scavenge Stale Records** option in the zone's **Aging** properties ensures Active Directory (AD) objects to carry a timestamp. However, the actual scavenging of stale records occurs at the DNS server level, affecting all zones where this setting is enabled. For a detailed explanation of scavenging, see [DNS scavenging setup](../../windows-server/networking/dns-scavenging-setup.md).

The scavenging cycle is a low-priority thread of the DNS process, so it might not always run consistently. To maximize the chances of it running, configure scavenging on a domain controller (DC) DNS server in an AD-integrated zone environment that doesn't have critical roles, such as Flexible Single Master Operation (FSMO) roles, and especially avoid the Primary Domain Controller (PDC) emulator. Ideally, scavenging should be set up on a DC without any FSMO roles. If this configuration isn't possible, avoid configuring it on the PDC emulator.

### Maintain standard DNS zone permissions

Standard DNS zone permissions should remain intact.

In an AD-integrated zone setup, permissions follow a standard hierarchy similar to the New Technology File System (NTFS) or file systems. This means that if an account has permission to create, delete, or modify a zone and its child objects, it can perform these operations. By default, only Enterprise Admins (forest-wide) and Domain Admins (domain-wide) have these privileges.

When **Secure only** dynamic updates are enabled, an authenticated account (for example, a domain-joined computer) can update, delete, or modify a DNS record if the account is the owner of that record. This ensures that only the original creator of the record can modify or delete it, which is the intended behavior of secure only dynamic updates.

However, challenges can arise when a DHCP server updates DNS records on behalf of clients using the fully qualified domain name (FQDN) DHCP option (option 81). In such cases, inconsistencies might occur because DNS records updated by the DHCP server can't be modified by the original client, and vice versa.

As mentioned earlier, we recommend that client machines update their own DNS records rather than relying on the DHCP server. This is due to several reasons, and Microsoft has also implemented a design change to enforce this behavior. This change prevents the DHCP server from updating both A and PTR records for clients. To override this behavior, see [Unexpected DNS record registration behavior if DHCP server uses "Always dynamically update DNS records"](../../windows-server/networking/dns-registration-behavior-when-dhcp-server-manages-dynamic-dns-updates.md).

Ideally, the client should update its own DNS records. However, if a record was previously updated by the DHCP server, the actual client won't be able to modify it. To address this problem, some enterprises force the DHCP server to continue updating the client's records, which is strongly discouraged. 

The recommended approach is to allow the DHCP server or the scavenging process to remove the records. Once they're removed, the client can then update them.

### Separate the DHCP server from ADDS

The DHCP server should be hosted on a separate server, not on a DC running Active Directory Domain Services (ADDS).

In a secure update setup, the DHCP server uses its machine's domain account to register DNS records. When the DHCP server runs on a DC, it uses the DC's account to register records. This means that static records can be overwritten by the DHCP server if the FQDN option is enabled and the DHCP server isn't configured with a dedicated service account. This can cause issues like the unintended scavenging of static records.

To prevent such problems, the DHCP server should be configured with a service account and run on a separate server. For more information, see [How to configure DNS dynamic updates in Windows](../../windows-server/networking/configure-dns-dynamic-updates-windows-server-2003.md).

## Troubleshoot general and known issues

### Client-side issues

- The start of authority (SOA) isn't found.
- The client doesn't send dynamic updates. For more information, see [How to enable or disable DNS updates in Windows](../../windows-server/networking/enable-disable-dns-dynamic-registration.md).
- The client can't get the authentication ticket Transaction Signature(TSIG) from the DC.

### DHCP server issues

- The DHCP server doesn't send dynamic updates on behalf of the client.
- DHCP DNS update queue length. For more information, see [DHCP dynamic updates of DNS registrations are delayed or not processed](../../windows-server/networking/dhcp-dynamic-updates-of-dns-registrations-delayed.md).
- A conflict occurs when DHCP tries to update a client's record, as it's already registered with client's machine account. For more information, see [Unexpected DNS record registration behavior if DHCP server uses "Always dynamically update DNS records"](../../windows-server/networking/dns-registration-behavior-when-dhcp-server-manages-dynamic-dns-updates.md).

### DNS server issues

- Permission issues with DNS zones.
- Changes in the authenticated account settings at the DNS zone level.
- DHCP's configuration of the service account for dynamic updates.

## Troubleshoot DNS dynamic update issues

> [!NOTE]
> This multi-part section discusses various aspects from Windows client to the server that should be checked when such an issue occurs.

You need to begin with basic checks, such as determining whether the issue affects multiple clients, clients on the same subnet, or a specific client. This helps narrow down whether the problem lies with the client, the server, or the network. For an explanation of how DNS dynamic updates are triggered, including examples, see [How to configure DNS dynamic updates in Windows](../../windows-server/networking/configure-dns-dynamic-updates-windows-server-2003.md#how-windows-based-computers-update-their-dns-names).

After understanding the DNS dynamic updates, you can use the following checklist to ensure that the client's dynamics update settings are in place.

### DNS client-side checklist

Check if **Register this connection's addresses in DNS** is selected:

```powershell
#Get the list of interfaces that are up and connected.
$Adapters = Get-NetAdapter | Where-Object Status -eq Up

#If there's only one interface, the following command will work.
Get-DnsClient -InterfaceIndex $Adapters.ifIndex

#If more than one interface is active and up, you can use "Get-DNSClient" to see the registration status of all interfaces.
```

In the output, **RegisterThisConnectionsAddress** should be **True**. Change the value to **True** if it's **False**:

```powershell
#Get the list of interfaces that are up and connected.
$Adapters = Get-NetAdapter | Where-Object Status -eq Up

#If there's only one interface, the following command will work.
Set-DnsClient -RegisterThisConnectionsAddress $True -InterfaceIndex $Adapters.ifIndex
```

Verify the value by taking the `Get-DnsClient` output, and ensure that **RegisterThisConnectionsAddress** is set to **True**.

There's a Group Policy that can modify this behavior. By default, network interfaces are set to register their connections. However, an enterprise can use the **Dynamic update** group policy setting to control how a client sends DNS dynamic updates. The group policy is located at:

**Computer Configuration** > **Administrative Templates** > **Network** > **DNS Client** > **Dynamic update**

### DNS server-side checklist

#### Ensure the zone is writable

The domain where the client is dynamically registered must be a writable copy zone. This means the zone should contain an SOA record for the DNS server hosting it, and the client must be able to reach this server through the network.

There are typically two types of setups：

1. Client pointing to a cache-only DNS server: This DNS server doesn't host any domain zone but uses conditional forwarders or forwarders to point to the actual DNS server, which holds the zone (either writable or readable).
2. Simple setup: The client points directly to DNS servers that host the domain zone.

Option one is generally chosen for load balancing and a larger environment with many clients. The idea is to shift the load of name resolution from the available DCs to extra servers. However, in this setup, the client must have connectivity for DNS protocol to the server hosting the SOA record for the domain zone. Otherwise, the dynamic update will fail.

#### Allow dynamic updates

An AD-integrated DNS zone hosted on a Microsoft DNS server has three options for dynamic updates:

- **None**
- **Nonsecure and secure**
- **Secure only**

> [!NOTE]
> The last option is available only for AD-integrated DNS zones.

To allow dynamic updates, the zone should be configured with the **Nonsecure and secure** or **Secure only** update type. **Secure only** is recommended for AD-integrated zones.

#### Check DNS auditing

DNS Server logging is discussed in [DNS Logging and Diagnostics](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn800669(v=ws.11)). Specifically, it aims to verify if the records that you're concerned about are registered and can be tracked with DNS [Audit events](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn800669(v=ws.11)#audit-events), Event ID 519. You can filter the DNS audit events enabled by default with the given ID and verify if the record is successfully registered.

> [!NOTE]
> The Audit event log is local to the given DNS server, which means that the given ID will only be visible on the DNS server where the record is registered.

### Scenario: The DHCP server can't complete dynamic updates on behalf of the client, or the registrations are delayed

The DHCP Server is configured to update the DHCP client's records. The configuration is specified in [How to configure DNS dynamic updates in Windows](../../windows-server/networking/configure-dns-dynamic-updates-windows-server-2003.md#how-dhcpdns-update-interaction-works). The Windows clients are also configured to honor DHCP option 81. They're configured as mentioned in [Unexpected DNS record registration behavior when the DHCP server manages dynamic DNS updates](../../windows-server/networking/dns-registration-behavior-when-dhcp-server-manages-dynamic-dns-updates.md).

> [!NOTE]
> We recommend that the client register its record instead of DHCP or any other device.

With all configurations in place, the DNS record may be registered with a significant delay or might not be registered at all. You can verify this by checking the DHCP server audit logs located in the daily audit files at *C:\Windows\System32\DHCP*.

> [!IMPORTANT]
> A similar issue is discussed in [DHCP dynamic updates of DNS registrations are delayed or not processed](../../windows-server/networking/dhcp-dynamic-updates-of-dns-registrations-delayed.md).

#### Cause

There are various reasons why this issue might occur, but a common cause is that the DHCP server's DNS dynamic update queue is full, meaning it can't process new requests. This issue typically happens for two main reasons:

1. The DNS servers (configured in the DHCP scope) don't return an SOA response because the SOA query is for a reverse lookup zone that isn't configured on the DNS servers.
2. No SOA response or dynamic updates aren't allowed on the SOA server. For more information, see [DHCP dynamic updates of DNS registrations are delayed or not processed](../../windows-server/networking/dhcp-dynamic-updates-of-dns-registrations-delayed.md).

#### Resolution: Create reverse lookup zones on the DNS servers

##### Method 1

Check and consult your network team and the DHCP configuration to get a list of all the scopes/subnets in your network. Create a reverse lookup for each such subnet. This method works for both IPv4 and IPv6 reverse lookup zones.

##### Method 2

To avoid any omissions, create a zone with a private IP root range. For example:

- 168.192.in-addr.arpa
- 16.172.in-addr.arpa
- 10.in-addr.arpa

This covers all the subnet ranges for IPv4 addresses in the environment. If you have some reverse lookup zones already created, they automatically become a delegation in these zones.

#### Explanation

When DHCP option 81 is configured, the DHCP server checks the FQDN returned by the client and requests its SOA from the DNS servers configured in the scope. If the SOA isn't returned, the request is queued for a retry. When a reverse lookup zone is missing, the queue tends to fill up, as there will be a request for each lease but no zone to register the PTR record. Similarly, for forward lookups, if dynamic updates are disabled on the SOA server or the SOA server is unreachable, the queue will also fill up.
