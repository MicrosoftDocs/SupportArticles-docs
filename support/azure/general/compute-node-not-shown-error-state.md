--- 
title: HPC compute nodes aren't shown or are in error state
description: Provides a solution for certificate and network errors that occur when you deploy an HPC Pack cluster on Azure.
ms.date: 09/14/2022
ms.reviewer: hclvteam, cargonz, v-weizhu
ms.service: hpcpack
---
# HPC compute nodes aren't shown or are in error state

This article provides a solution for an issue in which compute nodes aren't shown or are in an error state when you deploy a high-performance computing (HPC) cluster on Azure.

## Symptoms

When you deploy an HPC cluster on Azure, the deployment succeeds but compute nodes aren't shown or are in an error state. You see certificate and network-related errors in the HpcNodeManager service logs on the compute node.

Here's a network error example:

> System.Net.Sockets.SocketException: A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond x.x.x.x:xxx

## Cause

This issue occurs because of network configuration issues or some type of certificate mismatch.

## Resolution

Check network and certificate errors in the HpcNodeManager service logs on the compute node.

Correct certificate mismatches if there are any. For more information, see [Manage Certificates for HPC Pack 2019 Cluster](/powershell/high-performance-computing/manage-hpc-pack-certificates).

To resolve network issues with the error above, configure the Network Security Group rules and firewall rules. For more information, see the "Configure Network Security Group for Azure virtual network" section in [Burst to Azure IaaS VM from an HPC Pack Cluster](/powershell/high-performance-computing/hpcpack-burst-to-azure-iaas-nodes).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
