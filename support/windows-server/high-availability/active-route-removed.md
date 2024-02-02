---
title: Active Route removed
description: This article provides a solution to an issue that the Active route is removed when you add a static persistent route to a network adapter.
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika, johnmar
ms.custom: sap:cannot-bring-a-resource-online, csstroubleshoot
ms.subservice: high-availability
---
# Active Route removed on Windows Server Failover Cluster

This article provides a solution to an issue that the Active route is removed when you add a static persistent route to a network adapter.

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2161341

## Symptoms

When you add a static persistent route to a network adapter that is on a Windows Server 2008 Failover Cluster and take a clustered IP Address offline (or move it to another node), the "Active" route is removed and no connections can be made using this route even though it still shows as persistent when running the ROUTE PRINT command. Once you bring the Clustered IP Address back online, the active route is returned.

## Cause

When a clustered IP Address goes offline, it takes down the "active" route that was added as a persistent route as well. This will only occur when both of the following are true:

1. Windows Server 2008 or Server 2008 R2 Failover Clustering is configured
2. Static Routes are being added with ROUTE.EXE

## Resolution

When using the ROUTE.EXE command, the most common command to add a persistent would be this:

*route -p add 10.51.0.0 mask 255.255.0.0 10.44.60.1*  
This command does not specify the specific interface to bind to. Because it is not bound to a specific interface, it is removed as an active route. In the example above, the route being specified to the gateway is the same card (network) that a Clustered IP Address is on.

To keep the "active" route, you must also specify the interface as part of the command. For example, if the network card interface is 18, the command would be:
 *route -p add 10.51.0.0 mask 255.255.0.0*10.44.60.1 if 18*  

## More information

In Windows 2008 and above, the supported method for adding a persistent route is to also include the network card interface. There are two methods to determine the interface number of the network card. When executing the ROUTE PRINT or NETSH command, it will give you the interfaces at the top first. Something similar to this:

```console
C:\>route print
IPv4 Route Table
========================================
Interface List
23 ...00 15 5d 4a ac 06 ...... Local Gigabit Controller
19 ...00 15 5d 4a ac 01 ...... Local Gigabit Controller #2
18 ...00 15 5d 4a ac 00 ...... Local Gigabit Controller #3
========================================
```

-or-

```console
C:\>netsh int ipv4 show int
Idx Met MTU State Name
--- --- ----- ----------- -------------------
18 50 4294967295 connected Local Gigabit Controller #3
19 5 1500 connected Local Gigabit Controller #2
23 5 1500 connected Local Gigabit Controller
```
