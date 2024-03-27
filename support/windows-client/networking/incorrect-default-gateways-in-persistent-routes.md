---
title: Additional gateways appear in persistent routes
description: Describes an issue in which using LBFO causes additional gateways to appear in persistent routes.
ms.date: 12/26/2023
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, Joelch
ms.custom: sap:Network Connectivity and File Sharing\TCP/IP Connectivity (TCP Protocol, NLA, WinHTTP), csstroubleshoot
---
# Additional default gateways may appear in persistent routes when you use LBFO

This article provides a solution to an issue where additional default gateways appear in persistent routes when you use Load Balancing and Failover (LBFO).

_Applies to:_ &nbsp; Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2966111

## Symptoms

Assume that a network adapter is configured with IP settings that include a default gateway. Later, an LBFO team is created that includes the previously configured network adapter. The newly created teamed network adapter is configured with IP settings. In this situation, you may see the previously configured default gateway route and the newly configured default gateway route in the "Persistent Route" section of the Route Print command output.

For example, if an adapter is configured with a default gateway of 10.0.0.1, and it is then added to an LBFO teamed adapter that is configured with a default gateway of 192.168.0.1, both default routes may appear under the "Persistent Route" section of the Route Print command output as shown here:

> \===========================================================================  
Persistent Routes:  
Network Address &nbsp; &nbsp; Netmask &nbsp; Gateway Address &nbsp; Metric  
0.0.0.0 &emsp; &emsp; &emsp; &emsp; &emsp;0.0.0.0 &emsp; &emsp; 10.0.0.1 &emsp; &emsp; &emsp;Default  
0.0.0.0 &emsp; &emsp; &emsp; &emsp; &emsp;0.0.0.0 &emsp; &emsp; 192.168.0.1&emsp;&emsp; Default  
\===========================================================================

However, in the "Active Routes" section of the Route Print command output, only the newly configured LBFO teamed adapter default gateway is present.

## Cause

This behavior is by design. The legacy route.exe tool does not indicate to which interface the routes in the "Persistent Routes" section are related. The Route Print command shows routes from the active network configuration store in the "Active Routes" section of the command output, and from the persistent network configuration store in the "Persistent Routes" section of the command output. However, the route.exe tool does not indicate to which adapter a persistent route belongs. Because the routes from the previously configured adapter are not in the active route table, there is no functional impact upon the active routing table or the networking behavior.

## Resolution

We recommend that you use the Get-NetRoute PowerShell cmdlet when clarity is needed about which routes are in the active store or persistent store, and to which adapters routes apply.

The Get-NetRoute PowerShell cmdlet allows for the administrator to see specifically what is stored in each networking configuration store and to which interface the route belongs.

For the persistent store:

```powershell
Get-NetRoute -AddressFamily IPv4 -PolicyStore PersistentStore
```

For the active store:

```powershell
Get-NetRoute -AddressFamily IPv4 -PolicyStore ActiveStore
```
