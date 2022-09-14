--- 
title: HPC compute nodes aren't shown or in error state
description: Provides a solution for certificate and network errors that occur when you deploy an HPC Pack cluster on Azure.
ms.date: 9/14/2022
author: AmandaAZ
ms.author: v-weizhu
ms.reviewer: hclvteam
---
# HPC compute nodes aren't shown or in error state

This article provides a solution for an issue that compute nodes aren't shown or in error state when you deploy a high-performance computing (HPC) cluster on Azure.

## Symptoms

When you deploy an HPC cluster on Azure, the deployment succeeds but compute nodes aren't shown or in error state. You see certificate and network related errors in the HpcNodeManager service logs on the compute node.

Here's a network error example:

> System.Net.Sockets.SocketException: A connection attempt failed because the connected party did not properly respond after a period of time, or established connection failed because connected host has failed to respond x.x.x.x:xxx

## Cause

This issue occurs because of network configuration issues or some types of certificate mismatch.

## Resolution

Check network and certificate errors in the HpcNodeManager service logs on the compute node.

Correct certificate mismatches if there are.

To resolve network issues with the error above, configure the Network Security Group rules and firewall rules. For more information, see [Configure Network Security Group for Azure virtual network](https://docs.microsoft.com/powershell/high-performance-computing/hpcpack-burst-to-azure-iaas-nodes?view=hpc19-ps#BKMK_nsg)

## References

- Slide 11 of [Microsoft HPC Pack Support Training.pptx](https://supportability.visualstudio.com/78a7ff76-f175-4f9e-8e72-04fdfd3daeaa/_apis/git/repositories/e867a613-d78e-4a79-9cfe-26b87fa45571/Items?path=/.attachments/Microsoft%20HPC%20Pack%20Support%20Training-0d3a9b9c-9462-48e0-a91c-e4cfe99f1780.pptx&download=false&resolveLfs=true&%24format=octetStream&api-version=5.0-preview.1&sanitize=true&versionDescriptor.version=wikiMaster)
- [HPC Pack Video 1: HPC Pack Support](https://web.microsoftstream.com/video/8f13a1ff-0400-b9eb-b644-f1eb2a149498)
- [Manage Certificates for HPC Pack 2019 Cluster](/powershell/high-performance-computing/manage-hpc-pack-certificates)

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
