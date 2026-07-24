---
title: Troubleshoot the InvalidResourceReference error code
description: Learn how to troubleshoot the InvalidResourceReference error when you try to create and deploy an Azure Kubernetes Service (AKS) cluster or update an AKS cluster.
ms.date: 07/24/2026
editor: v-jsitser
ms.reviewer: rissing, chiragpa, erbookbi, erifernandez, v-leedennis, v-weizhu
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the InvalidResourceReference error code so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
---
# Troubleshoot the InvalidResourceReference error code

## Summary

Use this article to troubleshoot the `InvalidResourceReference` error when you create, deploy, or update an Azure Kubernetes Service (AKS) cluster so you can complete the operation successfully.

## Symptom 1

When you try to create an AKS cluster, you receive the following error message:

> Code="InvalidResourceReference"
>
> Message="Resource  
> **/subscriptions/*\<subscription-id-guid>*/resourceGroups/MyResourceGroup/providers/Microsoft.Network/virtualNetworks/vnet-otcom/subnets/Subnet-AKS**  
> referenced by resource  
> **/subscriptions/*\<subscription-id-guid>*/resourceGroups/MC_MyResourceGroup_MyCluster-AKS_JAPANEAST/providers/Microsoft.Compute/virtualMachineScaleSets/aks-nodepool-vmss**  
> was not found. Please make sure that the referenced resource exists, and that both resources are in the same region."
>
> Details=[]

### Cause 1

Here are the possible causes of this issue:

- A mismatch exists between resources in different regions.

    The example in [Symptom 1](#symptom-1) shows that the virtual network and the virtual machine scale set aren't in the same region. Because the resources are in different regions, it's impossible to create the scale set instance.

- The referenced resource has been manually modified or deleted.

### Solution 1

If a mismatch exists between resources in different regions, review the resources to make sure that they're in the same region. In this example, either modify the region where the AKS cluster is being built, or create a new virtual network in the same region.

If the referenced resource has been manually modified or deleted, it might be difficult to resolve this issue because it's unsupported to manually modify the underlying IaaS resources in the *MC_* resource group. A possible solution might be to recreate the deleted resource, reassociate it with the VMSS, and then trigger an update on the AKS cluster. However, as this is an unsupported scenario, the success of this solution can't be guaranteed.

## Symptom 2

When you try to update an AKS cluster, you receive the following error message:

> Code="InvalidResourceReference"  
> Message="Resource  
> /subscriptions/*\<subscription-id-guid>*/resourceGroups/MC_MyResourceGroup/providers/Microsoft.Network/loadBalancers/kubernetes/frontendIPConfigurations/<frontendIP_ID> referenced by resource /subscriptions/*\<subscription-id-guid>*/resourceGroups/MC_MyResourceGroup/providers/Microsoft.Network/loadBalancers/kubernetes/**loadBalancingRules/<frontend_IP_rule> was not found.** Please make sure that the referenced resource exists, and that both resources are in the same region."  
> Message="Resource  
>
> Details=[]

### Cause 2 

This issue might occur if the default outbound rule "aksOutboundRule" on the load balancer is manually modified. This unexpected modification typically occurs when the outbound IP is updated if you update the cluster without the `load-balancer-outbound-ips` parameter.

### Solution 2

Rerun the `az aks update` command with the `load-balancer-outbound-ips` parameter to update your cluster. Use the resource ID of the public IP as the parameter value. For more information, see [Update the cluster with your own outbound public IP](/azure/aks/load-balancer-standard#update-the-cluster-with-your-own-outbound-public-ip).

## Symptom 3

When you create, scale, upgrade, or update a node pool, the operation fails with an `InvalidResourceReference` error message that resembles the following example:

> Code="InvalidResourceReference"  
> Message="Create or update VMSS  
> **/subscriptions/*\<subscription-id-guid>*/resourceGroups/MC_MyResourceGroup_MyCluster/providers/Microsoft.Compute/virtualMachineScaleSets/aks-nodepool-vmss**  
> failed. Resource  
> **/subscriptions/*\<subscription-id-guid>*/resourceGroups/*\<vnet-resource-group>*/providers/Microsoft.Network/virtualNetworks/*\<vnet-name>***  
> referenced by resource  
> **/subscriptions/*\<subscription-id-guid>*/resourceGroups/MC_MyResourceGroup_MyCluster/providers/Microsoft.Compute/virtualMachineScaleSets/aks-nodepool-vmss**  
> was not found."

### Cause 3

This issue occurs when the virtual network that was associated with the AKS cluster during cluster creation is moved to another resource group or subscription. AKS and the underlying Virtual Machine Scale Set (VMSS) continue to reference the original virtual network resource ID. As a result, node pool operations that require VMSS updates fail because the virtual network can no longer be found at its original resource path.

Moving the virtual network of an AKS cluster isn't supported. As documented in [Move operation support for networking resources](/azure/azure-resource-manager/management/move-limitations/networking-move-limitations), if you move the virtual network for an AKS cluster, the AKS cluster stops working.

### Solution 3

There's no supported method to update an existing AKS cluster to reference the virtual network after it's moved. Microsoft Support and the AKS product group can't modify the cluster's underlying network references.

To resolve the issue, create a new AKS cluster that references the virtual network in its current location, migrate your workloads to the new cluster, and then decommission the affected cluster.

## More information

[General troubleshooting of AKS cluster creation issues](../create-upgrade-delete/troubleshoot-aks-cluster-creation-issues.md)

 
