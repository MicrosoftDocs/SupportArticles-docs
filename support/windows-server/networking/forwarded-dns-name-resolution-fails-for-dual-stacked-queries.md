---
title: Forwarded DNS name resolution fails for dual-stacked queries
description: Describes an issue in which DNS queries that include requests for A and AAAA records initially succeed but then fail.
ms.date: 02/09/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, v-tappelgate
ms.custom: sap:dns, csstroubleshoot
keywords: A record, AAAA record, nonexistent domain, DNS cache, conditional forward
---

# Forwarded DNS name resolution fails for dual-stacked queries

_Applies to:_ &nbsp; Windows Server 2016

## Symptoms

You're using a third-party DNS server solution, and you can't consistently resolve names when you use conditional forwarding.

The local DNS server (10.100.100.70) can connect to the DNS server that's configured as a conditional forwarder (10.133.3.250). The first request from the DNS server to the conditional forwarder successfully resolves a name (for example, nbob1.contoso.com). After some time, name resolution stops working. An nslookup query to the conditional forwarder returns a "nonexistent domain" error message.

If you clear the DNS server cache on the forwarding computer (the local DNS server), name resolution resumes. However, this fix is temporary.

## Cause

The DNS server (10.100.100.70) forwards the client's name resolution request for nbob1.contoso.com to the configured conditional forwarder (10.133.3.250). The name query contains two parts: An A query (IPv4) and an AAAA query (IPv6).

The conditional forwarder returns a correct response for the A record. For example, when a DNS client issues the `nslookup nbob1.contoso.com` command, the DNS server reports the following response from the conditional forwarder:

```output
10.100.100.70 10.133.3.250 DNS:QueryId = 0x78CB, QUERY (Standard query), Query for nbob1.contoso.com of type Host Addr on class Internet
10.133.3.250 10.100.100.70 DNS:QueryId = 0x78CB, QUERY (Standard query), Response - Success, 10.158.150.200
+ Ethernet: Etype = Internet IP (IPv4),DestinationAddress:[5C-B9-01-D0-00-E0],SourceAddress:[00-09-0F-09-00-02]
+ Ipv4: Src = 10.133.3.250, Dest = 10.100.100.70, Next Protocol = UDP, Packet ID = 16114, Total IP Length = 91
+ Udp: SrcPort = DNS(53), DstPort = 63344, Length = 71
- Dns: QueryId = 0x78CB, QUERY (Standard query), Response - Success, 10.158.150.200
QueryIdentifier: 30923 (0x78CB)
+ Flags: Response, Opcode - QUERY (Standard query), AA, RD, Rcode - Success
QuestionCount: 1 (0x1)
AnswerCount: 1 (0x1)
NameServerCount: 0 (0x0)
AdditionalCount: 1 (0x1)
- QRecord: nbob1.contoso.com of type Host Addr on class Internet
QuestionName: nbob1.contoso.com
QuestionType: A, IPv4 address, 1(0x1)
QuestionClass: Internet, 1(0x1)
- ARecord: nbob1.contoso.com of type Host Addr on class Internet: 10.158.150.200
ResourceName: nbob1.contoso.com
ResourceType: A, IPv4 address, 1(0x1)
ResourceClass: Internet, 1(0x1)
TimeToLive: 0 (0x0)
ResourceDataLength: 4 (0x4)
IPAddress: 10.158.150.200
```

These responses are excerpted from server-side Wireshark traces on the local DNS server (10.100.100.70).

The reported response for the AAAA query should resemble the following excerpt:

```output
10.10.10.100 10.10.10.10 DNS:QueryId = 0x21F1, QUERY (Standard query), Query for nbob1.contoso.com of type AAAA on class Internet
10.10.10.10 10.10.10.100 DNS:QueryId = 0x21F1, QUERY (Standard query), Response - Success
+ Ethernet: Etype = Internet IP (IPv4),DestinationAddress:[00-15-5D-E4-19-07],SourceAddress:[00-15-5D-E4-19-00]
+ Ipv4: Src = 10.10.10.10, Dest = 10.10.10.100, Next Protocol = UDP, Packet ID = 9830, Total IP Length = 121
+ Udp: SrcPort = DNS(53), DstPort = 57256, Length = 101
- Dns: QueryId = 0x21F1, QUERY (Standard query), Response - Success
QueryIdentifier: 8689 (0x21F1)
- Flags: Response, Opcode - QUERY (Standard query), AA, RD, RA, Rcode - Success
QR: (1...............) Response
Opcode: (.0000...........) QUERY (Standard query) 0
AA: (.....1..........) Is authoritative
TC: (......0.........) Not truncated
RD: (.......1........) Recursion desired
RA: (........1.......) Recursive query support available
Zero: (.........0......) 0
AuthenticatedData: (..........0.....) Not AuthenticatedData
CheckingDisabled: (...........0....) Not CheckingDisabled
Rcode: (............0000) Success 0
QuestionCount: 1 (0x1)
AnswerCount: 0 (0x0)
NameServerCount: 1 (0x1)
AdditionalCount: 1 (0x1)
- QRecord: nbob1.contoso.com of type AAAA on class Internet
QuestionName: nbob1.contoso.com
QuestionType: AAAA, IPv6 Address, 28(0x1c)
QuestionClass: Internet, 1(0x1)
- AuthorityRecord: contoso.com of type SOA on class Internet: PrimaryNameServer: stdc, AuthoritativeMailbox: hostmaster
ResourceName: contoso.com
ResourceType: SOA, Marks the start of a zone of authority, 6(0x6)
ResourceClass: Internet, 1(0x1)
TimeToLive: 3600 (0xE10)
ResourceDataLength: 38 (0x26)
- SOARData: PrimaryNameServer: stdc, AuthoritativeMailbox: hostmaster
PrimaryNameServer: stdc
ResponsibleAuthoritativeMailbox: hostmaster
SerialNumber: 2 (0x2)
RefreshInterval: 900 (0x384)
RetryInterval: 600 (0x258)
ExpirationLimit: 86400 (0x15180)
MinimumTTL: 3600 (0xE10)
```

However, the local DNS server actually reports a server failure (such as "no record in the domain" or "server failure") for the AAAA record. This response poisons the local DNS server cache and generates a negative cache entry for the host A record, too. After this cache update, the local DNS server no longer resolves host (A) name resolution requests for nbob1.contoso.com.

```output
10.100.100.170 10.133.3.250 DNS:QueryId = 0xC30F, QUERY (Standard query), Query for nbob1.contoso.com of type AAAA on class Internet
10.133.3.250 10.100.100.70 DNS:QueryId = 0xC30F, QUERY (Standard query), Response - Server failure
+ Ethernet: Etype = Internet IP (IPv4),DestinationAddress:[5C-B9-01-D0-00-E0],SourceAddress:[00-09-0F-09-00-02]
+ Ipv4: Src = 10.133.3.250, Dest = 10.100.100.70, Next Protocol = UDP, Packet ID = 32142, Total IP Length = 75
+ Udp: SrcPort = DNS(53), DstPort = 63171, Length = 55
- Dns: QueryId = 0xC30F, QUERY (Standard query), Response - Server failure
QueryIdentifier: 49935 (0xC30F)
- Flags: Response, Opcode - QUERY (Standard query), AA, RD, Rcode - Server failure
QR: (1...............) Response
Opcode: (.0000...........) QUERY (Standard query) 0
AA: (.....1..........) Is authoritative
TC: (......0.........) Not truncated
RD: (.......1........) Recursion desired
RA: (........0.......) Recursive query support not available
Zero: (.........0......) 0
AuthenticatedData: (..........0.....) Not AuthenticatedData
CheckingDisabled: (...........0....) Not CheckingDisabled
Rcode: (............0010) Server failure 2
QuestionCount: 1 (0x1)
AnswerCount: 0 (0x0)
NameServerCount: 0 (0x0)
AdditionalCount: 1 (0x1)
- QRecord: nbob1.contoso.com of type AAAA on class Internet
QuestionName: nbob1.contoso.com
QuestionType: AAAA, IPv6 Address, 28(0x1c)
QuestionClass: Internet, 1(0x1) 
```

In such cases, the underlying problem is that the response from the conditional forwarder isn't formatted correctly. The local DNS server interprets the response to mean that the record isn't found.

## Resolution

Contact the vendor of the third-party DNS server implementation about this issue.

Additionally, you can use Windows PowerShell to implement the following DNS server recursion policy, as follows:

```powershell
Add-DnsServerQueryResolutionPolicy -Name "BlockRecursionOfAAAA" -ApplyOnRecursion -Action Deny -QType "EQ,AAAA"
```

The new policy might mitigate this issue.

## More information

[RFC 2308, Negative Caching of DNS Queries](https://www.rfc-editor.org/rfc/rfc2308), Section 3, describes the behavior that's expected from the name servers that are authoritative for a zone. When the DNS server reports an NXDOMAIN or indicates that no data of the requested type exists, the response must include in the authority section the Start of Authority (SOA) record for the zone. This is required so that the response can be cached.

[Common Misbehavior Against DNS Queries for IPv6 Addresses](https://tools.ietf.org/html/rfc4074) describes specific issues that might affect AAAA name resolution queries.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
