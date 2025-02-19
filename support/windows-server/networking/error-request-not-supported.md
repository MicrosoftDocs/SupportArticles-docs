---
title: The request is not supported error
description: Helps resolve the error - Delegation information for the namespace cannot be queried. The request is not supported.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, warrenw, v-lianna, albugn
ms.custom: sap:Network Connectivity and File Sharing\DFS Namespace (Not Replication), csstroubleshoot
---
# Error "Delegation information for the namespace cannot be queried. The request is not supported" with DFS Namespaces

This article helps resolve the error "Delegation information for the namespace cannot be queried. The request is not supported."

When you access, modify, or create a Distributed File System (DFS) Namespace on a DFS Namespace server, domain member server, or Windows client with File Services tools (included in Remote Server Administration Tools (RSAT)) installed, you might receive the following error message: 

> Delegation information for the namespace cannot be queried. The request is not supported

This rare error is usually caused because of the way that the client requested information or because of the way how a client requested information, from the DFS Namespace server. Therefore, the cause should be investigated via data collection and data analysis from the moment the problem occurs.

See the following Wireshark trace for an example.

```output
192.168.0.45	192.168.0.42	NETDFS	310	dfs_GetInfo request
192.168.0.42	192.168.0.45	NETDFS	230	dfs_GetInfo response, Error: Unknown DOS error 0x00020000
```

Additionally, you might see a DFS Namespace server response with the error `ERROR_NOT_SUPPORTED`.

We recommend starting the data collection with a simultaneous network trace in the problematic scenario, and then comparing and analyzing your results with the trace from a working scenario.

A simultaneous trace in this case means you would run a network trace on:

- In a DFS stand-alone namespace configuration:  
  - one network trace on the machine from where you access the DFS Namespace remotely 
  - one network trace on the DFS Namespace server holding the DFS stand-alone namespace root
- In a DFS domain-based namespace configuration:  
  - one network trace on the machine from where you access the DFS Namespace remotely 
  - one network trace on the DFS Namespace server(s) holding the DFS domain-based namespace root
    > [!NOTE]
    > If you have only one DFS Namespace server holding the DFS domain-based namespace root  (not recommended), it will be straightforward to know the DFS Namespace server the source machine will connect to. However, if you have multiple DFS Namespace servers holding the DFS domain-based namespace root (recommended configuration), you might need to control or conclude on which DFS Namespace server your source machine will connect or just start a trace on all your DFS Namespace servers, of equal costs or priority.
    >
    > For more information about priority or referral ordering, see:
    >
    > - [Set the Ordering Method for Targets in Referrals](/windows-server/storage/dfs-namespaces/set-the-ordering-method-for-targets-in-referrals)
    > - [Set target priority to override referral ordering](/windows-server/storage/dfs-namespaces/set-target-priority-to-override-referral-ordering)
