---
title: The device is not ready for use error
description: Helps resolve the error - The namespace cannot be queried. The device is not ready for use.
ms.date: 09/10/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, warrenw, v-lianna
ms.custom: sap:Network Connectivity and File Sharing\DFS Namespace (Not Replication), csstroubleshoot
---
# Error "The namespace cannot be queried. The device is not ready for use" with DFS Namespaces

This article helps resolve the error "The namespace cannot be queried. The device is not ready for use."

When you access, modify, or create a Distributed File System (DFS) namespace on a DFS namespace server, domain member server, or Windows client with File Services tools (included in Remote Server Administration Tools (RSAT)) installed, you might receive the following error message:

> The namespace cannot be queried. The device is not ready for use

## Cause 1: The registry values are missing

The registry values `ID` and `Svc` with the `REG_BINARY` type under the DFS root, or other registry values under the registry subkeys of the DFS root, are missing. For example, under the following registry key:

`Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DFS\Roots\Standalone\DFS2ST\1e2e08a9-75f1-43d9-b3df-3c3614d843c1`

### Wireshark trace example

```output
192.168.0.45	192.168.0.42	NETDFS	286	dfs_GetInfo request
192.168.0.42	192.168.0.45	NETDFS	214	dfs_GetInfo response, Error: WERR_DEVICE_NOT_AVAILABLE
```

## Resolution for cause 1: Import the registry key from a valid registry backup

> [!NOTE]
> After you apply the solution, remove the DFS namespace from the DFS Management console and add it back, or close and reopen the console to make the changes take effect.

[!INCLUDE [Registry important alert](../../includes/registry-important-alert.md)]

Importing the registry key for the DFS namespace root from a valid registry backup (if available) of the same registry key can resolve the issue.

If no backup is present, and since you have only a single DFS root server for your namespace in a DFS stand-alone namespace configuration, the only option is to delete the DFS namespace, perform a DFS namespace cleanup on the DFS root server, and re-create the DFS namespace.

> [!NOTE]
> Restart the DFS server or the DFS server service so that the changes in the registries are loaded into memory again. Not restarting the DFS server or the DFS server service might result in the same error.

## Cause 2: The PDC or DC can't be reached

The primary domain controller (PDC) or domain controller (DC) isn't reachable over TCP/UDP port 389 (Lightweight Directory Access Protocol (LDAP) port). The DFS namespace server tries to reach the PDC or DC until it runs into an error or times out. Therefore, on the machine (that's a DFS namespace server, member server, or member client with RSAT File Services tools installed) where you use the DFS Management console, you get the error message "The device is not ready for use." This error occurs because the DFS namespace server is still trying to reach the PDC or DC while you request the DFS namespace information.

This error variant usually shows for a short time until reaching the PDC or DC times out. Subsequent tries to view or access the DFS namespace via the DFS Management console without applying the solution can result in other error variants (for example, "The Namespace cannot be queried. The specified domain either does not exist or cannot be contacted").

## Resolution for cause 2: Check the status of TCP/UDP port 389

> [!NOTE]
> After you apply the solution, remove the DFS namespace from the DFS Management console and add it back, or close and reopen the console to make the changes take effect.

Check the status of TCP/UDP port 389 (LDAP port) in your network and on the PDC or DC. Make sure that communication over this port is allowed. The PDC or DC should be up and running.
