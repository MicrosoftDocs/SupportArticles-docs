---
title: The data is invalid or the namespace has no targets error
description: Helps resolve the error - The data is invalid or The namespace has no targets. This may be due to a corrupt or out of sync metadata.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, warrenw, v-lianna, albugn
ms.custom:
- sap:network connectivity and file sharing\dfs namespace (not replication)
- pcy:WinComm Networking
---
# Error "The data is invalid" or "The namespace has no targets. This may be due to a corrupt or out of sync metadata" with DFS Namespaces

This article helps resolve the error "The data is invalid" or "The namespace has no targets. This may be due to a corrupt or out of sync metadata."

When you access, modify, or create a Distributed File System (DFS) Namespace on a DFS Namespace server, domain member server, or Windows client with File Services tools (included in Remote Server Administration Tools (RSAT)) installed, you might receive one of the following error messages: 

- > The namespace cannot be queried. The data is invalid
- > The namespace cannot be queried. The namespace has no targets. This may be due to a corrupt or out of sync metadata.

## The registry value is corrupt or modified

This error occurs in relation to DFS stand-alone namespaces. The error can occur if the registry value `ID` or `Svc` with the `REG_BINARY` type, under the DFS stand-alone namespace root path is corrupt or modified.

The `ID` and `SVC` registry is stored under the DFS stand-alone namespace root path:

`Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DFS\Roots\Standalone\<YourDfsStandaloneNamespace>`

Wireshark trace error example when trying to access a DFS Namespace, which is hosted on a remote DFS Namespace server, using the DFS Management console:

```output
192.168.0.45	192.168.0.42	NETDFS	310	dfs_GetInfo request
192.168.0.42	192.168.0.45	NETDFS	214	dfs_GetInfo response, Error: WERR_INVALID_DATA
```

## Import the registry key from a valid registry backup

> [!NOTE]
> After you apply the solution, remove the DFS Namespace from the DFS Management console and add it back, or close and reopen the console to make the changes take effect.

[!INCLUDE [Registry important alert](../../includes/registry-important-alert.md)]

Importing the registry key for the DFS Namespace root from a valid registry backup (if available) of the same registry key can resolve the issue.

If no backup is present, and since you have only a single DFS root server in a DFS stand-alone namespace configuration, the only option is to delete the DFS Namespace, perform a DFS Namespace cleanup on the DFS root server, and re-create the DFS Namespace.

> [!NOTE]
> Restart the DFS server or the DFS server service so that the changes in the registries are loaded into memory again. Not restarting the DFS server or the DFS server service might result in the same error.
