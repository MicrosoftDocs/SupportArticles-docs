---
title: Error the request is not supported 
description: Helps resolve the error "The namespace cannot be queried. The request is not supported."
ms.date: 09/03/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, warrenw, v-lianna
ms.custom: sap:Network Connectivity and File Sharing\DFS Namespace (Not Replication), csstroubleshoot
---
# Error "The namespace cannot be queried. The request is not supported" with DFS Namespaces

This article helps resolve the error "The namespace cannot be queried. The request is not supported."

You might receive the following error message when you access, modify, or create a Distributed File System (DFS) Namespace on a DFS Namespace server, domain member server, or Windows client with File Services tools (included in Remote Server Administration Tools (RSAT)) installed.

> The namespace cannot be queried. The request is not supported

Usually, the cause is the way that the client requests something from the DFS Namespace server. Therefore, the cause should be investigated via data collection and data analysis from the moment of the bad case scenario.

See the following Wireshark trace for an example.

```output
192.168.0.45	192.168.0.42	NETDFS	310	dfs_GetInfo request
192.168.0.42	192.168.0.45	NETDFS	230	dfs_GetInfo response, Error: Unknown DOS error 0x00020000
```

Additionally, you might see a DFS Namespace server response with the error `ERROR_NOT_SUPPORTED`.

We recommend starting the data collection with a simultaneous network trace in the bad case scenario, and comparing your results with the analysis of a good trace scenario.
