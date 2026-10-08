---
title: Troubleshoot the InvalidResourceReference error code
description: Learn how to troubleshoot the InvalidResourceReference error when you try to create and deploy an Azure Kubernetes Service (AKS) cluster or update an AKS cluster.
ms.date: 09/16/2026
manager: dcscontentpm
ms.topic: troubleshooting
author: kaushika-msft
ms.author: kaushika
ms.reviewer: pinghe, shipu.yao, zhixinsun
ms.service: azure-kubernetes-service
#Customer intent: As an Azure Kubernetes user, I want to troubleshoot the InvalidResourceReference error code so that I can successfully create and deploy an Azure Kubernetes Service (AKS) cluster.
ms.custom: sap:Create, Upgrade, Scale and Delete operations (cluster or nodepool)
ai-usage: ai-assisted
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

    The example in [Symptom 1](#symptom-1) shows that the virtual network and the virtual machine scale set aren't in the same region. Because the resources are in different regions, you can't create the scale set instance.

- You manually modified or deleted the referenced resource.

### Solution 1

If a mismatch exists between resources in different regions, review the resources to ensure that they're in the same region. In this example, either modify the region where you build the AKS cluster or create a new virtual network in the same region.

If you manually modify or delete the referenced resource, you might encounter difficulties resolving this issue because the process doesn't support manually modifying the underlying IaaS resources in the *MC_* resource group. You might resolve this issue by recreating the deleted resource, reassociating it with the VMSS, and then triggering an update on the AKS cluster. However, this solution isn't supported, so success isn't guaranteed.

## Symptom 2

When you try to update an AKS cluster, you receive the following error message:

> Code="InvalidResourceReference"  
> Message="Resource  
> /subscriptions/*\<subscription-id-guid>*/resourceGroups/MC_MyResourceGroup/providers/Microsoft.Network/loadBalancers/kubernetes/frontendIPConfigurations/<frontendIP_ID> referenced by resource /subscriptions/*\<subscription-id-guid>*/resourceGroups/MC_MyResourceGroup/providers/Microsoft.Network/loadBalancers/kubernetes/**loadBalancingRules/<frontend_IP_rule> was not found.** Please make sure that the referenced resource exists, and that both resources are in the same region."  
> Message="Resource  
>
> Details=[]

### Cause 2 

This issue occurs if you manually modify the default outbound rule `aksOutboundRule` on the load balancer. This unexpected modification typically occurs when you update the outbound IP if you update the cluster without the `load-balancer-outbound-ips` parameter.

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

This issue occurs when you move the virtual network that was associated with the AKS cluster during cluster creation to another resource group or subscription. AKS and the underlying Virtual Machine Scale Set (VMSS) continue to reference the original virtual network resource ID. As a result, node pool operations that require VMSS updates fail because the virtual network can no longer be found at its original resource path.

Moving the virtual network of an AKS cluster isn't supported. As documented in [Move operation support for networking resources](/azure/azure-resource-manager/management/move-limitations/networking-move-limitations), if you move the virtual network for an AKS cluster, the AKS cluster stops working.

### Solution 3

There's no supported method to update an existing AKS cluster to reference the virtual network after you move it. Microsoft Support and the AKS product group can't modify the cluster's underlying network references.

To resolve the issue, create a new AKS cluster that references the virtual network in its current location, migrate your workloads to the new cluster, and then decommission the affected cluster.

## Symptom 4

An AKS managed Bastion operation fails with an `InvalidResourceReference` error that identifies a public IP address. 

The following is an example of the error message.

> Code="InvalidResourceReference"
>
> Message="The specified public IP address reference '\<public-ip-resource-id>' is invalid."

### Cause 4

The public IP reference has an invalid resource ID or resource type, or the public IP doesn't meet the subscription, region, SKU, IP version, or provisioning state requirements.

### Solution 4

Check the referenced public IP's **Properties** in the Azure portal.

You can also use the Azure CLI to check the public IP's properties.

Run the following command.

```azurecli
az network public-ip show --ids "<public-ip-resource-id>" --query "{id:id,location:location,sku:sku.name,version:publicIPAddressVersion,allocation:publicIPAllocationMethod,state:provisioningState,ipConfiguration:ipConfiguration.id}" --output json
```

Use a valid `Microsoft.Network/publicIPAddresses` resource ID in the same subscription as the cluster's network resources and the same region as the cluster. The public IP must use the Standard SKU and IPv4, and a customer-managed public IP must have a provisioning state of `Succeeded`.

For a new enable operation, pass the corrected ID to [az aks bastion enable](/cli/azure/aks/bastion#az-aks-bastion-enable). Confirm that managed Bastion is available for your cluster and that your installed `aks-preview` extension supports the command.

In Azure CLI, run the following command.

```azurecli
az aks bastion enable --subscription "<cluster-subscription-id>" --resource-group "<cluster-resource-group>" --name "<cluster-name>" --bastion-public-ip "<public-ip-resource-id>"
```

The `az aks bastion update` command doesn't support replacing an existing public IP binding. Changing the IP while Bastion exists or cleanup is incomplete can return `UpdateNotAllowed`. If you need to replace an existing binding, contact Microsoft Support for guidance.

For allocation and usage requirements, see [Azure Bastion public IP requirements](/azure/bastion/configuration-settings#public-ip-address).

## References

[General troubleshooting of AKS cluster creation issues](../create-upgrade-delete/troubleshoot-aks-cluster-creation-issues.md)

 
