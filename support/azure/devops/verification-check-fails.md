---
title: Verification check fails
description: This article provides resolutions to the error that occurs when verification check fails.
ms.date: 08/18/2020
ms.custom: sap:Installation, Migration, and Move
ms.service: azure-devops-server
---
# Verification check fails with the error TF255435

This article helps you resolve the problem that occurs when verification check fails.

_Original product version:_ &nbsp; Microsoft Team Foundation Server  
_Original KB number:_ &nbsp; 2026258  

## Symptoms

Verification check fails with the following error:

```console
TF255435: This computer is a member of an Active Directory domain, but the domain controllers are not accessible.  
Network problems might be preventing access to the domain.
Verify that the network is operational, and then retry the readiness checks.
Other options include configuring Team Foundation Server specifying a local account in the custom wizard or joining the computer to a workgroup.
https://go.microsoft.com/fwlink/?LinkID=164053&clcid=0x409
```

## Cause

1. Domain controllers are not accessible. Most often this happens when someone is installing Team Foundation Server on a notebook joined to a company domain, while disconnected from the company network.
1. There are two or more computers joined to a domain with the same SID.  Most often this happens when VMs were cloned incorrectly.
1. The trust relationship between this workstation and the primary domain failed.

## Resolution

1. Make sure that the domain controllers are accessible.
1. Change computer SID to make it unique. See NewSID v4.10 for details.
1. Reset the computer in AD or disjoin and rejoin computer to the domain.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
