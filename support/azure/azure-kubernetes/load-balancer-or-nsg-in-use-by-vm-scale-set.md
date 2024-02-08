---
title: Troubleshoot the LoadBalancerInUseByVirtualMachineScaleSet or NetworkSecurityGroupInUseByVirtualMachineScaleSet error code
description: Learn how to troubleshoot the LoadBalancerInUseByVirtualMachineScaleSet or NetworkSecurityGroupInUseByVirtualMachineScaleSet error when you try to delete an Azure Kubernetes Service (AKS) cluster.
ms.date: 04/01/2022
editor: v-jsitser
ms.reviewer: rissing, chiragpa, edneto, v-leedennis
ms.service: azure-kubernetes-service
ms.subservice: troubleshoot-delete-operations
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the LoadBalancerInUseByVirtualMachineScaleSet or NetworkSecurityGroupInUseByVirtualMachineScaleSet error code so that I can successfully delete an Azure Kubernetes Service (AKS) cluster.
---
# Troubleshoot the LoadBalancerInUseByVirtualMachineScaleSet or NetworkSecurityGroupInUseByVirtualMachineScaleSet error code

This article discusses how to identify and resolve the `LoadBalancerInUseByVirtualMachineScaleSet` or `NetworkSecurityGroupInUseByVirtualMachineScaleSet` error that occurs when you try to delete a Microsoft Azure Kubernetes Service (AKS) cluster.

## Symptoms

When you try to delete an AKS cluster, you receive the following error message for `LoadBalancerInUseByVirtualMachineScaleSet`:

> internalErrorCode: "LoadBalancerInUseByVirtualMachineScaleSet"
>
> StatusCode=409
>
> {
>
> "Cannot delete load balancer .../Microsoft.Network/loadBalancers/kubernetes since its child resources aksOutboundBackendPool, kubernetes are in use by virtual machine scale set .../Microsoft.Compute/virtualMachineScaleSets/aks-worker-test-vmss"
>
> }

Or, you receive the following error message for `NetworkSecurityGroupInUseByVirtualMachineScaleSet`:

> internalErrorCode: "NetworkSecurityGroupInUseByVirtualMachineScaleSet"
>
> StatusCode=409
>
> {
>
> "Cannot delete network security group .../Microsoft.Network/networkSecurityGroups/aks-agentpool since it is in use by virtual machine scale set .../Microsoft.Compute/virtualMachineScaleSets/aks-vmss"
>
> }

## Cause

You tried to delete an AKS cluster while the virtual machine scale set was still using the associated public IP address or network security group (NSG).

## Solution

Remove all public IP addresses that are associated with the subnet, and remove the NSG that's used by the subnet. For more information, see [Delete the front-end IP configuration used by the virtual machine scale set](/azure/load-balancer/update-load-balancer-with-vm-scale-set#delete-the-front-end-ip-configuration-used-by-the-virtual-machine-scale-set).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
