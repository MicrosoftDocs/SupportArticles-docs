---
title: Error the specified server cannot perform the requested operation 
description: Helps resolve the error "The namespace cannot be queried. The specified server cannot perform the requested operation."
ms.date: 09/03/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, warrenw, v-lianna
ms.custom: sap:Network Connectivity and File Sharing\DFS Namespace (Not Replication), csstroubleshoot
---
# Error "The namespace cannot be queried. The specified server cannot perform the requested operation" with DFS Namespaces

This article helps resolve the error "The namespace cannot be queried. The specified server cannot perform the requested operation."

You might receive the following error message when you access, modify, or create a Distributed File System (DFS) Namespace on a DFS Namespace server, domain member server, or Windows client with File Services tools (included in Remote Server Administration Tools (RSAT)) installed.

> The namespace cannot be queried. The specified server cannot perform the requested operation

## The PDC or DC can't be reached or is down

You use the DFS Management console on a machine (DFS Namespace server, member server, or member client with RSAT File Services Tools installed). This issue occurs because the machine can't reach the primary domain controller (PDC) or domain controller (DC) over TCP/UDP port 389 (Lightweight Directory Access Protocol (LDAP) port), or the PDC or DC is down.

See the following Wireshark trace example 1:

Tracing on the DFS Namespace server, a member server or member client with RSAT File Services Tools installed.

The Domain Name System (DNS) queries for LDAP SRV records are successful.

```output
192.168.0.42	192.168.0.2		DNS	110	Standard query 0x7685 SRV _ldap._tcp.pdc._msdcs.contoso.com
192.168.0.2		192.168.0.42	DNS	168	Standard query response 0x7685 SRV _ldap._tcp.pdc._msdcs.contoso.com SRV 0 100 389 SRVPdc.contoso.com A 192.168.0.1
```

However, TCP connection establishment against the PDC doesn't fail during the TCP three-way handshake.

```output
192.168.0.42	192.168.0.1	TCP	66	49893 → 389 [SYN, ECE, CWR] Seq=0 Win=64240 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.0.42	192.168.0.1	TCP	66	[TCP Retransmission] 49893 → 389 [SYN, ECE, CWR] Seq=0 Win=64240 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.0.42	192.168.0.1	TCP	66	[TCP Retransmission] 49893 → 389 [SYN] Seq=0 Win=64240 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.0.42	192.168.0.1	TCP	66	[TCP Retransmission] 49893 → 389 [SYN] Seq=0 Win=64240 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.0.42	192.168.0.1	TCP	66	[TCP Retransmission] 49893 → 389 [SYN] Seq=0 Win=64240 Len=0 MSS=1460 WS=256 SACK_PERM
```

See the following Wireshark trace example 2:

Member server or member client with RSAT File Services Tools installed.

```output
192.168.0.45	192.168.0.42	NETDFS	286	dfs_GetInfo request
192.168.0.42	192.168.0.45	NETDFS	214	dfs_GetInfo response, Error: WERR_BAD_NET_RESP
```

## Check the status of TCP/UDP port 389

> [!NOTE]
> After you apply the solution, remove the DFS Namespace from the DFS Management console and add it back, or close and reopen the console to make the changes to take effect.

Check the status of TCP/UDP port 389 (LDAP port) in your network and on the PDC or DC. Make sure that the communication over this port is allowed. The PDC or DC should be up and running.
