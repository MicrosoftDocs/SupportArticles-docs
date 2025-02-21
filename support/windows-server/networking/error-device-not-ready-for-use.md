---
title: The device is not ready for use error
description: Helps resolve the error - The namespace cannot be queried. The device is not ready for use.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, warrenw, v-lianna, albugn
ms.custom:
- sap:network connectivity and file sharing\dfs namespace (not replication)
- pcy:WinComm Networking
---
# Error "The namespace cannot be queried. The device is not ready for use" with DFS Namespaces

This article helps resolve the error "The namespace cannot be queried. The device is not ready for use."

When you access, modify, or create a Distributed File System (DFS) Namespace on a DFS Namespace server, domain member server, or Windows client with File Services tools (included in Remote Server Administration Tools (RSAT)) installed, you might receive the following error message:

> The namespace cannot be queried. The device is not ready for use

## Cause 1: The registry values are missing

This error occurs in relation to DFS stand-alone namespaces. The error can occur if the registry value `ID` or `Svc` (or both) is missing. These registry keys have a `REG_BINARY` type and are located in a registry subkey (displayed like a unique identifier (UID) number) one level under the DFS stand-alone namespace root registry path.

Here is an example of where these registry values `ID` and `SVC` are stored under a UID looking subkey registry, under the DFS stand-alone namespace root registry path:

`Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DFS\Roots\Standalone\<YourDfsStandaloneNamespace>\<xxxxxxx-yyyy-zzzz>\`

> [!NOTE]
> For each DFS intermediate folder or DFS link that you create under the DFS stand-alone namespace root, a new UID subkey under the DFS stand-alone namespace root registry path `Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DFS\Roots\Standalone\<YourDfsStandaloneNamespace>` will be created.

Wireshark trace error example when trying to access a DFS Namespace, which is hosted on a remote DFS Namespace server, using the DFS Management console:

```output
192.168.0.45	192.168.0.42	NETDFS	286	dfs_GetInfo request
192.168.0.42	192.168.0.45	NETDFS	214	dfs_GetInfo response, Error: WERR_DEVICE_NOT_AVAILABLE
```

## Resolution for cause 1: Import the registry key from a valid registry backup

> [!NOTE]
> After you apply the solution, remove the DFS Namespace from the DFS Management console and add it back, or close and reopen the console to make the changes take effect.

[!INCLUDE [Registry important alert](../../includes/registry-important-alert.md)]

Importing the registry key for the DFS Namespace root from a valid registry backup (if available) of the same registry key can resolve the issue.

If no backup is present, and since you have only a single DFS root server for your namespace in a DFS stand-alone namespace configuration, the only option is to delete the DFS Namespace, perform a DFS Namespace cleanup on the DFS root server, and re-create the DFS Namespace.

> [!NOTE]
> Restart the DFS server or the DFS server service so that the changes in the registries are loaded into memory again. Not restarting the DFS server or the DFS server service might result in the same error.

## Cause 2: The PDC or DC can't be reached

The primary domain controller (PDC) or domain controller (DC) isn't reachable over TCP/UDP port 389 (Lightweight Directory Access Protocol (LDAP) port). The DFS Namespace server tries to reach the PDC or DC until it runs into an error or times out. Therefore, on the machine (that's a DFS Namespace server, member server, or member client with RSAT File Services tools installed) where you use the DFS Management console, you receive the error message "The device is not ready for use." This error occurs because the DFS Namespace server is still trying to reach the PDC or DC while you request the DFS Namespace information.

This error in such a scenario, usually shows for a short time, until all tries to reach the PDC or DC, will time out. Subsequent tries to view or access the DFS Namespace, via the DFS Management console, without applying the solution, can result in another known error (for example, "[The Namespace cannot be queried. The specified domain either does not exist or cannot be contacted](error-specified-domain-not-exist-cannot-contacted.md)"). 

## Resolution for cause 2: Check the status of TCP/UDP port 389

> [!NOTE]
> After you apply the solution, remove the DFS Namespace from the DFS Management console and add it back, or close and reopen the console to make the changes take effect.

Check the status of TCP/UDP port 389 (LDAP port) in your network and on the PDC or DC. Make sure that communication over this port is allowed. The PDC or DC should be up and running.
