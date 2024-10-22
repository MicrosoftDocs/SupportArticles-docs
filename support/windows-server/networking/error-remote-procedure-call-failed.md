---
title: The remote procedure call failed error
description: Helps resolve the error - The namespace cannot be queried. The remote procedure call failed.
ms.date: 09/25/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, warrenw, v-lianna, albugn
ms.custom: sap:Network Connectivity and File Sharing\DFS Namespace (Not Replication), csstroubleshoot
---
# Error "The namespace cannot be queried. The remote procedure call failed" with DFS Namespaces

This article helps resolve the error "The namespace cannot be queried. The remote procedure call failed."

When you access, modify, or create a Distributed File System (DFS) Namespace on a DFS Namespace server, domain member server, or Windows client with File Services tools (included in Remote Server Administration Tools (RSAT)) installed, you might receive the following error message:

> The namespace cannot be queried. The remote procedure call failed

## The DFS Namespace service stops responding

You use the DFS Management console, on a machine that's a member server or a member client with RSAT File Services tools installed, to view, manage or perform changes in a DFS Namespace. This issue occurs because the DFS Namespace service running on the DFS Namespace server you have (just moments ago) successfully connected to (via Remote Procedure Call (RPC) over Transmission Control Protocol (TCP)), crashes or stops responding.

> [!NOTE]
> If the DFS Namespace service doesn't restart or isn't manually started on the DFS Namespace server, subsequent tries to access the namespace via the DFS Management console will result in the error "[The Namespace cannot be queried. The RPC Server is unavailable](namespace-not-queried-rpc-server-unavailable.md)."

### Wireshark trace example

The Server Message Block (SMB) Create Request for `netdfs` is successful. The DFS Namespace service is still started or running:

```output
192.168.0.45    192.168.0.42    SMB2    190    Create Request File: netdfs
192.168.0.42    192.168.0.45    SMB2    210    Create Response File: netdfs
```

After the DFS Namespace service stops responding, the following error occurs:

```output
192.168.0.45    192.168.0.42    NETDFS    310    dfs_GetInfo request
192.168.0.42    192.168.0.45    SMB2    130    Ioctl Response, Error: STATUS_PIPE_BROKEN
```

## Start the DFS Namespace service

> [!NOTE]
> After you apply the solution, remove the DFS Namespace from the DFS Management console and add it back, or close and reopen the console to make the changes take effect.

To resolve the issue, start the DFS Namespace service.

Run the following PowerShell cmdlet to check if the DFS Namespace service is running:

```powershell
Get-Service -Name Dfs
```

If the DFS Namespace service isn't started, run the following PowerShell cmdlet to start the DFS Namespace service:

```powershell
Start-Service -Name Dfs
```
