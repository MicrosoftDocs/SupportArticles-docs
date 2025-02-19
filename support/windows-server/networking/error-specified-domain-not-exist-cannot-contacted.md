---
title: The specified domain either does not exist or cannot be contacted error
description: Helps resolve the error - The namespace cannot be queried. The specified domain either does not exist or cannot be contacted.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, warrenw, v-lianna, albugn
ms.custom: sap:Network Connectivity and File Sharing\DFS Namespace (Not Replication), csstroubleshoot
---
# Error "The namespace cannot be queried. The specified domain either does not exist or cannot be contacted" with DFS Namespaces

This article helps resolve the error "The namespace cannot be queried. The specified domain either does not exist or cannot be contacted."

When you access, modify, or create a Distributed File System (DFS) Namespace on a DFS Namespace server, domain member server, or Windows client with File Services tools (included in Remote Server Administration Tools (RSAT)) installed, you might receive the following error message: 

> The namespace cannot be queried. The specified domain either does not exist or cannot be contacted

## Cause 1: The PDC or DC can't be reached or is down

You use the DFS Management console on a machine that's a DFS Namespace server, member server, or member client with RSAT File Services tools installed. This issue occurs because the machine, from where you are using the DFS Management console, can't reach the primary domain controller (PDC) or local domain controller (DC) over TCP/UDP port 389 (Lightweight Directory Access Protocol (LDAP) port), or the PDC or DC is down.

### Wireshark trace scenario 1

Tracing on a DFS Namespace server:

The Domain Name System (DNS) queries for LDAP SRV records are successful.

```output
192.168.0.42	192.168.0.2	DNS	93	Standard query 0x882e SRV _ldap._tcp.pdc._msdcs.contoso.com
192.168.0.2	192.168.0.42	DNS	167	Standard query response 0x882e SRV _ldap._tcp.pdc._msdcs.contoso.com SRV 0 100 389 SRVPdc.contoso.com A 192.168.0.1
```

However, Connectionless Lightweight Directory Access Protocol (CLDAP) requests sent over UDP port 389 to the PDC aren't responded to, resulting in failed UDP connections.

```output
192.168.0.42	192.168.0.1	CLDAP	242	searchRequest(48) "<ROOT>" baseObject 
192.168.0.42	192.168.0.1	CLDAP	242	searchRequest(49) "<ROOT>" baseObject
```

### Wireshark trace scenario 2

Tracing on a member server or a member client with RSAT File Services tools installed:

The DNS queries for LDAP SRV records are successful.

```output
192.168.0.45	192.168.0.2	DNS	93	Standard query 0x685e SRV _ldap._tcp.pdc._msdcs.contoso.com
192.168.0.2	192.168.0.45	DNS	167	Standard query response 0x685e SRV _ldap._tcp.pdc._msdcs.contoso.com SRV 0 100 389 SRVPdc.contoso.com A 192.168.0.1
```

However, CLDAP requests sent over UDP port 389 to the PDC aren't responded to, resulting in failed UDP connections.

```output
192.168.0.45	192.168.0.1	CLDAP	242	searchRequest(30) "<ROOT>" baseObject 
192.168.0.45	192.168.0.1	CLDAP	242	searchRequest(31) "<ROOT>" baseObject
```

In addition, you might see the following `NETDFS` response error received from the DFS Namespace server:

```output
192.168.0.45	192.168.0.42	NETDFS	286	dfs_GetInfo request
192.168.0.42	192.168.0.45	NETDFS	214	dfs_GetInfo response, Error: WERR_NO_SUCH_DOMAIN 
```

## Resolution for cause 1: Check the status of TCP/UDP port 389

> [!NOTE]
> After you apply the solution, remove the DFS Namespace from the DFS Management console and add it back, or close and reopen the console to make the changes take effect.

Check the status of TCP/UDP port 389 (LDAP port) in your network and on the PDC or DC. Make sure that communication over this port is allowed. The PDC or DC should be up and running.

## Cause 2: LDAP SRV records for the PDC are missing

The LDAP SRV records for the PDC are missing under the`_ldap._tcp.pdc._msdcs.contoso.com` DNS zone.

### Wireshark trace example

```output
192.168.0.42	192.168.0.2	DNS	93	Standard query 0x337d SRV _ldap._tcp.pdc._msdcs.contoso.com
192.168.0.2	192.168.0.42	DNS	151	Standard query response 0x337d No such name SRV _ldap._tcp.pdc._msdcs.contoso.com SOA SRVPdc.contoso.com
```

## Resolution for cause 2: Make sure all missing LDAP SRV records are present

> [!NOTE]
> After you apply the solution, remove the DFS Namespace from the DFS Management console and add it back, or close and reopen the console to make the changes take effect.

Make sure all missing LDAP SRV records (for the DCs in your domain) under the `_msdcs.contoso.com` DNS zone are present.

> [!NOTE]
> Restarting the Netlogon service on domain controllers should repopulate all missing SRV records under the `_msdcs.contoso.com` zone. Make sure that AD replication is possible or runs successfully so that the changes related to the SRV records are replicated correctly throughout your domain.
