---
title: NetBIOS and WINS don't bind to cluster IP address resources
description: Discusses a new behavior in which NetBIOS and WINS don't bind to cluster IP address resources
ms.date: 09/24/2021
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-server
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:setup-and-configuration-of-clustered-services-and-applications, csstroubleshoot
ms.subservice: high-availability
---
# NetBIOS and WINS don't bind to cluster IP address resources

This article provides a workaround for an issue where NetBIOS and WINS don't bind to cluster IP address resources.

_Applies to:_ &nbsp; Windows Server 2019, Windows Server 2016  
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
