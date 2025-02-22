---
title: NetBIOS and WINS don't bind to cluster IP address resources
description: Discusses a new behavior in which NetBIOS and WINS don't bind to cluster IP address resources
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, jeffhugh
ms.custom:
- sap:clustering and high availability\setup and configuration of clustered services and applications
- pcy:WinComm Storage High Avail
---
# NetBIOS and WINS don't bind to cluster IP address resources

This article provides a workaround for an issue where NetBIOS and WINS don't bind to cluster IP address resources.

_Applies to:_ &nbsp; All supported versions of Windows Server  
_Original KB number:_ &nbsp; 4556018

## Symptoms

Assume that you have an environment in which cluster servers are running Windows Server 2016 or a later version of Windows. You notice the following issues:

- Issue 1

    Applications that depend on NetBIOS (TCP port 139) connectivity to cluster resources cannot connect to the Cluster service.

- Issue 2

    The WINS name resolution service does not respond to incoming queries or registration requests on cluster networks.

## Cause

This behavior is by design. It occurs because NetBIOS no longer binds to IP address resources in Windows Server 2016 or later versions of the Windows Server-based Cluster service.

## Workaround

To work around this behavior, use the Cluster Management console to determine the name of the IP address resource that must be changed.  
After you determine the IP address resource, run the following commands in an elevated PowerShell window. In the commands, substitute the name of the actual IP address resource.  

```powershell
Get-ClusterResource"resource name"| Set-ClusterParameter EnableNetBIOS 1
Stop-ClusterResource"resource name"
Start-ClusterResource"resource name"
```
