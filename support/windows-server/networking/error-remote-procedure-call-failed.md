---
title: The remote procedure call failed error
description: Helps resolve the error "The namespace cannot be queried. The remote procedure call failed."
ms.date: 09/03/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, warrenw, v-lianna
ms.custom: sap:Network Connectivity and File Sharing\DFS Namespace (Not Replication), csstroubleshoot
---
# Error "The namespace cannot be queried. The remote procedure call failed" with DFS Namespaces

This article helps resolve the error "The namespace cannot be queried. The remote procedure call failed."

You may receive the following error message when you access, modify, or create a Distributed File System (DFS) Namespace on a DFS Namespace server, domain member server, or Windows client with File Services tools (included in Remote Server Administration Tools (RSAT)) installed.

> The namespace cannot be queried. The remote procedure call failed

## The DFS Namespace service stops responding

This issue occurs because the DFS Namespace service stops responding on the DFS Namespace server. You use the DFS Management console on a machine (member server or member client with RSAT File Services tools installed). After the machine connects successfully (via Remote Procedure Call (RPC)) to the DFS Namespace server, it eventually runs into a communication interruption over RPC.

> [!NOTE]
> If the DFS Namespace service doesn't restart or isn't manually started, subsequent tries to access the namespace via the DFS Management console will result in the error ["The Namespace cannot be queried. The RPC Server is unavailable"](#link of 194991_1 when published).

See the following Wireshark trace for an example.

Server Message Block (SMB) Create Request for `netdfs` is successful. The DFS Namespace service is still started or running:

```output
192.168.0.45	192.168.0.42	SMB2	190	Create Request File: netdfs
192.168.0.42	192.168.0.45	SMB2	210	Create Response File: netdfs
```

After the DFS Namespace service stops responding, the following error occurs:

```output
192.168.0.45	192.168.0.42	NETDFS	310	dfs_GetInfo request
192.168.0.42	192.168.0.45	SMB2	130	Ioctl Response, Error: STATUS_PIPE_BROKEN
```

## Start the DFS Namespace service

> [!NOTE]
> After you apply the solution, remove the DFS Namespace from the DFS Management console and add it back, or close and reopen the console to make the changes to take effect.

Run the following PowerShell cmdlet to check if the DFS Namespace service is running:

```powershell
Get-Service -Name Dfs
```

If the DFS Namespace service isn't started, run the following PowerShell cmdlet to start the DFS Namespace service:

```powershell
Start-Service -Name Dfs
```
