---
title: Troubleshoot the LoadBalancerInUseByVirtualMachineScaleSet or NetworkSecurityGroupInUseByVirtualMachineScaleSet error code
description: Learn how to troubleshoot the LoadBalancerInUseByVirtualMachineScaleSet or NetworkSecurityGroupInUseByVirtualMachineScaleSet error when you try to delete an Azure Kubernetes Service (AKS) cluster.
ms.date: 11/21/2024
editor: v-jsitser
ms.reviewer: rissing, chiragpa, edneto, jaewonpark, v-leedennis
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the LoadBalancerInUseByVirtualMachineScaleSet or NetworkSecurityGroupInUseByVirtualMachineScaleSet error code so that I can successfully delete an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
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

To fix this issue, use one of the following methods:

- Remove all public IP addresses that are associated with Azure Load Balancer. For more information, see [View, modify settings for, or delete a public IP address](/azure/virtual-network/ip-services/virtual-network-public-ip-address#view-modify-settings-for-or-delete-a-public-ip-address).

- Dissociate the NSG that's used by the subnet. For more information, see [Associate or dissociate a network security group](/azure/virtual-network/virtual-network-network-interface#associate-or-dissociate-a-network-security-group).

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
