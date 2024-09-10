---
title: Element not found error with NFS namespaces
description: Helps resolve the error - The namespace cannot be queried. Element not found.
ms.date: 09/10/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, warrenw, v-lianna
ms.custom: sap:Network Connectivity and File Sharing\DFS Namespace (Not Replication), csstroubleshoot
---
# Error "The namespace cannot be queried. Element not found" with DFS namespaces

This article helps resolve the error "The namespace cannot be queried. Element not found."

When you access, modify, or create a Distributed File System (DFS) namespace on a DFS namespace server, domain member server, or Windows client with File Services tools (included in Remote Server Administration Tools (RSAT)) installed, you might receive the following error message:

> The namespace cannot be queried. Element not found

## Cause 1: The registry key or registry values are missing or corrupt

### For domain-based DFS namespaces

The registry key for the DFS namespace root is missing, or other registry values under the registry subkeys of the DFS root, are missing or corrupt. For example, under the following registry key:

`Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DFS\Roots\domainV2\DFS1`

The correct data for the registry values are:

|Value name  |Value type  |Value data  |
|---------|---------|---------|
|`LogicalShare`     |`REG_SZ`         |`DFS1`         |
|`RootShare`     |`REG_SZ`         |`DFS1`         |

### For domain stand-alone DFS namespaces

The registry key for the DFS namespace root is missing, or other registry values under the registry subkeys of the DFS root, are missing or corrupt. For example, under the following registry key:

`Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DFS\Roots\Standalone\DFS2St`

The correct data for the registry values are:

|Value name  |Value type  |Value data  |
|---------|---------|---------|
|`LogicalShare`     |`REG_SZ`         |`DFS2St`         |
|`RootShare`     |`REG_SZ`         |`DFS2St`         |

#### Wireshark trace example

```output
192.168.0.45	192.168.0.42	NETDFS	310	dfs_GetInfo request 
192.168.0.42	192.168.0.45	NETDFS	214	dfs_GetInfo response, Error: WERR_NOT_FOUND
```

## Resolution for cause 1: Import the registry key from a valid registry backup

> [!NOTE]
> After you apply the solution, remove the DFS namespace from the DFS Management console and add it back, or close and reopen the console to make the changes take effect.

[!INCLUDE [Registry important alert](../../includes/registry-important-alert.md)]

### For domain-based DFS namespaces

Importing the registry key for the DFS namespace root from any other DFS root server holding the same DFS namespace root or a valid registry backup (if available) of the same registry key can resolve the issue.

If no backup is present, and since you have only a single DFS root server in a DFS stand-alone namespace configuration, the only option is to delete the Active Directory (AD) configuration of the DFS namespace, perform a DFS namespace cleanup on the DFS namespace server, and re-create the DFS namespace.

> [!NOTE]
> Restart the DFS server or the DFS server service so that the changes in the registries are loaded into memory again. Not restarting the DFS server or the DFS server service might result in the same error.

### For domain stand-alone DFS namespaces

Importing the registry key for the DFS Namespace root from a valid registry backup (if available) of the same registry key can resolve the issue.

If no backup is present, and since you have only a single DFS root server in a DFS stand-alone namespace configuration, the only option is to delete the DFS namespace, perform a DFS namespace cleanup on the DFS root server, and re-create the DFS namespace.

> [!NOTE]
> Restart the DFS server or the DFS server service so that the changes in the registries are loaded into memory again. Not restarting the DFS server or the DFS server service might result in the same error.

## Cause 2: The PDC or DC can't be reached or is down

You use the DFS Management console on a machine that's a DFS namespace server, member server, or member client with RSAT File Services tools installed. This issue occurs because the machine can't reach the primary domain controller (PDC) or domain controller (DC) over TCP/UDP port 389 (Lightweight Directory Access Protocol (LDAP) port), or the PDC or DC is down.
  
### Wireshark trace example

Tracing on a DFS namespace server, member server, member client with RSAT File Services tools installed:

The Domain Name System (DNS) queries for LDAP SRV records are successful.

```output
192.168.0.42	192.168.0.2	    DNS	110	Standard query 0x7685 SRV _ldap._tcp.pdc._msdcs.contoso.com
192.168.0.2	    192.168.0.42	DNS	168	Standard query response 0x7685 SRV _ldap._tcp.pdc._msdcs.contoso.com SRV 0 100 389 SRVPdc.contoso.com A 192.168.0.1
```

However, establishing a TCP connection to the PDC doesn't fail during the TCP three-way handshake.

```output
192.168.0.42	192.168.0.1	TCP	66	49893 → 389 [SYN, ECE, CWR] Seq=0 Win=64240 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.0.42	192.168.0.1	TCP	66	[TCP Retransmission] 49893 → 389 [SYN, ECE, CWR] Seq=0 Win=64240 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.0.42	192.168.0.1	TCP	66	[TCP Retransmission] 49893 → 389 [SYN] Seq=0 Win=64240 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.0.42	192.168.0.1	TCP	66	[TCP Retransmission] 49893 → 389 [SYN] Seq=0 Win=64240 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.0.42	192.168.0.1	TCP	66	[TCP Retransmission] 49893 → 389 [SYN] Seq=0 Win=64240 Len=0 MSS=1460 WS=256 SACK_PERM
```

You might see the following error:

```output
192.168.0.45	192.168.0.42	NETDFS	310	dfs_GetInfo request 
192.168.0.42	192.168.0.45	NETDFS	214	dfs_GetInfo response, Error: WERR_NOT_FOUND
```

## Resolution for cause 2: Check the status of TCP/UDP port 389

> [!NOTE]
> After you apply the solution, remove the DFS namespace from the DFS Management console and add it back, or close and reopen the console to make the changes take effect.

Check the status of TCP/UDP port 389 (LDAP port) in your network and on the PDC or DC. Make sure that communication over this port is allowed. The PDC or DC should be up and running.
