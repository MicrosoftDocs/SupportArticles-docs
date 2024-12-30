---
title: The specified server cannot perform the requested operation error
description: Helps resolve the error - The namespace cannot be queried. The specified server cannot perform the requested operation.
ms.date: 09/25/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, warrenw, v-lianna, albugn
ms.custom: sap:Network Connectivity and File Sharing\DFS Namespace (Not Replication), csstroubleshoot
---
# Error "The namespace cannot be queried. The specified server cannot perform the requested operation" with DFS Namespaces

This article helps resolve the error "The namespace cannot be queried. The specified server cannot perform the requested operation."

When you access, modify, or create a Distributed File System (DFS) Namespace on a DFS Namespace server, domain member server, or Windows client with File Services tools (included in Remote Server Administration Tools (RSAT)) installed, you might receive the following error message:

> The namespace cannot be queried. The specified server cannot perform the requested operation

## The PDC or DC can't be reached or is down

You use the DFS Management console on a machine that's a DFS Namespace server, member server, or member client with RSAT File Services tools installed. This issue occurs because the machine, from where you are using the DFS Management console, can't reach the primary domain controller (PDC) or local domain controller (DC) over TCP/UDP port 389 (Lightweight Directory Access Protocol (LDAP) port), or the PDC or DC is down.

### Wireshark trace scenario 1

Tracing on a DFS Namespace server, member server, or member client with RSAT File Services tools installed:

The Domain Name System (DNS) queries for LDAP SRV records are successful.

```output
192.168.0.42	192.168.0.2		DNS	110	Standard query 0x7685 SRV _ldap._tcp.pdc._msdcs.contoso.com
192.168.0.2		192.168.0.42	DNS	168	Standard query response 0x7685 SRV _ldap._tcp.pdc._msdcs.contoso.com SRV 0 100 389 SRVPdc.contoso.com A 192.168.0.1
```

However, establishing a TCP connection to the PDC will fail during the TCP three-way handshake.

```output
192.168.0.42	192.168.0.1	TCP	66	49893 → 389 [SYN, ECE, CWR] Seq=0 Win=64240 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.0.42	192.168.0.1	TCP	66	[TCP Retransmission] 49893 → 389 [SYN, ECE, CWR] Seq=0 Win=64240 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.0.42	192.168.0.1	TCP	66	[TCP Retransmission] 49893 → 389 [SYN] Seq=0 Win=64240 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.0.42	192.168.0.1	TCP	66	[TCP Retransmission] 49893 → 389 [SYN] Seq=0 Win=64240 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.0.42	192.168.0.1	TCP	66	[TCP Retransmission] 49893 → 389 [SYN] Seq=0 Win=64240 Len=0 MSS=1460 WS=256 SACK_PERM
```

### Wireshark trace scenario 2

Tracing on a member server or a member client with RSAT File Services tools installed:

```output
192.168.0.45	192.168.0.42	NETDFS	286	dfs_GetInfo request
192.168.0.42	192.168.0.45	NETDFS	214	dfs_GetInfo response, Error: WERR_BAD_NET_RESP
```

## Check the status of TCP/UDP port 389

> [!NOTE]
> After you apply the solution, remove the DFS Namespace from the DFS Management console and add it back, or close and reopen the console to make the changes take effect.

To resolve this issue, check the status of TCP/UDP port 389 (LDAP port) in your network and on the PDC or DC. Make sure that communication over this port is allowed. The PDC or DC should be up and running.
