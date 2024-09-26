---
title: The request is not supported error
description: Helps resolve the error - Delegation information for the namespace cannot be queried. The request is not supported.
ms.date: 09/26/2024
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, warrenw, v-lianna, albugn
ms.custom: sap:Network Connectivity and File Sharing\DFS Namespace (Not Replication), csstroubleshoot
---
# Error "Delegation information for the namespace cannot be queried. The request is not supported" with DFS namespaces

This article helps resolve the error "Delegation information for the namespace cannot be queried. The request is not supported."

When you access, modify, or create a Distributed File System (DFS) namespace on a DFS namespace server, domain member server, or Windows client with File Services tools (included in Remote Server Administration Tools (RSAT)) installed, you might receive the following error message: 

> Delegation information for the namespace cannot be queried. The request is not supported

This rare error is usually caused because of the way that the client requested information or because of the way how a client requested information, from the DFS Namespace server. Therefore, the cause should be investigated via data collection and data analysis from the moment the problem occurs.

See the following Wireshark trace for an example.

```output
192.168.0.45	192.168.0.42	NETDFS	310	dfs_GetInfo request
192.168.0.42	192.168.0.45	NETDFS	230	dfs_GetInfo response, Error: Unknown DOS error 0x00020000
```

Additionally, you might see a DFS namespace server response with the error `ERROR_NOT_SUPPORTED`.

We recommend starting the data collection with a simultaneous network trace in the problematic scenario, and then comparing and analyzing your results with the trace from a working scenario.

A simultaneous trace in this case means you would run a network trace on:

- In a DFS stand-alone namespace configuration:  
  - one network trace on the machine from where you access the DFS Namespace remotely 
  - one network trace on the DFS Namespace server holding the DFS stand-alone namespace root
- In a DFS domain namespace configuration:  
  - one network trace on the machine from where you access the DFS namespace remotely 
  - one network trace on the DFS Namespace servers holding the DFS domain namespace root
