---
title: Error the device is not ready for use 
description: Helps resolve the error "The namespace cannot be queried. The device is not ready for use."
ms.date: 09/05/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, warrenw, v-lianna
ms.custom: sap:Network Connectivity and File Sharing\DFS Namespace (Not Replication), csstroubleshoot
---
# Error "The namespace cannot be queried. The device is not ready for use" with DFS Namespaces

This article helps resolve the error "The namespace cannot be queried. The device is not ready for use."

You might receive the following error message when you access, modify, or create a Distributed File System (DFS) Namespace on a DFS Namespace server, domain member server, or Windows client with File Services tools (included in Remote Server Administration Tools (RSAT)) installed.

> The namespace cannot be queried. The device is not ready for use

## Cause 1: The registry values are missing

The registry values `ID` and `Svc` with the `REG_BINARY` type under the DFS root, or other registry values under the registry subkeys of the DFS root are missing. For example, under the following registry key:

`Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DFS\Roots\Standalone\DFS2ST\1e2e08a9-75f1-43d9-b3df-3c3614d843c1`

### Wireshark trace example

```output
192.168.0.45	192.168.0.42	NETDFS	286	dfs_GetInfo request
192.168.0.42	192.168.0.45	NETDFS	214	dfs_GetInfo response, Error: WERR_DEVICE_NOT_AVAILABLE
```

## Resolution 1: Import the registry key from a valid registry backup

> [!NOTE]
> After you apply the solution, remove the DFS Namespace from the DFS Management console and add it back, or close and reopen the console to make the changes to take effect.

[!INCLUDE [Registry important alert](../../includes/registry-important-alert.md)]

Importing the registry Key for the DFS Namespace root from a valid registry backup (if available) of the same registry key can resolve the issue.

If no backup is present and since in a DFS stand-alone namespace configuration you have only a single DFS root server for your namespace, the only option is to delete the DFS Namespace, perform a DFS Namespace cleanup on the DFS root server and re-create the DFS Namespace.

> [!NOTE]
> Restart the DFS server service, so that the changes in the registries are loaded again into memory. Not restarting the DFS server or the DFS server service may result in the same error.

## Cause 2: The PDC or DC can't be reached

The primary domain controller (PDC) or domain controller (DC) isn’t reachable over TCP/UDP port 389 (Lightweight Directory Access Protocol (LDAP) port). The DFS Namespace server tries to reach the PDC or DC, until it runs into an error or timeout. Therefore, on the machine (DFS Namespace server, member server, or member client with RSAT File Services Tools installed), from where you use the DFS Management console, you get the error message "The device is not ready for use." This is because the DFS Namespace server is still in the process of trying to reach the PDC or DC, while you request the DFS Namespace information.

This error variation usually shows for a short time, until the timeout for reaching the PDC or DC occurs. Subsequent tries to view or access the DFS Namespace via the DFS Management console, without applying the solution, can result in other error variations (for example, "The Namespace cannot be queried. The specified domain either does not exist or cannot be contacted").

## Resolution 2: Check the status of TCP/UDP port 389

> [!NOTE]
> After you apply the solution, remove the DFS Namespace from the DFS Management console and add it back, or close and reopen the console to make the changes to take effect.

Check the status of TCP/UDP port 389 (LDAP port) in your network and on the PDC or DC. Make sure that the communication over this port is allowed. The PDC or DC should be up and running.
