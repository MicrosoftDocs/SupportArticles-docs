---
title: Not enough memory resources are available to process this command error
description: Helps resolve the error - The namespace cannot be queried. Not enough memory resources are available to process this command.
ms.date: 09/27/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, warrenw, v-lianna, albugn
ms.custom: sap:Network Connectivity and File Sharing\DFS Namespace (Not Replication), csstroubleshoot
---
# Error "The namespace cannot be queried. Not enough memory resources are available to process this command" with DFS Namespaces

This article helps resolve the error "The namespace cannot be queried. Not enough memory resources are available to process this command."

When you access, modify, or create a Distributed File System (DFS) Namespace on a DFS Namespace server, domain member server, or Windows client with File Services tools (included in Remote Server Administration Tools (RSAT)) installed, you might receive the following error message:

> The namespace cannot be queried. Not enough memory resources are available to process this command

## The registry value is corrupt or modified

This error usually occurs in relation to DFS stand-alone namespaces. The error can occur if the registry value `Svc` with the `REG_BINARY` type, under the DFS stand-alone namespace root path is corrupt or modified.

The `Svc` registry is stored under the DFS stand-alone namespace root path:

`Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DFS\Roots\Standalone\<YourDfsStandaloneNamespace>`

Wireshark trace error example when trying to access a DFS Namespace, which is hosted on a remote DFS Namespace server, using the DFS Management console: 

```output
192.168.0.45	192.168.0.42	NETDFS	310	dfs_GetInfo request
192.168.0.42	192.168.0.45	NETDFS	214	dfs_GetInfo response, Error: ERR_NOT_ENOUGH_MEMORY
```

## Import the registry key from a valid registry backup

> [!NOTE]
> After you apply the solution, remove the DFS Namespace from the DFS Management console and add it back, or close and reopen the console to make the changes take effect.

[!INCLUDE [Registry important alert](../../includes/registry-important-alert.md)]

Importing the registry key for the DFS Namespace root from a valid registry backup (if available) of the same registry key can resolve the issue.

If no backup is present, and since you have only a single DFS root server in a DFS stand-alone namespace configuration, the only option is to delete the DFS Namespace, perform a DFS Namespace cleanup on the DFS root server, and re-create the DFS Namespace.

> [!NOTE]
> Restart the DFS server or the DFS server service so that the changes in the registries are loaded into memory again. Not restarting the DFS server or the DFS server service might result in the same error.
