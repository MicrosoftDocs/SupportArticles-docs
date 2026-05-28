---
title: DAG network misconfigured error
description: Misconfigured error occurs when using the Multi-NIC Cluster Network feature on an Exchange Server DAG node.
author: cloud-writer
ms.author: meerak
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.custom: 
  - sap:High Availability, Health, Performance, Content Indexing\Need Help Configuring DAG
  - Exchange Server
  - CSSTroubleshoot
  - CI 9823
  - CI 11523
ms.reviewer: v-six, v-kccross
appliesto: 
  - Exchange Server SE
  - Exchange Server 2019
  - Exchange Server 2016
search.appverid: MET150
ms.date: 05/27/2026
---

# DAG network misconfigured error in Exchange Server

_Original KB number:_ &nbsp; 4075323

## Summary

This article discusses an issue in which a database availability group (DAG) network shows a **Misconfigured** status when a DAG node uses multiple network adapters (also known as network interface cards or NICs) on the same subnet. The issue occurs because Microsoft Exchange Server doesn't support the Windows Multi-NIC Cluster Network feature. To resolve the issue, avoid configuring DAG nodes to use this feature.

## Symptoms

Consider the following scenario:

- You create a database availability group (DAG) for Exchange Server.
- A node of the DAG contains two network adapters on the same subnet.

In this scenario, you see a **Misconfigured** error status when you view the **Subnet** status of the DAG in the Exchange Admin Center, or you run the `Get-DatabaseAvailabilityGroupNetwork` PowerShell cmdlet.

## Cause

The Multi-NIC Cluster Network feature of Windows Server is not supported by Exchange Server.

## Resolution

Avoid using the Multi-NIC Cluster Network feature on an Exchange Server DAG node.

## References

For more information, see [Simplified SMB Multichannel and Multi-NIC Cluster Networks](/windows-server/failover-clustering/smb-multichannel).
