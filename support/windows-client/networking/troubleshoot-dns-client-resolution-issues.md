---
title: Troubleshoot DNS Client Name Resolution Issues
description: Helps troubleshoot DNS client name resolution issues.
ms.date: 11/22/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, moibrahi, warrenw, v-lianna
ms.custom: sap:Network Connectivity and File Sharing\DNS, csstroubleshoot
---
# Troubleshoot DNS client name resolution issues

This article helps troubleshoot Domain Name System (DNS) client name resolution issues.

Domain Name System (DNS) resolution issues can occur for the following three primary causes:

- DNS client problems or configurations.
- DNS server problems or configurations.
- Intermediate devices or configurations between a DNS client and a DNS server, or between a DNS server and external resolvers (such as root hints, forwarders, and conditional forwarders), which might require further investigation.

> [!NOTE]
> This article focuses on DNS resolution issues caused by DNS client problems or configurations. For information regarding DNS server issues, see [Troubleshooting DNS servers](/windows-server/networking/dns/troubleshoot/troubleshoot-dns-server).

DNS resolution issues can occur in the following scenarios:

## Scenario 1: Firewall rule blocks outbound connections on UDP port 53

Assume that there's an outbound firewall rule that blocks outbound connections on User Datagram Protocol (UDP) port 53.

In this case, when you run the `Resolve-DnsName contoso.com` PowerShell cmdlet with [Wireshark](https://www.wireshark.org/) running, you receive the following error:

```output
resolve-dnsname : contoso.com : This operation returned because the timeout period expired
At line:1 char:1
+ resolve-dnsname contoso.com
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : OperationTimeout: (contoso.com:String) [Resolve-DnsName], Win32Exception
    + FullyQualifiedErrorId : ERROR_TIMEOUT,Microsoft.DnsClient.Commands.ResolveDnsName
```

When you check the Wireshark trace, there's no outbound DNS traffic to the domain controller (DC).

In this case, review the Windows Firewall rules and check any third-party security products for packet drops on UDP or Transmission Control Protocol (TCP) port 53.

If you notice a DNS resolution request with no response, it's helpful to collect Wireshark traces from a switch using port mirroring to confirm that the DNS UDP packet left the client machine. The requests resemble the following:

```output
139 3.149039    10.0.1.10   10.0.1.2    DNS 71  Standard query 0xcdc6 A contoso.com
140 3.149192    10.0.1.10   10.0.1.2    DNS 71  Standard query 0x8168 AAAA contoso.com
```

These are standard query requests for host A and host AAAA with no response. Checking the trace can isolate the issue. If you see the UDP packet on the switch, it means that the packet has already left the client machine, and the problem is beyond the client machine.

## Scenario 2: There's an entry for the domain name in the Hosts file

Assume that the Hosts file located at **C:\\Windows\\System32\\drivers\\etc** has an entry for the domain name that you want to resolve. For example:

`192.168.1.10`   `contoso.com`

In this case, when you resolve the domain name `contoso.com` with Wireshark running, you receive the following output:

```powershell
PS C:\Windows\System32\drivers\etc> Resolve-DnsName contoso.com

Name                                           Type   TTL   Section    IPAddress
----                                           ----   ---   -------    ---------
contoso.com                                    A      60440 Answer     192.168.1.10
```

Additionally, no traffic can be detected in Wireshark.

This is because the DNS client uses the following sequence when resolving names:

1. Check the cache.
2. Check the Hosts file.
3. Send the query to the DNS server.

Since there's an entry in the Hosts file, the DNS client service doesn't query the DNS server.

## Scenario 3: The client points to an incorrect or unreachable DNS server

Assume that the DNS server on the Network Interface Card (NIC) of the DNS client is configured with the IP of an unreachable DNS server. The client IP configuration looks like the following example:

```output
IPv4 Address. . . . . . . . . . . : 10.0.1.10<Preferred>
Default Gateway . . . . . . . . . : 10.0.1.1
DNS Servers . . . . . . . . . . . : 192.168.0.1
```

Since the DNS server isn't reachable, the client doesn't receive a response, causing the query to time out. This time-out can be observed in Wireshark. The DNS standard queries with no response:

```output
439 14.482923   10.0.1.10   192.168.0.1 DNS 71  Standard query 0xa384 A contoso.com
440 14.482923   10.0.1.10   192.168.0.1 DNS 71  Standard query 0x4fe0 AAAA contoso.com
```

In this case, when you run the `Resolve-DnsName contoso.com` PowerShell cmdlet, you receive the following output:

```powershell
PS C:\Windows\System32\drivers\etc> Resolve-DnsName contoso.com
Resolve-DnsName : contoso.com : This operation returned because the timeout period expired
At line:1 char:1
+ Resolve-DnsName contoso.com
+ ~~~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : OperationTimeout: (contoso.com:String) [Resolve-DnsName], Win32Exception
    + FullyQualifiedErrorId : ERROR_TIMEOUT,Microsoft.DnsClient.Commands.ResolveDnsName
```

## Scenario 4: Several DNS servers are configured on the NIC, some of which aren't reachable

Assume that the client DNS settings are configured with some unreachable DNS servers as follows:

```console
DNS Servers . . . . . . . . . . . : 192.168.0.1
                                    172.16.1.1
                                    192.168.1.20
                                    10.0.1.2
```

In this case, when you perform a DNS resolution by using the `Resolve-DnsName contoso.com` PowerShell cmdlet, all those DNS server addresses except `10.0.1.2` aren't reachable.

By design, the DNS client will start sending this query to the DNS servers configured in a specific order and wait for a response within a specific grace period.

This process can be seen in Wireshark with the filter `dns.qry.name == contoso.com`.

The Wireshark output shows that the query takes nearly four seconds to complete. From a networking perspective, this duration can be lengthy and might cause some applications to time out.

```output
30  03:56:58.634623 10.0.1.10   192.168.0.1  DNS 71  Standard query 0x9f32 A contoso.com
33  03:56:59.643171 10.0.1.10   172.16.1.1   DNS 71  Standard query 0x9f32 A contoso.com
38  03:57:02.646443 10.0.1.10   192.168.0.1  DNS 71  Standard query 0x9f32 A contoso.com
42  03:57:02.646556 10.0.1.10   172.16.1.1   DNS 71  Standard query 0x9f32 A contoso.com
43  03:57:02.646573 10.0.1.10   192.168.1.20 DNS 71  Standard query 0x9f32 A contoso.com
47  03:57:02.646684 10.0.1.10   10.0.1.2     DNS 71  Standard query 0x9f32 A contoso.com
```

> [!NOTE]
> In this scenario, using `nslookup` isn't applicable and will always fail. This is because `nslookup` uses **nslookup.exe** to contact only the primary DNS server configured, which in this case is `192.168.0.1`.

## Scenario 5: Long DNS suffix search list

Assume that the DNS suffix search list on the DNS client is configured as follows:

> [!NOTE]
> `contoso.com` is the correct DNS suffix.

```output
DNS Suffix Search List. . . . . . : microsoft.com
                                    ms.com
                                    azure.com
                                    ms.local
                                    contoso.local
                                    contoso.com
```

In this case, when you perform a name resolution using the `Resolve-DnsName internal` PowerShell cmdlet, the DNS client will append the DNS suffixes in order, potentially causing delays if the needed query is lower on the list. By using the filter `dns.qry.name contains internal` in Wireshark, the query appears as follows:

```output
116 04:33:38.164251 10.0.1.10   10.0.1.2    DNS 82  Standard query 0xc557 A internal.microsoft.com
120 04:33:38.177186 10.0.1.10   10.0.1.2    DNS 75  Standard query 0x0a4b A internal.ms.com
124 04:33:38.453625 10.0.1.10   10.0.1.2    DNS 78  Standard query 0x4245 A internal.azure.com
128 04:33:38.466154 10.0.1.10   10.0.1.2    DNS 77  Standard query 0xfaca A internal.ms.local
131 04:33:38.471033 10.0.1.10   10.0.1.2    DNS 82  Standard query 0xa9d6 A internal.contoso.local
136 04:33:38.476248 10.0.1.10   10.0.1.2    DNS 80  Standard query 0x611f A internal.contoso.com
```

> [!NOTE]
> If you need to test a specific query, you can add a trailing period (.) at the end. For example, `internal.contoso.com.`

## Measure how long a DNS resolution query takes

To measure the time taken for a DNS resolution query to complete, run the following PowerShell cmdlet:

> [!NOTE]
> A result under one second is considered acceptable.

```powershell
(Measure-Command {Resolve-DnsName -Name contoso.com -Server <IP Address> -DnsOnly}).TotalMilliseconds
```

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
