---
title: Element not found error with DFS Namespaces
description: Helps resolve the error - The namespace cannot be queried. Element not found.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, warrenw, v-lianna, albugn
ms.custom: sap:Network Connectivity and File Sharing\DFS Namespace (Not Replication), csstroubleshoot
---
# Error "The namespace cannot be queried. Element not found" with DFS Namespaces

This article helps resolve the error "The namespace cannot be queried. Element not found."

When you access, modify, or create a Distributed File System (DFS) Namespace on a DFS Namespace server, domain member server, or Windows client with File Services tools (included in Remote Server Administration Tools (RSAT)) installed, you might receive the following error message:

> The namespace cannot be queried. Element not found

## Cause 1: The registry key or registry values are missing or corrupt

### For domain-based DFS Namespaces

The entire registry key for the DFS Namespace root is missing or other registry values under the registry subkeys of the DFS Namespace root, are missing or corrupt.

- If the DFS Namespace root is missing, you will not find the DFS Namespace root name under:

  `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DFS\Roots\domainV2`

- If the following registry values under the DFS Namespace root name registry key path are either missing or are corrupt:

  `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DFS\Roots\domainV2\<YourDfsDomainNamespace>`

  Example of the correct entry for a DFS domain based root called `Public`:  
  Path: `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DFS\Roots\domainV2\Public`

  |Value name  |Value type  |Value data  |
  |---------|---------|---------|
  |`LogicalShare`     |`REG_SZ`         |`Public`         |
  |`RootShare`     |`REG_SZ`         |`Public`         |

  > [!NOTE]
  > In the preceding example, `Public` is the name of the DFS domain-based namespace root and `LogicalShare` and `RootShare` are the registry keys of type `REG_SZ`, that need to have as value data the name of the DFS Namespace root, `Public`.
  
### For stand-alone DFS Namespaces

The entire registry key for the DFS Namespace root is missing or other registry values under the registry subkeys of the DFS Namespace root, are missing or corrupt.

- If the DFS Namespace root is missing, you will not find the DFS Namespace root name under:

  `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DFS\Roots\Standalone`

- If the following registry values under the DFS Namespace root name registry key path are either missing or are corrupt:

  `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DFS\Roots\Standalone\<YourDfsStandaloneNamespace>`

  Example of the correct entry for a DFS stand-alone root called `StandaloneData`:  

  |Value name  |Value type  |Value data  |
  |---------|---------|---------|
  |`LogicalShare`     |`REG_SZ`         |`StandaloneData`         |
  |`RootShare`     |`REG_SZ`         |`StandaloneData`         |

  > [!NOTE]
  > In the preceding example, `StandaloneData` is the name of the DFS stand-alone namespace root (domain based) and `LogicalShare` and `RootShare` are the registry keys of type `REG_SZ`, that need to have as value data of the name of the DFS Namespace root, `StandaloneData`.  

Wireshark trace error example when trying to access a DFS Namespace, which is hosted on a remote DFS Namespace server, using the DFS Management console:

```output
192.168.0.45    192.168.0.42    NETDFS    310    dfs_GetInfo request 
192.168.0.42    192.168.0.45    NETDFS    214    dfs_GetInfo response, Error: WERR_NOT_FOUND
```

## Resolution for cause 1: Import the registry key from a valid registry backup

> [!NOTE]
> After you apply the solution, remove the DFS Namespace from the DFS Management console and add it back, or close and reopen the console to make the changes take effect.

[!INCLUDE [Registry important alert](../../includes/registry-important-alert.md)]

### For domain-based DFS Namespaces

Importing the registry key for the DFS Namespace root, from any other DFS root server holding the same DFS Namespace root or a valid registry backup (if available) of the same registry key, can resolve the issue.

If no backup is present and you have only a single DFS root server holding the DFS domain namespace, the fastest option is to delete the AD configuration of the DFS Namespace, run a DFS Namespaces cleanup on the DFS Namespace server and re-create the DFS Namespace. 

For more information about recovering a DFS Namespace, see [Recovery process of a DFS Namespace](recovery-process-of-dfs-namespace.md).

### For domain stand-alone DFS Namespaces

Importing the registry key for the DFS Namespace root from a valid registry backup (if available) of the same registry key can resolve the issue.

If no backup is present, and since you have only a single DFS root server in a DFS stand-alone namespace configuration, the only option is to delete the DFS Namespace, perform a DFS Namespace cleanup on the DFS root server, and re-create the DFS Namespace.

> [!NOTE]
> Restart the DFS server or the DFS server service so that the changes in the registries are loaded into memory again. Not restarting the DFS server or the DFS server service might result in the same error.

## Cause 2: The PDC or DC can't be reached or is down

You use the DFS Management console on a machine that's a DFS Namespace server, member server, or member client with RSAT File Services tools installed. In rare occasions this issue might also occur because the machine can't reach the primary domain controller (PDC) or domain controller (DC) over TCP/UDP port 389 (Lightweight Directory Access Protocol (LDAP) port), or the PDC or DC is down.
  
### Wireshark trace example

Tracing on a DFS Namespace server, member server, member client with RSAT File Services tools installed:

The Domain Name System (DNS) queries for LDAP SRV records are successful.

```output
192.168.0.42    192.168.0.2        DNS    110    Standard query 0x7685 SRV _ldap._tcp.pdc._msdcs.contoso.com
192.168.0.2        192.168.0.42    DNS    168    Standard query response 0x7685 SRV _ldap._tcp.pdc._msdcs.contoso.com SRV 0 100 389 SRVPdc.contoso.com A 192.168.0.1
```

However, establishing a TCP connection to the PDC will fail during the TCP three-way handshake.

```output
192.168.0.42    192.168.0.1    TCP    66    49893 → 389 [SYN, ECE, CWR] Seq=0 Win=64240 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.0.42    192.168.0.1    TCP    66    [TCP Retransmission] 49893 → 389 [SYN, ECE, CWR] Seq=0 Win=64240 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.0.42    192.168.0.1    TCP    66    [TCP Retransmission] 49893 → 389 [SYN] Seq=0 Win=64240 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.0.42    192.168.0.1    TCP    66    [TCP Retransmission] 49893 → 389 [SYN] Seq=0 Win=64240 Len=0 MSS=1460 WS=256 SACK_PERM
192.168.0.42    192.168.0.1    TCP    66    [TCP Retransmission] 49893 → 389 [SYN] Seq=0 Win=64240 Len=0 MSS=1460 WS=256 SACK_PERM
```

Or you might see the following error in the trace:

```output
192.168.0.45    192.168.0.42    NETDFS    310    dfs_GetInfo request 
192.168.0.42    192.168.0.45    NETDFS    214    dfs_GetInfo response, Error: WERR_NOT_FOUND
```

## Resolution for cause 2: Check the status of TCP/UDP port 389

> [!NOTE]
> After you apply the solution, remove the DFS Namespace from the DFS Management console and add it back, or close and reopen the console to make the changes take effect.

Check the status of TCP/UDP port 389 (LDAP port) in your network and on the PDC or DC. Make sure that communication over this port is allowed. The PDC or DC should be up and running.
