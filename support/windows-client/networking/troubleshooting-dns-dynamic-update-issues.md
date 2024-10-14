---
title: DNS requests appear to be random after startup or after network properties change
description: In certain circumstances, DNS client may send DNS name resolution requests that appear to be random
ms.date: 12/26/2023
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

- DNS client does not send dynamic updates.
- DHCP is supposed to update the record, but that functionality is not working as expected.
- DNS server does not update the record due to permissions issues.

Before troubleshooting, we recommend that you implement the following best practices.  

## Microsoft standard recommendations

### Client-side DNS registration

In many environments, there is a practice of DHCP updating the DNS record on behalf of the client. This anyway works if the client is configured with a static IP address.

Given hybrid nature of the infrastructure these days and employees using VPN to connect to office, there are often more than one IP associated with one endpoint. This all can be avoided, if the client registers its record. Thus, the recommendation is to not to use DHCP option 81 and instead, let client register its record.

For more information on how DHCP option 81 works, see the following two articles:

- [2.2.7 DHCPv4 Option Code 81 (0x51) - Client FQDN Option](/openspecs/windows_protocols/ms-dhcpe/e4c46e9d-5013-4ab0-9434-ccd11f1347f5)
- Windows DNS client behavior is mentioned in [Unexpected DNS record registration behavior if DHCP server uses "Always dynamically update DNS records"](../../windows-server/networking/dns-registration-behavior-when-dhcp-server-manages-dynamic-dns-updates.md).

### Configure dynamic update as "Secure Only"

The dynamic update on the domain zone should be configured as **Secure Only**.

If client computers performing dynamic registration are domain-joined (which should be verified by the domain's administrator or solution architect), configure the domain zone to allow dynamic updates with **Secure Only** to ensure consistent behavior on the dynamic registration.

### Enable time stamp for dynamic records

By default, dynamic records do not include a timestamp. When configuring zone properties, you can enable the **Scavenge Stale Records** option under the **Aging** section of the zone's properties dialog. Once this option is enabled, newly registered records will include a timestamp.

The timestamps are required if you plan to scavenge stale records. Without a timestamp, a DNS record cannot be compared to the current time and will not be considered stale, even if it was dynamically registered.

> [!NOTE]
> If you recently enabled the given option, the records which were registered prior to the change, will not carry timestamp and will not be scavenged.

### Scavenge settings for the DNS in case of Active Directory (AD) integrated zone

The above-mentioned setting (Scavenge Stale Records" under "Ageing" in the properties dialogue box of Zone) is to ensure that the AD object carries a Timestamp. But the scavenging of stale record, happens at DNS server level for all the zones on which the given setting is enabled. For complete detail on Scavenging refer to [Don't be afraid of DNS scavenging, just be patient - Windows Server " Microsoft Learn](../../windows-server/networking/dns-scavenging-setup.md).

Scavenging cycle is a low priority thread for DNS process. Thus, there is no guarantee that the scavenging cycle will run. That said, we can maximize the chances of this to run by choosing a DC DNS server, in an AD integrated zone environment, which does not have any critical role like FSMO roles and more specifically PDC Emulator. It is recommended that the scavenging is configured on a DC which does not have any FSMO role but if that is not possible, avoid configuring scavenging on a PDC Emulator.

### Maintain standard DNS zone permissions

Standard DNS zone permissions should be kept intact:  

In an AD integrated zone setup, we follow standard permission hierarchy pretty much like NTFS or File system, which means if an account has access to zone and its child objects for Create, Delete, Modify, it can simply do all these operations. That said, by-default only Enterprise Admin (forest level) has this access followed by Domain Admins (domain level).  

When we enable "Secure Only" dynamic update, the authenticated account i.e. a domain joined machine can update/delete/modify a given object if the requesting machine account is owner of that record. This is the intended purpose of Secure Only Dynamic update i.e. only the original creator of the record can modify or delete an existing record. 

We have seen this becoming a challenge where a DHCP server also does the DNS record updating on behalf of clients using FQDN DHCP option (option 81). In such cases, updating record becomes a challenge due to inconsistency. The records which are updated by DHCP server cannot be modified by the original client and vice versa.  

As mentioned above, Microsoft recommends that the client machine should update its own record instead of DHCP server due to various reasons. Microsoft also made a design change to enforce this behaviour. Which disregards the DHCP server's preference of updating both A and PTR record for the client. To override this behaviour please refer to [Unexpected DNS record registration behavior if DHCP server uses "Always dynamically update DNS records"](../../windows-server/networking/dns-registration-behavior-when-dhcp-server-manages-dynamic-dns-updates.md).

However, in an ideal scenario, the client should be updating its record. But if there are already existing records which were updated by DHCP, the client won't be able to update them. So, to overcome such situation, many enterprises use a reciprocal practice of enforcing the DHCP server to update the client's record, which is highly discouraged.  

The recommendation is to let DHCP server remove them, or scavenging cycle remove them post which the client will be able to update it. 

### Separate DHCP server from AD-DS

DHCP Server should be on a different server and not on AD-DS (Domain Controller): 

DHCP Server, in a secure update setup, uses machine's domain account to register any record. Due to permissions involved in updating a secure record, when DHCP server is on an AD-DS server, it uses computer account i.e. Domain Controller's Account, to register any record. This means that the static records can get overwritten by the DHCP server if FQDN option is also enabled on DHCP server and DHCP server is not configured with a service account. This can cause potential problems like scavenging of Static records later. To avoid such problems, the DHCP server should be configured with a service account and should be on a different server. Please refer to [How to configure DNS dynamic updates in Windows Server - Windows Server " Microsoft Learn](../../windows-server/networking/configure-dns-dynamic-updates-windows-server-2003.md).

## Troubleshoot general and known issues

### Client side issues

SOA not found.

Client not sending dynamic Update. Discussed in the article: [How to enable or disable DNS updates in Windows](../../windows-server/networking/enable-disable-dns-dynamic-registration.md)

Client unable to get Authentication ticket TSIG from DC.

### DHCP server issues

DHCP Server not sending Dynamic Update on behalf of client.

DHCP DNS Update queue length. Majorly covered in [DHCP dynamic updates of DNS registrations are delayed or not processed](../../windows-server/networking/dhcp-dynamic-updates-of-dns-registrations-delayed.md)  

There is a conflict when DHCP tries updating client's record as it is already registered with Client's Machine account. [Unexpected DNS record registration behavior if DHCP server uses "Always dynamically update DNS records"](../../windows-server/networking/dns-registration-behavior-when-dhcp-server-manages-dynamic-dns-updates.md)  

### DNS server issues

Permissions issue with DNS zone. 

Changes in the authenticated account settings on the DNS Zone level. 

DHCP's configuration for the service account for dynamic update. 

### Working with DNS Dynamic Update issues.  

Note: This is a multipart series which discusses various aspects from Windows Client to server to be checked when such issue occurs. 

We should always start with basic checks like if the issue is happening with multiple clients, Clients of same subnet, particular client etc. This helps in scoping the issue from client to server or the network. To understand how DNS Dynamic update is triggered (with example) please read [How to configure DNS dynamic updates in Windows Server - Windows Server " Microsoft Learn](../../windows-server/networking/configure-dns-dynamic-updates-windows-server-2003#how-windows-based-computers-update-their-dns-names.md).

## General Checklist

Now as we understand the DNS dynamic updates. Let's also follow a checklist to ensure that the settings are in place for dynamic updates for the client.

### DNS Client side

Check if "Register this connection's addresses in DNS" is selected: 

```powershell
#Get the list of interfaces which are up and connected.
$Adapters = Get-NetAdapter | Where-Object Status -eq Up

#If there is only one interface the bellow command will work.
Get-DnsClient -InterfaceIndex $Adapters.ifIndex

#If there are more than one interface active and up you may use "Get-DNSClient" to see the registration status of all interfaces.
```

What are we looking for?

**RegisterThisConnectionsAddress** should be **True**.

Change its value to **True** if it was **False**:

```powershell
#Get the list of interfaces which are up and connected.
$Adapters = Get-NetAdapter | Where-Object Status -eq Up

#If there is only one interface the bellow command will work.
Set-DnsClient -RegisterThisConnectionsAddress $True -InterfaceIndex $Adapters.ifIndex
```

Verify the value by taking the `Get-DnsClient` output and ensure that the RegisterThisConnectionsAddress is set to **True**.

#### Is there a group policy which can affect this setting?

There is a group policy which can modify the behaviour. However, the default setting of interface is to register the connection. That said, an enterprise can choose "Dynamic Update" group policy setting to define the behaviour of a client about Sending DNS Dynamic Updates. 

Computer Configuration > Administrative Templates > Network > DNS Client > Dynamic Update. 

### DNS Server side

**Ensure the Zone is Writable**:

The domain in which the client is going to get dynamically registered, is a zone which should be a writable copy. Which also means that the given zone should bear an SOA record of the same DNS server where the zone is hosted and to which the clients can reach through the network. 

There are generally multiple types of setups.  

Client pointing to Cache only DNS server (a DNS server which does not has any Domain zone but just conditional forwarders or forwarders. Which in-turn points to the actual DNS server which has the zone (writable or readable). 

Simple setup where the clients are pointing to the DNS servers which has the given Domain zone hosted. 

The option one is generally chosen for load balancing and a bigger environment with a lot of clients and the idea is to shift the load of Name resolution from the available DCs to Additional servers. However, in this setup it is important that the client should have connectivity for DNS protocol to the server bearing SOA record for the domain zone. Without which the dynamic update will fail. 

**Allow Dynamic Updates**: An AD-Integrated DNS zone hosted on Microsoft DNS server has three options about dynamic update: 

None 

Non-Secure and Secure 

Secure Only 

Note: Option 3 is available only in case of AD integrated DNS zone. 

To Allow dynamic update the zone should be configured with "Non-Secure and Secure" or "Secure Only" update type. It is recommended to use "Secure Only" for AD integrated zones. 

**Check DNS Auditing**:

DNS Server logging is discussed in [DNS Logging and Diagnostics " Microsoft Learn](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn800669(v=ws.11)) and specifically to verify if the record(s) that you are concerned about, is getting registered, can be tracked with DNS Audit events [DNS Logging and Diagnostics " Microsoft Learn](https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn800669(v=ws.11)#audit-events), Event ID: 519. One can filter the DNS audit events, which are enabled by default, with the given ID and verify if the record was successfully registered.  

**Note:** The Audit event log is local to the given DNS server. Which means, that the given ID will only be visible on the DNS server where the record is registered.  

## Scenario

DHCP Server unable to complete Dynamic Update on behalf of client or the registrations are happening with a delay. 

DHCP Server is configured to update DHCP client's record. The configuration is as specified in [How to configure DNS dynamic updates in Windows Server - Windows Server " Microsoft Learn](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/configure-dns-dynamic-updates-windows-server-2003#how-dhcpdns-update-interaction-works). The windows clients are also configured to honour DHCP option 81 and is configured as mentioned in [Unexpected DNS record registration behavior when the DHCP server manages dynamic DNS updates - Windows Server " Microsoft Learn](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/dns-registration-behavior-when-dhcp-server-manages-dynamic-dns-updates). 

*Note: Microsoft recommends that the client should register its record instead of DHCP or any other device.** *

With all the configuration in place, the DNS record is either registered with a lot of delay or it never gets registered on the DNS server. One can verify that from DHCP Server Audit logs present in Day wise audit in "C:\Windows\System32\DHCP". 

*Important** *

*A similar issue is discussed in *[https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/dhcp-dynamic-updates-of-dns-registrations-delayed](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/dhcp-dynamic-updates-of-dns-registrations-delayed)* ** *

### Cause

There could be different scenarios due to which this can happen but one of the major issues is with DHCP's DNS dynamic queue is full i.e. DHCP is not able to accommodate any new requests. This can generally happen due to two major reasons 

There is no SOA response from the DNS servers (configured in the DHCP scope) as the SOA query is for Reverse lookup zone and these Zones are not configured on the DNS servers.

There is no SOA response or Dynamic update is not allowed on the SOA server. This is covered in [https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/dhcp-dynamic-updates-of-dns-registrations-delayed](https://learn.microsoft.com/en-us/troubleshoot/windows-server/networking/dhcp-dynamic-updates-of-dns-registrations-delayed) 

### Resolution

Create Reverse lookup zone(s) on the DNS server(s). 

Method 1: 

Check and consult your network team and the DHCP configuration to get a list of all the scopes/subnets in your network. Create Reverse lookup for each such subnet. This is appropriate for both IPv4 and IPv6 reverse lookup zones.  

 

Method 2: 

Create zone with Private IP root range to avoid any misses. Like  

168.192.in-addr.arpa 

16.172.in-addr.arpa 

10.in-addr.arpa 

This will cover all the subnet ranges for IPv4 addresses in the environment. If you have some reverse lookup zones already created, they will automatically become delegation in these zones.  

Explanation 

When DHCP option 81 is configured, the DHCP server checks for the FQDN returned by the client and asks for its SOA from the configured DNS servers in the Scope. If the SOA is not returned by the configured DNS servers in the Scope, the request is queued for retry. When there is a missing reverse lookup zone, the queue tends to get filled up as there will be a request for each lease and no zone to register the PTR record. Same goes for forward lookup if the Dynamic update is disabled on the SOA or the SOA is not reachable. 
