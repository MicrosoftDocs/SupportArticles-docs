---
title: Servers can't be used as print servers
description: Describes why Network Load Balancing (NLB) failover cluster servers can't be used as print servers in Microsoft Windows Server-based computers. Also describes the best practices for efficient print servers.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:management-and-configuration:-general-issues, csstroubleshoot
ms.subservice: printing
---
# Servers in a NLB failover cluster can't be used as print servers in Windows Server 2012 R2

This article describes why Network Load Balancing (NLB) failover cluster servers can't be used as print servers in Microsoft Windows Server-based computers. This article also describes the different ways to configure efficient print servers.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 954420

## Summary

Network Load Balancing (NLB) that is configured in a failover cluster offers high performance in environments in which each request from a client is stateless, and there's no in-memory application state to maintain. You can't implement this configuration together with a print server. It's because print servers maintain lots of state information for each printer and client with which they're communicating. Print jobs may span several communication requests. So all requests must be handled by the same node. In a failover cluster environment, only a single node communicates with print devices and client computers at one time. Most networked print devices can deal with multiple requests from different computers on the network. However, each print server or cluster node is aware only of its load on the printer. Each server or node can spool jobs only when the print device reports that it's ready to accept new jobs. Print devices typically accept only one print job at a time.

When a print job is given to a print server, the print job itself can span multiple communication requests between the client and the server. In an NLB environment, you can't make sure that each request is being processed by the same node. Other information, such as print job status information, wouldn't even be possible in an NLB cluster configuration. It's because each node would have no information about the work that is being processed by the other nodes.

Because of the resource limitations in the print devices and their communication process with specific nodes in a cluster, NLB failover clustering can't be used for a print server. Even if it were possible to send a print job successfully to an NLB failover cluster, there would be no gains in the general performance, and it would come at a significant loss of functionality and network efficiency. Gains in performance on a specific print server (failover cluster or stand-alone) would be easier to achieve by using other strategies that wouldn't affect the management functionality of the print infrastructure.

## Configure an efficient print server

When the load of a print server is too high, and print requests can no longer be serviced even while printers are sitting idle, follow these steps to improve the throughput on the servers:

- Enable Client Side Rendering (CSR) on as many clients as possible  
    This reduces the work the server has to do on each print job by rendering the print job on the individual clients before it sends the job to the server. Windows Vista-based and newer computers support CSR.

- Increase the resources on the server  
    If a server is the cause of poor performance, it will most likely encounter problems with insufficient processor power, or memory. Increasing the capabilities of those components should improve the responsiveness of the server.

- Increase the number of servers  
    The print infrastructure can be split across multiple servers, and new print devices can be rolled out onto new servers. Existing print devices can be relocated to the new server, but additional work would be required to migrate the existing connection clients have to the printer to reference the new server.

Another problem in a network environment is a shortage of printers. This would be the case when print jobs are queuing correctly but not enough printers are available to handle the work load. If you add more printers, overall print capacity will increase. Printer pooling can be used to make this seamless for users if the printers in the pool are colocated. In some cases, printers will sit in an error state because of insufficient paper or ink, or because of an error, such as a paper jam. If you have staff to deal with printers that are offline or in an error state, you can increase the overall throughput of the print infrastructure and sustain your current number of devices while dealing with heavy workloads.

For environments that require high availability, you can use a failover cluster as a print server. If a node in the cluster fails, all print functionality will fail over to the next node in the cluster. To improve failover times, we recommend that the administrator for the cluster force failover to each node when new print drivers are installed on the server. During a failover, the driver installation is forced to occur on the active node. The installation of the driver on each node can require several minutes. Forcing this installation process during maintenance will make sure that any unplanned failovers during usual operation will be quick, because the drivers will already be installed on each node.
