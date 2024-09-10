---
title: The request is not supported erro
description: Helps resolve the error - The namespace cannot be queried. The request is not supported.
ms.date: 09/10/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, warrenw, v-lianna
ms.custom: sap:Network Connectivity and File Sharing\DFS Namespace (Not Replication), csstroubleshoot
---
# Error "The namespace cannot be queried. The request is not supported" with DFS namespaces

This article helps resolve the error "The namespace cannot be queried. The request is not supported."

When you access, modify, or create a Distributed File System (DFS) namespace on a DFS namespace server, domain member server, or Windows client with File Services tools (included in Remote Server Administration Tools (RSAT)) installed, you might receive the following error message: 

> The namespace cannot be queried. The request is not supported

Usually, the cause is the way that the client requests something from the DFS namespace server. Therefore, the cause should be investigated via data collection and data analysis from the moment the probelm occurs.

See the following Wireshark trace for an example.

```output
192.168.0.45	192.168.0.42	NETDFS	310	dfs_GetInfo request
192.168.0.42	192.168.0.45	NETDFS	230	dfs_GetInfo response, Error: Unknown DOS error 0x00020000
```

Additionally, you might see a DFS namespace server response with the error `ERROR_NOT_SUPPORTED`.

We recommend starting the data collection with a simultaneous network trace in the problematic scenario, and then comparing and analyzing your results with the trace from a working scenario.
