---
title: Troubleshooting DNS dynamic update issues
description: Introduces the troubleshooting suggestions for DNS dynamic update issues.
ms.date: 10/14/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika
ms.custom: sap:Network Connectivity and File Sharing\DNS, csstroubleshoot
---
# Troubleshooting DNS dynamic update issues

This guide addresses common issues related to DNS dynamic updates, and provides the relevant troubleshooting steps. Dynamic updates are crucial for maintaining accurate DNS records, especially in environments where IP addresses change frequently, such as with DHCP. The guide covers common scenarios, Microsoft recommendations, and troubleshooting tips for DNS clients, DHCP servers, and DNS servers.

## General causes

The following bullets list the general causes for dynamic update failures:

- DNS client doesn't send dynamic updates.
- DHCP is supposed to update the record, but that functionality isn't working as expected.
- DNS server doesn't update the record due to permissions issues.

Before troubleshooting, we recommend that you implement the following best practices.  

## Microsoft standard recommendations

### Client-side DNS registration

In many environments, there's a practice of DHCP updating the DNS record on behalf of the client. This anyway works if the client is configured with a static IP address.

Given hybrid nature of the infrastructure these days and employees using VPN to connect to office, there are often more than one IP associated with one endpoint. This situation can be avoided, if the client registers its record. Thus, the recommendation is to not use DHCP option 81 and instead, let client register its record.

For more information on how DHCP option 81 works, see the following two articles:

- [2.2.7 DHCPv4 Option Code 81 (0x51) - Client FQDN Option](/openspecs/windows_protocols/ms-dhcpe/e4c46e9d-5013-4ab0-9434-ccd11f1347f5)
- Windows DNS client behavior is mentioned in [Unexpected DNS record registration behavior if DHCP server uses "Always dynamically update DNS records"](../../windows-server/networking/dns-registration-behavior-when-dhcp-server-manages-dynamic-dns-updates.md).

### Configure dynamic update as "Secure Only"

The dynamic update on the domain zone should be configured as **Secure Only**.

If client computers performing dynamic registration are domain-joined (which should be verified by the domain's administrator or solution architect), configure the domain zone to allow dynamic updates with **Secure Only** to ensure consistent behavior on the dynamic registration.

### Enable time stamp for dynamic records

By default, dynamic records don't include a timestamp. When configuring zone properties, you can enable the **Scavenge Stale Records** option under the **Aging** section of the zone's properties dialog. Once this option is enabled, newly registered records include a timestamp.

The timestamps are required if you plan to scavenge stale records. Without a timestamp, a DNS record can't be compared to the current time and won't be considered stale, even if it was dynamically registered.

> [!NOTE]
> If you recently enabled the given option, the records which were registered prior to the change, will not carry timestamp and will not be scavenged.

### Scavenge settings for the DNS in Active Directory (AD) integrated zone

The **Scavenge Stale Records** option in the zone's **Aging** properties ensures AD objects to carry a timestamp. However, the actual scavenging of stale records occurs at the DNS server level, affecting all zones where this setting is enabled. For a detailed explanation of scavenging, refer to [Don't be afraid of DNS scavenging, just be patient - Windows Server](../../windows-server/networking/dns-scavenging-setup.md).

Scavenging cycle is a low priority thread for DNS process, so it might not always run consistently. To maximize the chances of it running, configure scavenging on a Domain Controller (DC) DNS server in an AD-integrated zone environment that doesn't have critical roles, such as Flexible Single Master Operation (FSMO) roles, and especially avoid the PDC Emulator. Ideally, scavenging should be set up on a DC without any FSMO roles. If this configuration isn't possible, avoid configuring it on the PDC Emulator.

### Maintain standard DNS zone permissions

Standard DNS zone permissions should remain intact:  

In an AD-integrated zone setup, permissions follow standard hierarchy similar to NTFS or file systems. This means that if an account has permissions to create, delete, or modify a zone and its child objects, it can simply perform these operations. By default, only Enterprise Admins (forest-wide) and Domain Admins (domain-wide) have these privileges.

When **Secure Only** dynamic updates are enabled, an authenticated account (for example, a domain-joined computer) can update, delete, or modify a DNS record if the account is the owner of that record. This ensures that only the original creator of the record can modify or delete it, which is the intended behavior of secure only dynamic updates.

However, challenges can arise when a DHCP server updates DNS records on behalf of clients using FQDN DHCP option (option 81). In such cases, inconsistencies might occur because DNS records updated by the DHCP server cannot be modified by the original client, and vice versa.

As mentioned earlier, Microsoft recommends that client machines update their own DNS records rather than relying on the DHCP server. This is due to several reasons, and Microsoft has also implemented a design change to enforce this behavior. This change prevents the DHCP server from updating both A and PTR records for clients. To override this behavior, refer to [Unexpected DNS record registration behavior if DHCP server uses "Always dynamically update DNS records"](../../windows-server/networking/dns-registration-behavior-when-dhcp-server-manages-dynamic-dns-updates.md).

Ideally, the client should update its own DNS record. However, if a record was previously updated by the DHCP server, the client won't be able to modify it. To address this, some enterprises enforce the DHCP server to update the client’s record, which is strongly discouraged.

The recommended approach is to allow the DHCP server, or the scavenging process, to remove the records. Once it's removed, the client will then be able to update it.

### Separate DHCP server from ADDS

The DHCP server should be hosted on a separate server, not on a DC running Active Directory Domain Services (ADDS).

In a secure update setup, the DHCP server uses its machine's domain account to register DNS records. When the DHCP server runs on a DC, it uses the DC's account to register records. This means that static records can be overwritten by the DHCP server if the FQDN option is enabled and the DHCP server isn't configured with a dedicated service account. This can cause issues like the unintended scavenging of static records.

To prevent such problems, the DHCP server should be configured with a service account and run on a separate server. For more information, see [How to configure DNS dynamic updates in Windows Server - Windows Server](../../windows-server/networking/configure-dns-dynamic-updates-windows-server-2003.md).

## Troubleshoot general and known issues

### Client side issues

1. Start of Authority (SOA) not found.
2. Client not sending dynamic Update. See [How to enable or disable DNS updates in Windows](../../windows-server/networking/enable-disable-dns-dynamic-registration.md).
3. Client can't get authentication ticket Transaction Signature(TSIG) from DC.

### DHCP server issues

1. DHCP server doesn't send dynamic update on behalf of client.
2. DHCP DNS update queue length. See [DHCP dynamic updates of DNS registrations are delayed or not processed](../../windows-server/networking/dhcp-dynamic-updates-of-dns-registrations-delayed.md).
3. There's a conflict when DHCP tries to update client's record as it is already registered with client's machine account. See [Unexpected DNS record registration behavior if DHCP server uses "Always dynamically update DNS records"](../../windows-server/networking/dns-registration-behavior-when-dhcp-server-manages-dynamic-dns-updates.md).

### DNS server issues

1. Permissions issue with DNS zone.
2. Changes in the authenticated account settings on the DNS Zone level.
3. DHCP's configuration for the service account for dynamic update.

## Troubleshoot DNS dynamic update issues.  

> [!NOTE]
> This section is a multipart series which discusses various aspects from Windows client to server to be checked when such issue occurs.

We should begin with basic checks, such as determining whether the issue affects multiple clients, clients on the same subnet, or a specific client. This helps narrow down whether the problem lies with the client, server, or network. For an explanation of how DNS dynamic updates are triggered, including examples, see [How to configure DNS dynamic updates in Windows Server - Windows Server](../../windows-server/networking/configure-dns-dynamic-updates-windows-server-2003#how-windows-based-computers-update-their-dns-names.md).

Now as we understand the DNS dynamic updates. Let's also follow a checklist to ensure that the settings are in place for dynamic updates for the client.

### DNS client side checklist

Check if **Register this connection's addresses in DNS** is selected:

```powershell
#Get the list of interfaces which are up and connected.
$Adapters = Get-NetAdapter | Where-Object Status -eq Up

#If there is only one interface the bellow command will work.
Get-DnsClient -InterfaceIndex $Adapters.ifIndex

#If there are more than one interface active and up you may use "Get-DNSClient" to see the registration status of all interfaces.
```

In the outcome, **RegisterThisConnectionsAddress** should be **True**. Change the value to **True** if it was **False**:

```powershell
#Get the list of interfaces which are up and connected.
$Adapters = Get-NetAdapter | Where-Object Status -eq Up

#If there is only one interface the bellow command will work.
Set-DnsClient -RegisterThisConnectionsAddress $True -InterfaceIndex $Adapters.ifIndex
```

Verify the value by taking the `Get-DnsClient` output and ensure that the RegisterThisConnectionsAddress is set to **True**.

There's a Group Policy that can modify this behavior. By default, network interfaces are set to register their connection. However, an enterprise can use the "dynamic update" Group Policy setting to control how a client sends DNS dynamic updates. The group policy locates at:

**Computer Configuration** > **Administrative Templates** > **Network** > **DNS Client** > **dynamic update**

### DNS server side check list

#### Ensure the Zone is Writable

The domain where the client is dynamically registered must be a zone that is a writable copy. This means the zone should contain an SOA record for the DNS server hosting the zone, and the client must be able to reach this server through the network.

There are typically two types of setups.  

1. Client pointing to a cache-only DNS server: This DNS server doesn't host any domain zone but uses conditional forwarders or forwarders to point to the actual DNS server, which holds the zone (either writable or readable).
2. Simple setup: The client points directly to DNS servers that host the domain zone.

The option one is generally chosen for load balancing and a bigger environment with many clients and the idea is to shift the load of Name resolution from the available DCs to extra servers. However, in this setup it's important that the client should have connectivity for DNS protocol to the server bearing SOA record for the domain zone. Without which the dynamic update fails.

#### Allow dynamic updates

An AD-integrated DNS zone hosted on Microsoft DNS server has three options about dynamic update:

- None
- Non-Secure and Secure
- Secure Only

> [!NOTE]
> Option 3 is available only in case of AD integrated DNS zone.

To allow dynamic update, the zone should be configured with "Non-Secure and Secure" or "Secure Only" update type. It's recommended to use "Secure Only" for AD integrated zones.

#### Check DNS Auditing

DNS Server logging is discussed in [DNS Logging and Diagnostics](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn800669(v=ws.11)) and specifically to verify if the records that you're concerned about, is getting registered, can be tracked with DNS Audit events [DNS Logging and Diagnostics](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn800669(v=ws.11)#audit-events), Event ID: 519. One can filter the DNS audit events, which are enabled by default, with the given ID and verify if the record was successfully registered.  

> [!NOTE]
> The Audit event log is local to the given DNS server. Which means, that the given ID will only be visible on the DNS server where the record is registered.  

### Scenario: DHCP server can't complete dynamic update on behalf of client or the registrations are happening with a delay.

DHCP Server is configured to update DHCP client's record. The configuration is as specified in [How to configure DNS dynamic updates in Windows Server](../../windows-server/networking/configure-dns-dynamic-updates-windows-server-2003#how-dhcpdns-update-interaction-works.md). The windows clients are also configured to honor DHCP option 81 and is configured as mentioned in [Unexpected DNS record registration behavior when the DHCP server manages dynamic DNS updates](../../windows-server/networking/dns-registration-behavior-when-dhcp-server-manages-dynamic-dns-updates.md).

> [!NOTE]
> Microsoft recommends that the client should register its record instead of DHCP or any other device.

With all configurations in place, the DNS record may be registered with significant delay or might not get registered at all. You can verify this by checking the DHCP Server audit logs, located in the daily audit files at *C:\Windows\System32\DHCP*.

> [!IMPORTANT]
> A similar issue is discussed in [DHCP dynamic updates of DNS registrations are delayed or not processed](../../windows-server/networking/dhcp-dynamic-updates-of-dns-registrations-delayed.md).

### Cause

There are various reasons why this issue might occur, but a common cause is the DHCP server's DNS dynamic update queue being full, meaning it can't process new requests. This typically happens for two main reasons:

1. The DNS servers (configured in the DHCP scope) aren't returning an SOA response because the SOA query is for a reverse lookup zone, and these zones aren't configured on the DNS servers.
2. There's no SOA response or Dynamic update isn't allowed on the SOA server. For more information, see [DHCP dynamic updates of DNS registrations are delayed or not processed](../../windows-server/networking/dhcp-dynamic-updates-of-dns-registrations-delayed.md).

### Resolution

Create reverse lookup zones on the DNS servers.

#### Method 1

Check and consult your network team and the DHCP configuration to get a list of all the scopes/subnets in your network. Create Reverse lookup for each such subnet. This is appropriate for both IPv4 and IPv6 reverse lookup zones.  

#### Method 2

To avoid any misses, create zone with private IP root range. For example:

- 168.192.in-addr.arpa
- 16.172.in-addr.arpa
- 10.in-addr.arpa

This covers all the subnet ranges for IPv4 addresses in the environment. If you have some reverse lookup zones already created, they automatically become delegation in these zones.  

### Explanation

When DHCP option 81 is configured, the DHCP server checks the FQDN returned by the client and requests its SOA from the DNS servers configured in the scope. If the SOA isn't returned, the request is queued for a retry. When a reverse lookup zone is missing, the queue tends to fill up because there will be a request for each lease, but no zone to register the PTR record. Similarly, for forward lookups, if dynamic updates are disabled on the SOA server or the SOA server is unreachable, the queue will also fill up.
