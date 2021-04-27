---
title: DAG network Misconfigured error
description: Misconfigured error occurs when using the Multi-NIC Cluster Network feature on an Exchange Server 2016 DAG node.
ms.date: 06/22/2020
author: Norman-sun
ms.author: v-swei
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
ms.prod: exchange-server-it-pro
localization_priority: Normal
ms.custom: 
- Exchange Server
- CSSTroubleshoot
ms.reviewer: 
appliesto:
- Exchange Server 2016 Standard Edition
- Exchange Server 2016 Enterprise Edition
search.appverid: MET150
---
# DAG network Misconfigured error in Exchange Server 2016

_Original KB number:_ &nbsp; 4075323

## Symptoms

Consider this scenario:

- You create a database availability group (DAG) for Exchange Server 2016.
- A node of the DAG contains two network interface cards (NICs) on the same subnet.

In this scenario, you see a **Misconfigured** error status when you view the **Subnet** status of the DAG in the Exchange Admin Center or you run the `Get-DatabaseAvailabilityGroupNetwork` cmdlet.

## Cause

The Multi-NIC Cluster Network feature of Windows Server 2016 is not supported by Exchange Server 2016.

## Resolution

Avoid using the Multi-NIC Cluster Network feature on an Exchange Server 2016 DAG node.

## References

For more information, see [Simplified SMB Multichannel and Multi-NIC Cluster Networks](/windows-server/failover-clustering/smb-multichannel).
