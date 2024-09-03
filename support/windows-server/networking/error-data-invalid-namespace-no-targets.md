---
title: Error not enough memory resources are available to process this command 
description: Helps resolve the error "The data is invalid" or "The Namespace has no targets. This may be due to a corrupt or out of sync metadata."
ms.date: 09/03/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, warrenw, v-lianna
ms.custom: sap:Network Connectivity and File Sharing\DFS Namespace (Not Replication), csstroubleshoot
---
# Error "The data is invalid" or "The Namespace has no targets. This may be due to a corrupt or out of sync metadata" with DFS Namespaces

This article helps resolve the error "The data is invalid" or "The Namespace has no targets. This may be due to a corrupt or out of sync metadata."

You might receive one of the following error messages when you access, modify, or create a Distributed File System (DFS) Namespace on a DFS Namespace server, domain member server, or Windows client with File Services tools (included in Remote Server Administration Tools (RSAT)) installed.

- > The namespace cannot be queried. The data is invalid
- > The namespace cannot be queried. The Namespace has no targets. This may be due to a corrupt or out of sync metadata.

## The registry value is corrupt or modified

The registry value `ID` or `Svc` with the `REG_BINARY` type under the DFS root, or other registry values under the registry subkeys of the DFS root are corrupt or modified. For example, under the following registry key:

`Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\DFS\Roots\Standalone\DFS2ST`

See the following Wireshark trace for an example. This is for the error "The namespace cannot be queried. The data is invalid."

```output
192.168.0.45	192.168.0.42	NETDFS	310	dfs_GetInfo request
192.168.0.42	192.168.0.45	NETDFS	214	dfs_GetInfo response, Error: WERR_INVALID_DATA
```

## Import the registry key from a valid registry backup

> [!NOTE]
> After you apply the solution, remove the DFS Namespace from the DFS Management console and add it back, or close and reopen the console to make the changes to take effect.

[!INCLUDE [Registry important alert](../../includes/registry-important-alert.md)]

Importing the registry key for the DFS Namespace root from a valid registry backup (if available) of the same registry key can resolve the issue.

If no backup is present and since in a DFS stand-alone namespace configuration, you have only a single DFS root server, the only option is to delete the DFS Namespace, perform a DFS Namespace cleanup on the DFS root server and re-create the DFS Namespace.

> [!NOTE]
> Restart the DFS server service, so that the changes in the registries are loaded again into memory. Not restarting the DFS server or the DFS server service may result in the same error.
